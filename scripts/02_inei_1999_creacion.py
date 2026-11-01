"""
02_inei_1999_creacion.py
------------------------
Lee los cuadros "Dispositivo legal de creación, población total, superficie,
densidad poblacional y población electoral de los distritos: 1999" de

  INEI (1999). Perú: Directorio Nacional de Municipalidades Provinciales y
  Distritales 1999. Lima: INEI.
  https://proyectos.inei.gob.pe/web/biblioineipub/bancopub/Est/Lib0362/indice.htm

y los empalma con los ubigeos del Censo 2025.

Entrada : data/raw/inei_lib0362/dis-<depto>.txt  (texto copiado de dis-<depto>.htm)
Salidas : data/processed/inei1999_creacion_distritos.csv
          data/processed/unidades_territoriales.csv (actualiza fecha_creacion,
                                                     dispositivo_legal y fuente)

Uso: python scripts/02_inei_1999_creacion.py
"""

from pathlib import Path
import re
import sys

import pandas as pd

sys.path.insert(0, str(Path(__file__).resolve().parent))
from importlib import import_module

normalizar = import_module("01_unidades_2025").normalizar

ROOT = Path(__file__).resolve().parents[1]
RAW = ROOT / "data" / "raw" / "inei_lib0362"
OUT = ROOT / "data" / "processed"

# Archivo -> código de departamento (ubigeo 2025)
DEPARTAMENTOS = {
    "amaz": "01", "anca": "02", "apur": "03", "areq": "04", "ayac": "05",
    "caja": "06", "call": "07", "cusc": "08", "huav": "09", "huan": "10",
    "ica": "11", "juni": "12", "libe": "13", "lamb": "14", "lima": "15",
    "lore": "16", "madr": "17", "moqu": "18", "pasc": "19", "piur": "20",
    "puno": "21", "smar": "22", "tacn": "23", "tumb": "24", "ucay": "25",
}

MESES = {"ENE": 1, "FEB": 2, "MAR": 3, "ABR": 4, "MAY": 5, "JUN": 6, "JUL": 7,
         "AGO": 8, "SET": 9, "SEP": 9, "OCT": 10, "NOV": 11, "DIC": 12}

# Nombres 1999 que cambiaron o difieren en la fuente 2025: (depto, prov_norm, dist_norm_1999) -> dist_norm_2025
EQUIV_DISTRITOS = {
    ("15", "LIMA", "MAGDALENA VIEJA"): "PUEBLO LIBRE",
    ("15", "HUAROCHIRI", "LARAOS"): "SAN PEDRO DE LARAOS",
    ("15", "YAUYOS", "AYAUCA"): "ALLAUCA",
}

# Valores de la fuente que parecen errados; se conservan pero se marcan.
OBSERVACIONES = {
    ("15", "HUARAL", "VEINTISIETE DE NOVIEMBRE"):
        "N.º de ley (17702) inconsistente con la fecha (1957); posiblemente Ley 12702.",
}


def arreglar_mojibake(s: str) -> str:
    try:
        return s.encode("cp1252").decode("utf-8")
    except (UnicodeEncodeError, UnicodeDecodeError):
        return s


def numero(s: str):
    s = s.strip()
    if s in {"", "-"}:
        return None
    return float(s.replace(",", "."))


def fecha(s: str):
    m = re.fullmatch(r"(\d{1,2}) ([A-Z]{3}) (\d{4})", s.strip())
    if not m:
        return None
    d, mes, a = m.groups()
    return f"{a}-{MESES[mes]:02d}-{int(d):02d}"


def parsear(path: Path, cod_dep: str) -> pd.DataFrame:
    lineas = [arreglar_mojibake(l.rstrip("\n")) for l in path.read_text(encoding="utf-8").splitlines()]
    # Empieza después de la fila TOTAL y sus 4 cifras
    i = next(k for k, l in enumerate(lineas) if l.startswith("TOTAL\t")) + 5
    filas, provincia = [], None
    while i < len(lineas):
        l = lineas[i]
        if not l.strip():
            i += 1
            continue
        if re.match(r"^(A/|\d/|FUENTE)", l.strip()):
            break
        if l.count("\t") >= 3:                     # fila de provincia
            provincia = l.split("\t")[0].strip()
            i += 5
            continue
        nombre = l.split("\t")[0].strip()        # fila de distrito: 8 líneas
        tipo, num, fch, pob, sup, dens, elec = (x.strip() for x in lineas[i + 1:i + 8])
        filas.append({
            "cod_dep": cod_dep,
            "provincia_1999": provincia,
            "distrito_1999": nombre,
            "dispositivo_tipo": None if tipo == "-" else tipo,
            "dispositivo_numero": None if num == "-" else num,
            "fecha_texto": fch,
            "fecha_creacion": fecha(fch),
            "epoca_independencia": int(fch.upper().startswith("EPOCA INDEP")),
            "poblacion_1998": numero(pob),
            "superficie_km2": numero(sup),
            "densidad": numero(dens),
            "poblacion_electoral_1999": numero(elec),
        })
        i += 8
    return pd.DataFrame(filas)


def empalmar(inei: pd.DataFrame, u25: pd.DataFrame) -> pd.DataFrame:
    prov = u25[u25.nivel == "provincia"][["ubigeo", "cod_dep", "nombre_norm"]]
    prov = prov.rename(columns={"ubigeo": "ubigeo_prov", "nombre_norm": "prov_norm"})
    dist = u25[u25.nivel == "distrito"][["ubigeo", "ubigeo_padre", "nombre_norm"]]

    inei = inei.copy()
    inei["prov_norm"] = inei.provincia_1999.map(normalizar)
    inei["dist_norm"] = inei.distrito_1999.map(normalizar)
    inei["dist_norm_2025"] = [
        EQUIV_DISTRITOS.get((d, p, n), n)
        for d, p, n in zip(inei.cod_dep, inei.prov_norm, inei.dist_norm)
    ]
    inei = inei.merge(prov, on=["cod_dep", "prov_norm"], how="left")
    inei = inei.merge(
        dist, left_on=["ubigeo_prov", "dist_norm_2025"],
        right_on=["ubigeo_padre", "nombre_norm"], how="left",
    )
    # Distrito capital: en 1999 se lista con el nombre de la ciudad (p. ej. HUACHO, MATUCANA);
    # en 2025 se codifica como DDPP01. Si no hubo match por nombre, se intenta solo para la
    # primera fila de cada provincia.
    primera = ~inei.duplicated(["cod_dep", "prov_norm"])
    faltan = inei.ubigeo.isna() & primera & inei.ubigeo_prov.notna()
    inei.loc[faltan, "ubigeo"] = inei.loc[faltan, "ubigeo_prov"].str[:4] + "01"
    inei.loc[faltan, "match"] = "capital (DDPP01)"
    inei["match"] = inei["match"].fillna(inei.ubigeo.notna().map({True: "nombre", False: "sin match"}))

    inei["observacion"] = [
        OBSERVACIONES.get((d, p, n)) for d, p, n in zip(inei.cod_dep, inei.prov_norm, inei.dist_norm)
    ]
    cols = ["ubigeo", "match", "cod_dep", "provincia_1999", "distrito_1999",
            "dispositivo_tipo", "dispositivo_numero", "fecha_texto", "fecha_creacion",
            "epoca_independencia", "poblacion_1998", "superficie_km2", "densidad",
            "poblacion_electoral_1999", "observacion"]
    return inei[cols]


def main() -> None:
    u25 = pd.read_csv(OUT / "unidades_2025.csv", dtype=str)
    partes = []
    for cod, dep in DEPARTAMENTOS.items():
        f = RAW / f"dis-{cod}.txt"
        if f.exists():
            partes.append(parsear(f, dep))
    inei = empalmar(pd.concat(partes, ignore_index=True), u25)
    inei.to_csv(OUT / "inei1999_creacion_distritos.csv", index=False, encoding="utf-8")

    # Actualiza la tabla maestra
    m = pd.read_csv(OUT / "unidades_territoriales.csv", dtype=str)
    for c in ["fuente_creacion", "epoca_independencia", "observacion"]:
        if c not in m:
            m[c] = pd.NA
    ok = inei[inei.ubigeo.notna()].set_index("ubigeo")
    disp = (ok.dispositivo_tipo.fillna("") + " " + ok.dispositivo_numero.fillna("")).str.strip()
    disp = disp.replace({"": pd.NA})
    idx = m.ubigeo.isin(ok.index)
    m.loc[idx, "fecha_creacion"] = m.loc[idx, "ubigeo"].map(ok.fecha_creacion)
    m.loc[idx, "dispositivo_legal"] = m.loc[idx, "ubigeo"].map(disp)
    m.loc[idx, "epoca_independencia"] = m.loc[idx, "ubigeo"].map(ok.epoca_independencia).astype("Int64")
    m.loc[idx, "fuente_creacion"] = "INEI 1999"
    m.loc[idx, "observacion"] = m.loc[idx, "ubigeo"].map(ok.observacion)
    m.to_csv(OUT / "unidades_territoriales.csv", index=False, encoding="utf-8")

    print(inei.match.value_counts().to_string())
    print(inei[inei.match == "sin match"][["provincia_1999", "distrito_1999"]].to_string())


if __name__ == "__main__":
    main()
