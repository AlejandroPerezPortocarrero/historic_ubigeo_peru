#' Departments of Peru (Census 2025)
#'
#' Departments in the 2025 Census, identified by their INEI UBIGEO code, with
#' their creation data and presence in each census. Includes the
#' Constitutional Province of Callao (`070000`).
#'
#' @format A tibble with 25 rows and 13 variables:
#' \describe{
#'   \item{inei}{UBIGEO (INEI, Census 2025), 6-character string}
#'   \item{department}{Name of the department}
#'   \item{created_date}{Date of creation (`Date`). Date of the instrument for INEI 1997 and INEI 1999;
#'     publication date for INEI 2020 provinces; date listed by JNE 2021 /
#'     Congreso 2025. `NA` when only the year is known.}
#'   \item{created_year}{Year of creation}
#'   \item{legal_instrument}{Type and number of the legal instrument of creation (e.g. `"LEY 15246"`)}
#'   \item{independence_era}{`TRUE` if the source dates the unit to the Independence era (no instrument of creation)}
#'   \item{creation_source}{Source(s) of the creation data: `"INEI 1997"` (departments; law date of districts created 1990-97), `"INEI 1999"`, `"INEI 2020"`, `"INEI 2022"`, `"JNE 2021"`, `"Congreso 2025"`, `"GEOSDOT"`}
#'   \item{note}{Warnings about the data (possible errors in the source)}
#'   \item{census_1981,census_1993,census_2007,census_2017,census_2025}{1 if the unit
#'     existed at the census date, 0 if it was created afterwards. See Details.}
#' }
#' @details
#' **Census presence.** A unit is coded as present in a census when it had
#' been created before the census date (12/07/1981, 11/07/1993, 21/10/2007,
#' 22/10/2017). Units not listed as created between 1981 and 2025 in the
#' sources existed before the 1981 Census. The coding reproduces exactly the
#' national counts of provinces and districts published by INEI (2020) for each
#' census, and the national and department counts at 31/12/2021 published by
#' INEI (2022). Presence refers to the unit as identified in 2025: units that were
#' split, merged or moved between departments keep their 2025 identity, and
#' units abolished before 2025 are not included. See
#' `vignette("construction", package = "ubigeocensos")`.
#' @source INEI, list of UBIGEO codes of the 2025 Census; INEI (1997), see
#'   [inei1997_departments].
"departments"

#' Provinces of Peru (Census 2025)
#'
#' Provinces in the 2025 Census, identified by their INEI UBIGEO code, with
#' their creation data and presence in each census.
#'
#' @format A tibble with 196 rows and 14 variables:
#' \describe{
#'   \item{inei}{UBIGEO (INEI, Census 2025), 6-character string}
#'   \item{department}{Name of the department}
#'   \item{province}{Name of the province}
#'   \item{created_date}{Date of creation (`Date`). Date of the instrument for INEI 1997 and INEI 1999;
#'     publication date for INEI 2020 provinces; date listed by JNE 2021 /
#'     Congreso 2025. `NA` when only the year is known.}
#'   \item{created_year}{Year of creation}
#'   \item{legal_instrument}{Type and number of the legal instrument of creation (e.g. `"LEY 15246"`)}
#'   \item{independence_era}{`TRUE` if the source dates the unit to the Independence era (no instrument of creation)}
#'   \item{creation_source}{Source(s) of the creation data: `"INEI 1997"` (departments; law date of districts created 1990-97), `"INEI 1999"`, `"INEI 2020"`, `"INEI 2022"`, `"JNE 2021"`, `"Congreso 2025"`, `"GEOSDOT"`}
#'   \item{note}{Warnings about the data (possible errors in the source)}
#'   \item{census_1981,census_1993,census_2007,census_2017,census_2025}{1 if the unit
#'     existed at the census date, 0 if it was created afterwards. See Details.}
#' }
#' @details
#' **Census presence.** A unit is coded as present in a census when it had
#' been created before the census date (12/07/1981, 11/07/1993, 21/10/2007,
#' 22/10/2017). Units not listed as created between 1981 and 2025 in the
#' sources existed before the 1981 Census. The coding reproduces exactly the
#' national counts of provinces and districts published by INEI (2020) for each
#' census, and the national and department counts at 31/12/2021 published by
#' INEI (2022). Presence refers to the unit as identified in 2025: units that were
#' split, merged or moved between departments keep their 2025 identity, and
#' units abolished before 2025 are not included. See
#' `vignette("construction", package = "ubigeocensos")`.
#' @source INEI, list of UBIGEO codes of the 2025 Census; INEI (1999), see
#'   [inei1999_districts]; INEI (2020) and INEI (2022), see [division_counts];
#'   JNE (2021) and Congreso de la República (2025), see
#'   [districts_created_2020_2025]; PCM-SDOT (GEOSDOT), see [geosdot_norms].
"provinces"

#' Districts of Peru (Census 2025)
#'
#' Districts in the 2025 Census, identified by their INEI UBIGEO code, with
#' their creation date, legal instrument of creation and presence in each census.
#'
#' @format A tibble with 1,892 rows and 24 variables:
#' \describe{
#'   \item{inei}{UBIGEO (INEI, Census 2025), 6-character string}
#'   \item{department}{Name of the department}
#'   \item{province}{Name of the province}
#'   \item{district}{Name of the district}
#'   \item{created_date}{Date of creation (`Date`). Date of the instrument for INEI 1997 and INEI 1999;
#'     publication date for INEI 2020 provinces; date listed by JNE 2021 /
#'     Congreso 2025. `NA` when only the year is known.}
#'   \item{created_year}{Year of creation}
#'   \item{legal_instrument}{Type and number of the legal instrument of creation (e.g. `"LEY 15246"`)}
#'   \item{independence_era}{`TRUE` if the source dates the unit to the Independence era (no instrument of creation)}
#'   \item{creation_source}{Source(s) of the creation data: `"INEI 1997"` (departments; law date of districts created 1990-97), `"INEI 1999"`, `"INEI 2020"`, `"INEI 2022"`, `"JNE 2021"`, `"Congreso 2025"`, `"GEOSDOT"`}
#'   \item{note}{Warnings about the data (possible errors in the source)}
#'   \item{census_1981,census_1993,census_2007,census_2017,census_2025}{1 if the unit
#'     existed at the census date, 0 if it was created afterwards. See Details.}
#'   \item{enumerated_1981,enumerated_1993,enumerated_2007,enumerated_2017,enumerated_2025}{1
#'     if that census's data have a district record that [ubigeo_crosswalk]
#'     links to this district, 0 if not, `NA` where the census data are not
#'     available (1981: Apurímac, Loreto and San Martín). See Details.}
#'   \item{code_1981,code_1993,code_2007,code_2017}{UBIGEO code(s) used by that
#'     census for the district (codes separated by `;` where several 1981
#'     districts are linked to it)}
#' }
#' @details
#' **Census presence.** A unit is coded as present in a census when it had
#' been created before the census date (12/07/1981, 11/07/1993, 21/10/2007,
#' 22/10/2017). Units not listed as created between 1981 and 2025 in the
#' sources existed before the 1981 Census. The coding reproduces exactly the
#' national counts of provinces and districts published by INEI (2020) for each
#' census, and the national and department counts at 31/12/2021 published by
#' INEI (2022). Presence refers to the unit as identified in 2025: units that were
#' split, merged or moved between departments keep their 2025 identity, and
#' units abolished before 2025 are not included. See
#' `vignette("construction", package = "ubigeocensos")`.
#'
#' **Census data.** `enumerated_YYYY` and `code_YYYY` come from the districts
#' that actually appear in each census's data ([census_population]), linked to
#' 2025 by [ubigeo_crosswalk]. They agree with `census_YYYY` for every district
#' in 2017; the few differences in 1981, 1993 and 2007 are listed in the
#' vignette (Yauyos counted as one unit in 1981, Carmen Alto counted under
#' Ayacucho in 2007, the Bagua/La Peca succession, and code 160111 in 1993).
#' @source INEI, list of UBIGEO codes of the 2025 Census; INEI (1999), see
#'   [inei1999_districts]; INEI (2020) and INEI (2022), see [division_counts];
#'   JNE (2021) and Congreso de la República (2025), see
#'   [districts_created_2020_2025]; PCM-SDOT (GEOSDOT), see [geosdot_norms];
#'   census data, see [census_population].
"districts"

#' Legal creation of departments, INEI 1997
#'
#' Cuadro 1.16 of the INEI *Compendio Estadístico 1996-97*, "Perú: Superficie,
#' población, densidad poblacional y dispositivo de creación, según
#' departamento, 1997", matched to the 2025 UBIGEO. For the departments listed
#' in the 1821-1822 founding regulations, the date is that of the regulation,
#' and the footnotes record later renamings and re-creations (e.g. Huaylas →
#' Áncash, Tarma → Junín, Trujillo → La Libertad, Huamanga → Ayacucho, and
#' Moquegua, re-created by Law 8230 of 1936).
#'
#' @format A tibble with 25 rows and 10 variables:
#' \describe{
#'   \item{inei}{UBIGEO (INEI, Census 2025) of the department}
#'   \item{department_1997}{Name as published}
#'   \item{instrument_type}{Type of instrument as published: LEY, DECRETO,
#'     REGLTO.PROVISIONAL (Reglamento Provisional, 12/02/1821), REGLTO.DE
#'     ELECCIONES (Reglamento Provisional de Elecciones, 26/04/1822)}
#'   \item{instrument_number}{Number of the instrument (`S/N` = unnumbered; `NA` if not applicable)}
#'   \item{date_text}{Date as published (e.g. `"21 NOV 1832"`)}
#'   \item{created_date}{Date of the instrument (`Date`)}
#'   \item{surface}{Surface in km2, as at 30/06/1997}
#'   \item{pop_1997}{Projected population at 30/06/1997}
#'   \item{pop_density_1997}{Population density (inhabitants per km2)}
#'   \item{footnote}{Footnote of the source, in Spanish (renamings, re-creations)}
#' }
#' @source Instituto Nacional de Estadística e Informática (1997). *Compendio
#'   Estadístico 1996-97*. Lima: INEI. Cuadro 1.16.
#'   <https://proyectos.inei.gob.pe/web/biblioineipub/bancopub/Est/LIB0170/N02/iecaa016.htm>
"inei1997_departments"

#' Provinces created 1990-1997, INEI 1997
#'
#' Cuadro 1.18 of the INEI *Compendio Estadístico 1996-97*, "Perú: Categoría de
#' la capital legal y ley de creación de nuevas provincias, según región y
#' departamento, 1990 - 97", matched to the 2025 UBIGEO. It gives the date of
#' the law (INEI 2020/2022 give its publication date, see
#' [inei_provinces_created]), and the legal capital and its category.
#'
#' @format A tibble with 11 rows and 10 variables:
#' \describe{
#'   \item{inei}{UBIGEO (2025) of the province}
#'   \item{region}{Region in 1997 (the transitional regions of the 1990s)}
#'   \item{department,province}{Names as published}
#'   \item{capital}{Legal capital}
#'   \item{category}{Category of the capital: CIUDAD, VILLA or PUEBLO}
#'   \item{law_number}{Number of the law of creation}
#'   \item{date_text}{Date of the law as published (e.g. `"05-ENE-95"`)}
#'   \item{date}{Date of the law (`Date`)}
#'   \item{note}{Inconsistencies with INEI (2020): the law date of Yarowilca
#'     (09/06/1995) is after its publication date (01/06/1995), and that of El
#'     Dorado (08/11/1992) is a month before it (09/12/1992)}
#' }
#' @source Instituto Nacional de Estadística e Informática (1997). *Compendio
#'   Estadístico 1996-97*. Lima: INEI. Cuadros 1.18 and 1.19.
#'   <https://proyectos.inei.gob.pe/web/biblioineipub/bancopub/Est/LIB0170/n00.htm>
"inei1997_provinces"

#' Districts created 1990-1997, INEI 1997
#'
#' Cuadro 1.19 of the INEI *Compendio Estadístico 1996-97*, "Perú: Categoría de
#' la capital legal y ley de creación de nuevos distritos, según región y
#' provincia, 1990 - 97", matched to the 2025 UBIGEO. It gives the date of the
#' law, which [inei_districts_created] lacks (year only), and the legal capital
#' and its category. Huayrapata and Tilali, created in 1991 together with the
#' province of Moho (Law 25360), are not in the table.
#'
#' @format A tibble with 34 rows and 11 variables:
#' \describe{
#'   \item{inei}{UBIGEO (2025) of the district}
#'   \item{region}{Region in 1997}
#'   \item{department,province,district}{Names as published}
#'   \item{capital}{Legal capital}
#'   \item{category}{Category of the capital: CIUDAD, VILLA or PUEBLO}
#'   \item{law_number}{Number of the law of creation}
#'   \item{date_text}{Date of the law as published}
#'   \item{date}{Date of the law (`Date`)}
#'   \item{note}{Inconsistencies with INEI (2020/2022): Laberinto has Law
#'     26346 here and Law 26349 there}
#' }
#' @source Instituto Nacional de Estadística e Informática (1997). *Compendio
#'   Estadístico 1996-97*. Lima: INEI. Cuadros 1.18 and 1.19.
#'   <https://proyectos.inei.gob.pe/web/biblioineipub/bancopub/Est/LIB0170/n00.htm>
"inei1997_districts"

#' Legal creation of districts, INEI 1999
#'
#' Table X.3 of the INEI *Directorio Nacional de Municipalidades Provinciales y
#' Distritales 1999*, "Dispositivo legal de creación, población total,
#' superficie, densidad poblacional y población electoral de los distritos:
#' 1999", parsed and matched to the 2025 UBIGEO. Only departments whose
#' tables have been added to `data-raw/inei_lib0362/` are included.
#'
#' @format A tibble with one row per district and 14 variables:
#' \describe{
#'   \item{inei}{UBIGEO (INEI, Census 2025) of the matching district}
#'   \item{dept}{Two-digit department code}
#'   \item{province_1999,district_1999}{Names as published in 1999}
#'   \item{instrument_type}{Type of legal instrument (LEY, DECRETO, DECRETO LEY, LEY REGIONAL)}
#'   \item{instrument_number}{Number of the instrument (`S/N` = unnumbered)}
#'   \item{date_text}{Date as published (e.g. `"02 ENE 1857"`, `"EPOCA INDEP."`)}
#'   \item{created_date}{Date of creation, ISO 8601 string}
#'   \item{independence_era}{`TRUE` if published as "EPOCA INDEP."}
#'   \item{pop_1998}{Total population at 30/06/1998}
#'   \item{surface}{Surface in km2}
#'   \item{pop_density_1998}{Population density (inhabitants per km2)}
#'   \item{electoral_pop_1999}{Electoral population at 04/01/1999 (RENIEC)}
#'   \item{note}{Warnings about the data}
#' }
#' @source Instituto Nacional de Estadística e Informática (1999). *Perú:
#'   Directorio Nacional de Municipalidades Provinciales y Distritales 1999*.
#'   Lima: INEI.
#'   <https://proyectos.inei.gob.pe/web/biblioineipub/bancopub/Est/Lib0362/indice.htm>
"inei1999_districts"

#' Number of departments, provinces and districts at each census, INEI 2020 and 2022
#'
#' Cuadros 1 and 2 of the "División política y administrativa" chapter of INEI
#' (2020), updated to 31/12/2021 in Anexo 2 of INEI (2022): "Perú: División
#' político administrativa, según fecha censal del período 1940-2017 y
#' actualizada al 31 de diciembre de 2021" (national rows) and the same table
#' by department. Department rows follow the demarcation in force at the end
#' of the reference year (2019 in INEI 2020, 2021 in INEI 2022).
#'
#' @format A tibble with 235 rows and 9 variables:
#' \describe{
#'   \item{level}{`"national"` or `"department"`}
#'   \item{inei}{UBIGEO (2025) of the department; `NA` for national rows}
#'   \item{department}{Name as published}
#'   \item{census_year}{Census year; `NA` for the 31/12/2019 and 31/12/2021 rows}
#'   \item{date}{Census date, 2019-12-31 or 2021-12-31}
#'   \item{n_departments}{Number of departments (national rows; excludes Callao)}
#'   \item{n_provinces}{Number of provinces (includes Callao)}
#'   \item{n_districts}{Number of districts}
#'   \item{source}{`"INEI 2020; INEI 2022"` when both editions report the
#'     figure (they agree in every case), `"INEI 2022"` otherwise}
#' }
#' @details The national and department tables are not fully consistent: for
#'   2005 the national table reports 1,811 districts and the department table
#'   sums to 1,831; for 2007, 1,833 and 1,834. The INEI 2022 figures were
#'   transcribed from page images and checked against the figures parsed from
#'   the INEI 2020 PDF.
#' @source
#'   Instituto Nacional de Estadística e Informática (2020). *Perú:
#'   Proyecciones de Población por Departamento, Provincia y Distrito, 2018 -
#'   2020*. Boletín Especial Nº 26. Lima: INEI. Chapter 2, "División política y
#'   administrativa al 31 de diciembre del 2019".
#'   <https://www.inei.gob.pe/media/MenuRecursivo/publicaciones_digitales/Est/Lib1715/libro.pdf>
#'
#'   Instituto Nacional de Estadística e Informática (2022). *Perú:
#'   Proyecciones de Población Total según Departamento, Provincia y Distrito,
#'   2018 - 2022*. Boletín Especial Nº 27. Lima: INEI. Anexo 2, "División
#'   política y administrativa al 31 de diciembre de 2021".
#'   <https://www.inei.gob.pe/media/MenuRecursivo/publicaciones_digitales/Est/Lib1860/libro.pdf>
"division_counts"

#' Provinces created 1981-2021, INEI 2020 and 2022
#'
#' Cuadro "Perú: Relación de provincias creadas desde el 12 de julio de 1981 al
#' 31 de diciembre de 2021" (INEI 2022), which lists the same 43 provinces as
#' the 2019 edition (INEI 2020): no provinces were created in 2020-2021.
#'
#' @format A tibble with 43 rows and 7 variables:
#' \describe{
#'   \item{inei}{UBIGEO (INEI) of the province}
#'   \item{department,province}{Names as published}
#'   \item{law_number}{Number of the law of creation, as published}
#'   \item{published}{Publication date of the law}
#'   \item{note}{Footnotes and warnings}
#'   \item{source}{Sources reporting the row}
#' }
#' @source INEI (2020) and INEI (2022), see [division_counts].
"inei_provinces_created"

#' Districts created 1981-2021, INEI 2020 and 2022
#'
#' Cuadro "Perú: Relación de distritos creados y procedencia territorial,
#' según ley de creación, 1981 - 2021" of INEI (2022), matched to the 2025
#' UBIGEO. Rows 1-194 are also in the 2019 edition (INEI 2020), which numbered
#' them up to 203 because it skipped 161-169; rows 195-210 are the 16
#' districts created in 2020-2021.
#'
#' @format A tibble with 210 rows and 9 variables:
#' \describe{
#'   \item{n}{Row number in INEI (2022)}
#'   \item{n_2020}{Row number in INEI (2020); `NA` for rows 195-210}
#'   \item{inei}{UBIGEO (2025) of the created district}
#'   \item{year}{Year of creation (year heading in the source)}
#'   \item{law_number}{Number of the law of creation}
#'   \item{district,province,department}{Names as published (province and
#'     department at the time of creation): rows 1-194 as parsed from INEI
#'     (2020), rows 195-210 as transcribed from INEI (2022)}
#'   \item{source}{Sources reporting the row}
#' }
#' @source INEI (2020) and INEI (2022), see [division_counts].
"inei_districts_created"

#' Territorial origin of districts created 1981-2021, INEI 2020 and 2022
#'
#' The "procedencia territorial" columns of [inei_districts_created]: the
#' district(s) from which each new district was carved. One row per origin.
#'
#' @format A tibble with one row per created district and origin, 6 variables:
#' \describe{
#'   \item{n}{Row number in INEI (2022) (links to [inei_districts_created])}
#'   \item{inei}{UBIGEO (2025) of the created district}
#'   \item{origin_inei}{UBIGEO (2025) of the origin district; `NA` for two
#'     origins that are inconsistent in the source ("Acobamba", Chincheros; and
#'     "Camilaca", Azángaro)}
#'   \item{origin_district,origin_province,origin_department}{Names as published}
#' }
#' @source INEI (2020) and INEI (2022), see [division_counts].
"inei_district_origins"

#' Districts created 2020-2025
#'
#' The 18 districts in the 2025 Census frame that were created after
#' 31/12/2019 (1,892 - 1,874), with the exact date of their law. The 16
#' created in 2020-2021 are also in [inei_districts_created] (year and law
#' only); the build checks that both sources agree on the law and year.
#'
#' @format A tibble with 18 rows and 7 variables:
#' \describe{
#'   \item{inei}{UBIGEO (2025)}
#'   \item{department,province,district}{Names}
#'   \item{law_number}{Number of the law of creation}
#'   \item{date}{Date of the law as listed in the source}
#'   \item{source}{`"JNE 2021"` or `"Congreso 2025"`}
#' }
#' @source Jurado Nacional de Elecciones (2021). Resolución N.° 0913-2021-JNE,
#'   22 de noviembre de 2021, considerando 1.10.
#'   <https://portal.jne.gob.pe/portal_documentos/files/72803f45-044d-4c92-841b-6b2dbe8efc0a.pdf>
#'
#'   Congreso de la República (2025). *Leyes de creación de distritos*. Área de
#'   Estadística Parlamentaria. <https://www.congreso.gob.pe/Docs/DGP/GestionInformacionEstadistica/files/publicaciones-25/leyes-declarativas-creaci%C3%93n-distritos.pdf>
"districts_created_2020_2025"

#' Legal instruments of creation and modification, PCM-SDOT (GEOSDOT)
#'
#' Every legal instrument that the registry of the Secretaría de Demarcación y
#' Organización Territorial (SDOT) of the Presidencia del Consejo de Ministros
#' lists for each department, province and district, matched to the 2025
#' UBIGEO. Each instrument is tagged as "Creación", "Modificación" or
#' "Cancelación". Downloaded on 08/11/2026 from the "Circunscripciones" module
#' of GEOSDOT, through the same API the web page uses.
#'
#' The registry covers the 25 departments, 194 provinces (not the
#' Constitutional Province of Callao or Moho) and 1,872 districts. It does not
#' include the 18 districts created in 2020-2025, nor Urcos (Quispicanchi) and
#' Anco (Churcampa). Its instruments of creation fill [districts] and
#' [provinces] for the units that no other source covers (`creation_source ==
#' "GEOSDOT"`); where other sources cover a unit and GEOSDOT disagrees, the
#' GEOSDOT instrument is recorded in `note`.
#'
#' @format A tibble with 4,788 rows and 12 variables:
#' \describe{
#'   \item{inei}{UBIGEO (2025) of the unit}
#'   \item{level}{`"department"`, `"province"` or `"district"`}
#'   \item{id_geosdot}{Identifier of the unit (circunscripción) in GEOSDOT}
#'   \item{name}{Name of the unit in GEOSDOT}
#'   \item{action}{`"Creación"`, `"Modificación"` or `"Cancelación"`}
#'   \item{instrument_type}{Type of instrument (Ley, Decreto, Decreto Ley, Ley
#'     Regional, Resolución Legislativa, Reglamento de Elecciones de Diputados,
#'     Censo, ...). "Censo" marks districts first recorded in a census (1876,
#'     1940 or 1981), with no law of creation.}
#'   \item{instrument_number}{Number of the instrument (`S/N` = unnumbered)}
#'   \item{date}{Date of the instrument (`NA` for censuses)}
#'   \item{id_instrument}{Identifier of the instrument in GEOSDOT}
#'   \item{name_in_instrument,capital_in_instrument}{Name of the unit and of its
#'     capital as given in the instrument}
#'   \item{summary}{Summary (sumilla) of the instrument, in Spanish, truncated
#'     to 300 characters}
#' }
#' @source Presidencia del Consejo de Ministros, Secretaría de Demarcación y
#'   Organización Territorial (2026). *Sistema de consultas de información de
#'   naturaleza demarcatoria (GEOSDOT)*, módulo Circunscripciones. Consulted on
#'   08/11/2026. <https://geosdot.servicios.gob.pe/consultas/#/circunscripcion>
"geosdot_norms"

#' Population of each district in each census, 1981-2025
#'
#' Population by sex and area of residence (urban/rural) of every district in
#' the data of each census, with the census's own UBIGEO code and its link to
#' the 2025 district. One row per district and census.
#'
#' Population is the enumerated population (*población censada*). Urban and
#' rural follow INEI's classification of the populated place in each census.
#' Notes by census:
#' - **1981**: sample microdata, weighted by `PFACTEXP` and rounded, so the
#'   counts are estimates. Apurímac, Loreto and San Martín are not in the
#'   microdata (15.9 million people, against 17.0 million published). Codes are
#'   the 1981 census's own.
#' - **1993**: 22,010,683 people, 37,673 fewer than the published figure. 42
#'   district names are inferred (see [ubigeo_crosswalk]).
#' - **2007** and **2017**: full counts; totals match INEI (27,412,157 and
#'   29,381,884). Urban/rural for 2017 uses `ENCAREA`, which reproduces INEI's
#'   official urban total.
#' - **2025**: REDATAM tables, 32,706,028 people. They follow the territorial
#'   limits in force at 15/07/2026, so they include Sangani (Junín), created in
#'   2026, which is not in the 2025 census frame (`inei` is `NA`). Lima codes
#'   use REDATAM's departments 26 and 27 in `ubigeo_census`; `inei` has the
#'   INEI code.
#'
#' To compare censuses on the same boundaries, aggregate by the `unit_YYYY`
#' columns of [ubigeo_crosswalk], not by `inei`.
#'
#' @format A tibble with 8,898 rows and 11 variables:
#' \describe{
#'   \item{census}{Census year}
#'   \item{ubigeo_census}{District code in that census}
#'   \item{inei}{UBIGEO (INEI, 2025) of the linked 2025 district; `NA` if not
#'     linked}
#'   \item{department,province,district}{Names in that census}
#'   \item{total}{Population}
#'   \item{male,female}{Population by sex}
#'   \item{urban,rural}{Population by area of residence}
#' }
#' @source Built by the package author from INEI census data: microdata of
#'   the Censos Nacionales de Población y Vivienda 1981 (sample, weighted),
#'   1993, 2007 and 2017, and the REDATAM district tables of the Censos
#'   Nacionales 2025 (<https://redatamcpv2025.inei.gob.pe/>). Files and method:
#'   `data-raw/census_population/` and its `README_crosswalk_ubigeo_2025.txt`.
"census_population"

#' Population of each province and department in each census, 1981-2025
#'
#' Province, department and national totals of [census_population], as built
#' from the census data, with each census's own codes. In 2025 the department
#' rows follow REDATAM: 26 = Región Lima, 27 = Lima Metropolitana.
#'
#' @format A tibble with 1,039 rows and 10 variables:
#' \describe{
#'   \item{census}{Census year}
#'   \item{level}{`"province"`, `"department"` or `"national"`}
#'   \item{code}{Province (4 digits) or department (2 digits) code in that
#'     census; `"00"` for the national row}
#'   \item{department,province}{Names in that census}
#'   \item{total,male,female,urban,rural}{Population}
#' }
#' @source Built by the package author from INEI census data: microdata of
#'   the Censos Nacionales de Población y Vivienda 1981 (sample, weighted),
#'   1993, 2007 and 2017, and the REDATAM district tables of the Censos
#'   Nacionales 2025 (<https://redatamcpv2025.inei.gob.pe/>). Files and method:
#'   `data-raw/census_population/` and its `README_crosswalk_ubigeo_2025.txt`.
"census_population_totals"

#' Crosswalk of census district codes to the 2025 districts
#'
#' Links every district in the data of the 1981, 1993, 2007, 2017 and 2025
#' censuses to a 2025 district, and gives, for every 2025 district, the
#' district of each earlier census it descends from (`unit_YYYY`). One row per
#' district and census.
#'
#' `inei` is a one-to-one "main successor" link: comparing censuses by `inei`
#' overstates the early population of districts that later split. To compare
#' two censuses on the same boundaries, aggregate both by the `unit_YYYY` of
#' the earlier one.
#'
#' The parent of each district created after an earlier census
#' (`parent_inei`) is **inferred from population** (see `parent_confidence`).
#' `law_origins` gives, for comparison, the districts each one was carved from
#' according to its creation law (INEI 2020/2022, [inei_district_origins]), and
#' `parent_agrees_law` says whether the inferred parent is among them. They
#' agree in 103 of 190 comparable cases. The `unit_YYYY` columns follow the
#' inferred parents.
#'
#' @format A tibble with 8,898 rows and 22 variables:
#' \describe{
#'   \item{census}{Census year}
#'   \item{ubigeo_census}{District code in that census (REDATAM code for 2025)}
#'   \item{department,province,district}{Names in that census}
#'   \item{population}{Population of the district in that census}
#'   \item{inei}{UBIGEO (INEI) of the linked 2025 district; `NA` if not linked}
#'   \item{department_2025,province_2025,district_2025}{Names of the 2025 district}
#'   \item{method}{How the link was made: same code, same code with a different
#'     name, name match, manual/inferred, unmatched, or 2025 district}
#'   \item{note}{Evidence for renames and manual or inferred links}
#'   \item{parent_inei}{For 2025 districts created after an earlier census: the
#'     2025 district it was split from, inferred from population}
#'   \item{created_after}{Last census before the district first appears}
#'   \item{parent_confidence}{`manual`, `only candidate`, `high`, `medium` or
#'     `low`}
#'   \item{parent_evidence}{Details of the inference}
#'   \item{law_origins}{Origin districts in the creation law (INEI codes,
#'     separated by `;`)}
#'   \item{parent_agrees_law}{`TRUE` if `parent_inei` is in `law_origins`;
#'     `NA` if either is missing}
#'   \item{unit_1981,unit_1993,unit_2007,unit_2017}{Harmonised unit: the 2025
#'     code of the district of that census from which the row's 2025 district
#'     descends}
#' }
#' @source Built by the package author from INEI census data: microdata of
#'   the Censos Nacionales de Población y Vivienda 1981 (sample, weighted),
#'   1993, 2007 and 2017, and the REDATAM district tables of the Censos
#'   Nacionales 2025 (<https://redatamcpv2025.inei.gob.pe/>). Files and method:
#'   `data-raw/census_population/` and its `README_crosswalk_ubigeo_2025.txt`.
"ubigeo_crosswalk"
