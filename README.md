# Censos del Perú y ubigeo: departamentos, provincias y distritos (1981–2025)

Base de datos armonizada sobre la **presencia de cada unidad territorial** (departamento, provincia y distrito) en los censos nacionales de población del Perú de **1981, 1993, 2007, 2017 y 2025**, con su **código de ubigeo** y su **fecha y dispositivo legal de creación**.

El objetivo es facilitar el empalme de microdatos censales entre años, por ejemplo para construir paneles distritales o tener en cuenta la creación de distritos nuevos.

## Estado del proyecto

| Etapa | Descripción | Estado |
|---|---|---|
| 1 | Unidades existentes en el Censo 2025 (marco de referencia) | ✅ |
| 2 | Fecha de creación y dispositivo legal de cada unidad | ⏳ |
| 3 | Presencia en los censos 2017 y 2007 | ⏳ |
| 4 | Presencia en los censos 1993 y 1981 | ⏳ |
| 5 | Unidades desaparecidas, fusionadas o recodificadas (tabla de equivalencias) | ⏳ |

## Unidades en el Censo 2025

| Nivel | N.º |
|---|---:|
| Departamentos* | 25 |
| Provincias | 196 |
| Distritos | 1 892 |

\* Incluye la Provincia Constitucional del Callao (07). Lima (15) agrupa Lima Metropolitana (provincia 1501) y Lima Provincias.

## Estructura

```
data/
  raw/
    ubigeo_censo2025.xlsx          # listado de ubigeos del Censo 2025 (INEI)
  processed/
    unidades_2025.csv              # los 3 niveles, formato largo
    distritos_2025.csv             # un distrito por fila, con nombres de dep. y prov.
    unidades_territoriales.csv     # tabla maestra (se completa por etapas)
scripts/
  01_unidades_2025.py
```

## Diccionario de la tabla maestra (`unidades_territoriales.csv`)

| Variable | Descripción |
|---|---|
| `ubigeo` | Código de 6 dígitos (DDPPdd) según el Censo 2025. Se lee siempre como texto para conservar los ceros iniciales. |
| `nivel` | `departamento`, `provincia` o `distrito` |
| `ubigeo_padre` | Ubigeo de la unidad inmediatamente superior |
| `nombre` | Nombre tal como aparece en la fuente |
| `nombre_norm` | Nombre en mayúsculas, sin tildes (conserva la Ñ), para hacer cruces |
| `fecha_creacion` | Fecha de creación (AAAA-MM-DD) |
| `dispositivo_legal` | Ley o decreto de creación |
| `censo_AAAA` | 1 si la unidad existía (fue empadronada) en ese censo, 0 si no |

## Reproducir

```bash
pip install -r requirements.txt
python scripts/01_unidades_2025.py
```

## Notas

- Los ubigeos del INEI han cambiado entre censos (por ejemplo, distritos recodificados al pasar a una provincia nueva). Por eso el código 2025 funciona como identificador de referencia y las equivalencias con códigos anteriores se documentarán en la etapa 5.
- Fuentes: INEI (Censos Nacionales), Sistema de Información sobre Demarcación Territorial de la PCM y normas legales publicadas en *El Peruano*.
