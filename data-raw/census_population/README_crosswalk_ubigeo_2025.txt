POPULATION BY DISTRICT, CPV 1981-2025, AND CROSSWALK TO 2025 UBIGEO
=====================================================================
Folder: Poblacion_por_ubigeo/
Built: 18 Nov 2026
Scripts (parent folder):
  population_by_ubigeo.py    census microdata -> poblacion_1981/1993/2007/2017.xlsx
  crosswalk_ubigeo_2025.py   2025 REDATAM tables -> poblacion_2025.xlsx and
                             crosswalk_ubigeo_2025.csv; also adds ubigeo_2025 to
                             the earlier poblacion_*.xlsx files
Run them in that order. The first takes 30-40 minutes, the second a few seconds.


1. FILES
--------
poblacion_<year>.xlsx          Population by district, province and department, 1981-2025
crosswalk_ubigeo_2025.csv      Census district -> 2025 district, with harmonised units
2025_ubigeo_sexo.xlsX          REDATAM input (CPV 2025, population by sex and district)
2025_ubigeo_rurality.xlsX      REDATAM input (CPV 2025, "area de residencia segun
                               concepto de censo", by district)
districts.csv, provinces.csv, departments.csv
                               Creation laws (INEI codes): creation date, legal instrument,
                               and flags census_<year> = 1 if the unit legally existed at
                               that census. districts.csv is used by the crosswalk (see 4.6).
inei_district_origins.csv      Territorial origin of each district created 1981-2021: the
                               district(s) it was carved from (INEI 2020/2022, cuadro 4
                               "procedencia territorial"; INEI codes). Source of the
                               parents (see 4.4).
suggested_parents_from_law.csv External review: suggested parent replacements derived from
                               the origins table (REDATAM codes). Kept for reference; all
                               66 direct replacements are reproduced by the crosswalk.


2. DICTIONARY: poblacion_<year>.xlsx
------------------------------------
Sheets: District, Province, Department, Notes.

District sheet
  ubigeo          6-digit district code as used IN THAT CENSUS (department + province
                  + district). Codes are not harmonised across censuses (see 4).
  ubigeo_2025     Matched CPV 2025 district (not in the 2025 file). Blank if not
                  matched. See crosswalk_ubigeo_2025.csv for how each match was made.
  department, province, district
                  Names as in that census.
  total           Population.
  male, female    Population by sex.
  urban, rural    Population by area. urban + rural = total, male + female = total.

Province sheet: prov_code (4 digits), department, province, totals.
Department sheet: dep_code (2 digits), department, totals, plus a PERU row (code 00).
Notes sheet: source and coding notes for that census.

Source and coding by census
  1981  POBLACION.sav. Sample microdata: counts are weighted by PFACTEXP and rounded,
        so they are ESTIMATES. Departments 03 Apurimac, 16 Loreto and 22 San Martin
        are not in the microdata (total 15.9M vs 17.0M official). Codes are the 1981
        census's own, not INEI ubigeo. Urban = AREA 2, rural = AREA 3.
  1993  *pob.sav (Lima in 15_Lima/). ubigeo = DPTOW+PROVW+DISTW. Total 22,010,683
        (published: 22,048,356). Urban = AREA 2, rural = AREA 3. 42 district names
        are inferred (see 4.3).
  2007  POBLACION CPV2007.sav. Full count; totals match INEI (27,412,157).
        Urban = AREA 1, rural = AREA 2.
  2017  CPV2017_POB.sav. Full count; totals match INEI (29,381,884).
        Urban/rural from ENCAREA (1/2), which reproduces INEI's official 23,311,893
        urban. The other variable, AREA, puts 894,028 more people in urban areas.
  2025  REDATAM district tables. 32,706,028 people. Urban/rural is "area de
        residencia segun concepto de censo". Codes follow the 2025 REDATAM base, which
        splits Lima: department 26 = Region Lima (old 15, provinces 02-10),
        27 = Lima Metropolitana (old 1501).

Urban/rural is INEI's classification of the populated place (centro poblado). It was
not built by us; we only counted people by it.


3. DICTIONARY: crosswalk_ubigeo_2025.csv
----------------------------------------
One row per district per census (1981, 1993, 2007, 2017, 2025). UTF-8 with BOM.
Read all columns as text so the leading zeros survive.

  census              Census year of the row.
  ubigeo_census       District code in that census (= ubigeo in poblacion_<census>.xlsx).
  department, province, district
                      Names in that census.
  population_census   Total population of the district in that census.
  ubigeo_2025         Matched 2025 district. Blank if not matched (3 rows, see 5).
  department_2025, province_2025, district_2025
                      Names of the matched 2025 district.
  method              How ubigeo_2025 was assigned:
                        same code                    identical code (after the Lima
                                                     recode), same name
                        same code, name differs      identical code, renamed or
                                                     respelled (e.g. Nazca -> Nasca)
                        same code (via 1981 crosswalk) 1981 only: through the current
                                                     ubigeo in crosswalk_district1981_prov1993.csv
                        name match                   code gone, unique name match in
                                                     the department
                        manual/inferred              set by hand or inferred (see note)
                        unmatched                    could not be assigned
                        2025 district                rows of the 2025 census itself
  note                Reason/evidence for name changes, manual and inferred matches.
  law_created_date, law_legal_instrument
                      Creation date and law of the 2025 district (from districts.csv).
  parent_2025         For 2025 districts created after an earlier census: the 2025
                      district they were split from (main parent). Blank for
                      districts that already existed in the first available census.
                      Repeated on every row that maps to that 2025 district.
  law_origins_2025    All origin districts in the creation law (2025 codes, ";"-
                      separated, in INEI's order). Blank if not in the origins table.
  created_after       Last census before the district appears (it was created between
                      created_after and the next census).
  parent_confidence   Source of parent_2025 (see 4.4):
                        law                         single origin in the law
                        law, main of N origins      N origins; main one = largest
                                                    population loss (deficit)
                          ... (manual)              main origin set from known history
                          ... (weak population evidence)  no origin shows a clear
                                                    loss; the main one is uncertain
                        inferred: high/medium/...   not in the origins table
                                                    (created after 2021, or La Peca)
  parent_evidence     Period, law origins and each origin's deficit/child population
                      (or, for inferred parents, the fit ratio and next candidates).
  unit_1981, unit_1993, unit_2007, unit_2017
                      Harmonised unit on that census's boundaries, following
                      parent_2025: the 2025 code of the district that existed in that
                      census and from which the row's 2025 district descends. All 2025
                      districts that descend from the same district of census Y share
                      the same unit_Y. unit_1981 is blank in departments 03, 16 and 22.
  unit_1981_strict, unit_1993_strict, unit_2007_strict, unit_2017_strict
                      Same, but every district created after census Y from SEVERAL
                      districts merges the units of all its law origins. Exact (no
                      population is attributed to the wrong unit) but coarser.

How to compare two censuses on the same boundaries
  Group both censuses by the unit of the EARLIER one. Example (pandas):
    x = pd.read_csv("crosswalk_ubigeo_2025.csv", dtype=str)
    x["pop"] = x.population_census.astype(int)
    x[x.census.isin(["1993", "2017"])].groupby(["unit_1993", "census"])["pop"].sum()
  Example: 2017 Viru (131201) and Chao (131202) both have unit_1993 = 131201, the
  1993 district of Viru. To use other variables, merge poblacion_<year>.xlsx (or any
  district file) with the crosswalk on census + ubigeo_census.
  unit_Y or unit_Y_strict? unit_Y keeps the most units; a district carved from several
  districts is counted entirely in its main origin's unit. unit_Y_strict is exact,
  with fewer and larger units:
    unit_1981 1,468 vs strict 1,371; unit_1993 1,793 vs 1,731;
    unit_2007 1,831 vs 1,795; unit_2017 1,874 vs 1,872.
  Use strict for panels where exact comparability matters. Use unit_Y when
  finer detail matters more and small territorial transfers can be ignored.


4. METHOD
---------
4.1 Hub design
  There is one crosswalk, to the latest census (2025), instead of one per pair of
  censuses. Any pair is obtained through the harmonised units, and every correction
  is made in one place. When a new census comes out, rebuild the crosswalk with the
  new census as the hub.

4.2 Matching census districts to 2025 (ubigeo_2025), in order
  a) Manual/inferred assignments, documented in the scripts (NAMES_1993, MANUAL_1981)
     and in the note column.
  b) Same code. For 1981, the code is the current INEI ubigeo from
     crosswalk_district1981_prov1993.csv. Lima is recoded as in the 2025 base
     (1501dd -> 2701dd; 15ppdd -> 26ppdd). Where the code matches but the name
     differs, we checked every case by hand: all are renames or spelling changes.
     Code beats name on purpose: e.g. Pampas (Huaraz) is now Pampas Grande, which is
     not the same as Pampas (Pallasca).
  c) Unique normalised name within the department (accents, case and punctuation
     ignored).

4.3 1993 district names
  The 1993 microdata has codes but no names. Names come from the 2007 geographic
  table, because codes were stable between the two censuses. 42 codes needed
  inference: districts that moved to provinces created after 1993 (Lauricocha,
  Yarowilca, Chupaca, Viru, Gran Chimu, Datem del Maranon, Putumayo, Sechura) and
  codes later reused for other districts. Within a province, INEI codes put the
  capital first and then the other districts in alphabetical order. That order
  places the missing codes, and each was checked against its 1981 and 2007
  populations. Notable cases:
    130112  1993 = Viru (later split into Viru, Chao, Guadalupito). In 2025 the
            code belongs to Alto Trujillo.
    200115  1993 = Vice. The code was later reused for Veintiseis de Octubre.
    100302  1993 = Aparicio Pomares (Chupan in 1981). Codes 02-06 follow the
            alphabetical order only with this name.
    090708  Huando; 090712 Pachamarca (this one identified from population only).
    160111  Yaquerana: next in Maynas' alphabetical order after Torres Causana.
            Created 1943 (Ley 9815) and modified by Ley 27195 (1999); in Requena
            (160511) by 2007. An earlier version assigned Teniente Manuel Clavero, but
            that district was only created in 2004 (Ley 28362).

4.4 Parents of new districts (parent_2025)
  For each 2025 district we find the first census in which it has population
  (created_after = the census before that one). Its parent comes from, in order:
  a) The creation law: inei_district_origins.csv, recoded to 2025 codes. With one
     origin, that district is the parent. With several origins, the main parent is
     the origin with the largest population shortfall ("deficit") between the two
     censuses:
         deficit_k = g * pop_before(k) - pop_after(k)
     where g is the growth of the provinces involved. An origin that lost most
     population relative to its province is the one the new district took most
     from. Exceptions:
       - If a hand-set parent (PARENTS_MANUAL) is one of the law origins, it is used
         as the main one: Santa Anita <- Ate; San Borja <- Surquillo; Mi Peru <-
         Ventanilla; Ciudad Nueva <- Tacna. Lima's very uneven district growth makes
         the deficit rule unreliable there.
       - "weak population evidence" means no origin lost more than 0.25 times the
         new district's population, so the main origin is uncertain. 6 cases:
         Majes, Uchuraccay, Codo del Pozuzo, Palcazu, San Miguel (Puno), Irazola.
       - An origin created in the same interval (Tinicachi <- Unicachi) is used
         directly; the unit follows Unicachi's own parent.
     Corrections to the origins table (ORIGIN_FIXES in the script):
       San Borja's "Surco" is Santiago de Surco (150140), not Surco in Huarochiri
       (150732); San Miguel's "Camilaca, Azangaro" is Caminaca (210205); the
       uncoded "Acobamba" origin of Ranracancha is dropped (no such district in
       Chincheros; Anco-Huallo is kept).
  b) Districts not in the origins table: inferred from population. The candidates
     are the districts of the same province, and the parent is the candidate whose
     deficit is closest to the new district's population. This covers 4 districts:
     Sangani <- Perene, Alto Trujillo <- El Porvenir and Santa Rosa de Loreto <-
     Yavari (created after 2021), and La Peca <- Bagua (identity case, see 4.6).
  Result: 195 new districts: 124 single law origin, 67 with several law origins
  (of which 4 manual and 6 weak), 4 inferred. All 66 direct replacements in
  suggested_parents_from_law.csv are reproduced.

4.5 Harmonised units (unit_<year>)
  For each 2025 district, follow parent_2025 upward until reaching a district that
  exists in census Y; that district's 2025 code is unit_Y. Special cases:
    - Carmen Alto (050104) is missing from the 2007 microdata; its 2007 population
      is counted under Ayacucho, so the two share one 2007 unit.
    - 2007 Mazamari-Pangoa (120699) was a joint census area: Mazamari, Pangoa and
      Vizcatan del Ene form one 2007 unit (120606), and the row 120699 is assigned
      to it.
    - 1981 Yauyos: the 1981 name table carries Huarochiri's district names for
      Yauyos, so its 1981 districts cannot be identified. The whole province (2610)
      is a single 1981 unit (261001).
    - Several 1981 districts mapping to one 2025 district merge into one unit.
    - 1981: when a lineage leads to a department missing from the 1981 data (e.g.
      Pucayacu, whose law origins include Alto Biavo in San Martin), unit_1981 is
      blank only if the main parent is there; Pucayacu's main origin is Jose Crespo
      y Castillo (Huanuco).
  Strict units (unit_Y_strict): starting from unit_Y, for each district created
  after census Y from several districts, the units of all its law origins are
  merged into one, named after the smallest 2025 code in the group. Largest strict
  units: 33 districts of 2025 in 1981 (Yauyos), 14 in 1993, 15 in 2007, 3 in 2017.

4.6 Check against creation laws (districts.csv)
  The script compares each 2025 district's legal existence at each census
  (census_<year> flags) with whether the census data has a district for it. Only
  two cases remain, both explained:
    - Bagua / La Peca: by law, La Peca (1861) continues as 010206 and Bagua was
      created by Ley 28884 (2006; listed by INEI under 2008). The census codes
      follow the town instead: the
      old capital district La Peca (010201) maps to 2025 Bagua (010201). The
      harmonised unit is the same either way (Bagua + La Peca).
    - Carmen Alto, 2007: missing from the microdata (see 4.5).
  The check led to two corrections: 1993 code 160111 = Yaquerana (4.3), and the
  1981 Ubinas/Lloque swap. The 1981 table labels both 18-02-06 and 18-02-10
  "LLOQUE"; by population, 18-02-06 (2,836) is Ubinas and 18-02-10 (596) is Lloque.
  Both override crosswalk_district1981_prov1993.csv.


5. LIMITATIONS AND IMPORTANT NOTES
----------------------------------
- Parents follow the creation laws for 191 of 195 new districts. For districts
  with several origins, the MAIN origin is chosen by population (or by hand) and
  can be wrong, mainly in the 6 "weak population evidence" cases. This affects
  unit_Y only; unit_Y_strict does not depend on the choice.
- The origins table covers districts created up to 2021. Newer districts (Sangani,
  Alto Trujillo, Santa Rosa de Loreto) have inferred parents. Add them to
  PARENTS_MANUAL or to the origins table when their laws are coded.
- Boundary changes that did not create or remove a district (transfers of
  territory between existing districts) are not detected.
- ubigeo_2025 alone is a one-to-one "main successor" link. Comparing censuses by
  ubigeo_2025 overstates the early population of districts that later split (e.g.
  1993 Viru vs 2017 Viru). Use the unit_<year> columns for comparisons over time.
- 1981 is a weighted sample without Apurimac, Loreto and San Martin; unit_1981 is
  blank there. Two Yauyos districts (898 people) have no ubigeo_2025.
- 1993 microdata totals are 37,673 below the published figure.
- In poblacion_1981.xlsx, district names are those of the 1981 table, including its
  mislabels (e.g. Ubinas appears as LLOQUE). Trust ubigeo_2025, not the 1981 name.
- 2007: Carmen Alto is missing (counted in Ayacucho); Mazamari-Pangoa is a joint
  area. Some rural districts look over-counted in 2007 compared with 1993 and 2017
  (e.g. Paucara 9,270 / 24,317 / 10,415). This shows up as large 2007-2017 declines
  inside single, unsplit units: it comes from the census counts, not the crosswalk.
- The 2017 urban/rural split uses ENCAREA. The do-file open_2017_population.do builds
  rural from AREA, which differs for 894,028 people.
- 2025 codes are the REDATAM ones (departments 26 and 27 for Lima). To get INEI's
  administrative ubigeo, map 2701dd -> 1501dd and 26ppdd -> 15ppdd.
- La Peca (Bagua, 1981) is the current Bagua district (010201), not the current
  La Peca (010206). This overrides crosswalk_district1981_prov1993.csv.
- Urban/rural definitions are INEI's for each census and may differ slightly over
  time.
