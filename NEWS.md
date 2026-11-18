# historicubigeo 1.0.0

First stable release (18/11/2026).

## Datasets

* `departments`, `provinces`, `districts`: the 25 departments, 196 provinces
  and 1,892 districts of the 2025 Census, with their INEI UBIGEO code, date
  and legal instrument of creation, and presence at the 1981, 1993, 2007,
  2017 and 2025 censuses. `districts` also says whether each census's data
  have a record for the district (`enumerated_YYYY`) and gives the census's
  own code (`code_YYYY`).
* `census_population`, `census_population_totals`: population by sex and area
  (urban/rural) of every district, province and department in each census,
  1981-2025.
* `ubigeo_crosswalk`: census district codes linked to the 2025 districts,
  with parents from the creation laws and harmonised units (`unit_YYYY`,
  `unit_YYYY_strict`) to compare censuses on the same boundaries.
* Source tables: `inei1997_departments`, `inei1997_provinces`,
  `inei1997_districts`, `inei1999_districts`, `division_counts`,
  `inei_provinces_created`, `inei_districts_created`,
  `inei_district_origins`, `districts_created_2020_2025`, `geosdot_norms`.

## Checks run by the build

* Presence coded from creation dates reproduces INEI's national counts of
  provinces and districts at every census, and the national and department
  counts at 31/12/2021.
* It agrees with the districts in each census's own data for every district
  in 2017; the differences in 1981, 1993 and 2007 are documented.
* Population: sex and area add up to the total; districts, provinces and
  departments add up to the same national total; 2007 and 2017 match INEI's
  published figures.
* The crosswalk's law origins equal `inei_district_origins`, and every
  law-based parent is one of them.

## Known limitations

* 1981 population comes from a weighted sample and leaves out Apurímac,
  Loreto and San Martín.
* Four units have no creation data: the Constitutional Province of Callao and
  the districts of Urcos, Anco (Churcampa) and Magdalena de Cao.
* The parents of Sangani, Alto Trujillo and Santa Rosa de Loreto (created
  after 2021) and of La Peca are inferred from population, not from law.
* Disagreements between sources on creation dates are recorded in `note`,
  not resolved.
