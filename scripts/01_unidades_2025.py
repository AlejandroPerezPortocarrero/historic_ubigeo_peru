"""
01_unidades_2025.py
-------------------
Identifica las unidades territoriales (departamentos, provincias y distritos)
existentes en el Censo 2025 a partir del listado de ubigeos del INEI.

Entrada : data/raw/ubigeo_censo2025.xlsx
Salidas : data/processed/unidades_2025.csv      (formato largo, los 3 niveles)
          data/processed/distritos_2025.csv     (formato ancho, un distrito por fila)
          data/processed/unidades_territoriales.csv (tabla maestra con columnas
                                                     para censos y fechas de creación)

Uso: python scripts/01_unidades_2025.py
"""

from pathlib import Path
import unicodedata

import pandas as pd

ROOT = Path(__file__).resolve().parents[1]
RAW = ROOT / "data" / "raw" / "ubigeo_censo2025.xlsx"
OUT = ROOT / "data" / "processed"

CENSOS = [1981, 1993, 2007, 2017, 2025]


def normalizar(nombre: str) -> str:
    """Mayúsculas, sin tildes ni espacios redundantes (conserva la Ñ)."""
    nombre = " ".join(str(nombre).upper().split())
    nombre = nombre.replace("Ñ", "\0")
    nombre = "".join(
        c for c in unicodedata.normalize("NFD", nombre) if unicodedata.category(c) != "Mn"
    )
    return nombre.replace("\0", "Ñ")


def nivel(ubigeo: str) -> str:
    if ubigeo[2:] == "0000":
        return "departamento"
    if ubigeo[4:] == "00":
        return "provincia"
    return "distrito"


def leer_2025() -> pd.DataFrame:
    df = pd.read_excel(RAW, dtype=str, header=0)
    df.columns = ["ubigeo", "nombre"]
    df = df.dropna(subset=["ubigeo"])
    df["ubigeo"] = df["ubigeo"].str.strip()
    df = df[df["ubigeo"].str.fullmatch(r"\d{6}")].copy()
    df["nombre"] = df["nombre"].str.strip()
    df["nombre_norm"] = df["nombre"].map(normalizar)
    df["nivel"] = df["ubigeo"].map(nivel)
    df["cod_dep"] = df["ubigeo"].str[:2]
    df["cod_prov"] = df["ubigeo"].str[:4].where(df["nivel"] != "departamento")
    return df


def validar(df: pd.DataFrame) -> None:
    assert df["ubigeo"].is_unique, "Ubigeos duplicados"
    codigos = set(df["ubigeo"])
    prov = df[df.nivel == "provincia"]
    dist = df[df.nivel == "distrito"]
    assert all(c + "0000" in codigos for c in prov.cod_dep), "Provincia sin departamento"
    assert all(c + "00" in codigos for c in dist.cod_prov), "Distrito sin provincia"
    sin_dist = set(prov.cod_prov) - set(dist.cod_prov)
    assert not sin_dist, f"Provincias sin distritos: {sin_dist}"


def main() -> None:
    df = leer_2025()
    validar(df)

    deps = df[df.nivel == "departamento"].set_index("cod_dep")["nombre"]
    provs = df[df.nivel == "provincia"].set_index("cod_prov")["nombre"]

    # Formato largo
    largo = df[["ubigeo", "nivel", "cod_dep", "cod_prov", "nombre", "nombre_norm"]].copy()
    largo["ubigeo_padre"] = largo.apply(
        lambda r: None if r.nivel == "departamento"
        else (r.cod_dep + "0000" if r.nivel == "provincia" else r.cod_prov + "00"),
        axis=1,
    )
    largo.to_csv(OUT / "unidades_2025.csv", index=False, encoding="utf-8")

    # Formato ancho (distritos)
    dist = df[df.nivel == "distrito"].copy()
    ancho = pd.DataFrame({
        "ubigeo": dist["ubigeo"],
        "cod_dep": dist["cod_dep"],
        "departamento": dist["cod_dep"].map(deps),
        "cod_prov": dist["cod_prov"],
        "provincia": dist["cod_prov"].map(provs),
        "distrito": dist["nombre"],
    })
    ancho.to_csv(OUT / "distritos_2025.csv", index=False, encoding="utf-8")

    # Tabla maestra: se irá completando en los siguientes pasos
    maestra = largo[["ubigeo", "nivel", "ubigeo_padre", "nombre", "nombre_norm"]].copy()
    maestra["fecha_creacion"] = pd.NA       # AAAA-MM-DD
    maestra["dispositivo_legal"] = pd.NA    # p.ej. "Ley N° 12345"
    for c in CENSOS:
        maestra[f"censo_{c}"] = pd.NA       # 1 = existe, 0 = no existe
    maestra["censo_2025"] = 1
    maestra.to_csv(OUT / "unidades_territoriales.csv", index=False, encoding="utf-8")

    print(df["nivel"].value_counts().reindex(["departamento", "provincia", "distrito"]).to_string())


if __name__ == "__main__":
    main()
