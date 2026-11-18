# Step 9: population of each census and crosswalk of census codes to 2025
#
# Sources (built by the package author from INEI census data; see
# data-raw/census_population/README_crosswalk_ubigeo_2025.txt):
#   CPV 1981  microdata POBLACION.sav (weighted sample; no Apurímac, Loreto or
#             San Martín)
#   CPV 1993  microdata *pob.sav
#   CPV 2007  microdata POBLACION CPV2007.sav
#   CPV 2017  microdata CPV2017_POB.sav
#   CPV 2025  REDATAM district tables (population by sex; area de residencia
#             según concepto de censo), https://redatamcpv2025.inei.gob.pe/
#
# Input : data-raw/census_population/poblacion_<year>.xlsx (sheets District,
#         Province, Department), crosswalk_ubigeo_2025.csv
# Output (in the calling environment):
#   census_population         one row per district and census
#   census_population_totals  province, department and national rows of each census
#   ubigeo_crosswalk          census district -> 2025 district, harmonised units

cp_dir <- "data-raw/census_population"
cp_years <- c(1981L, 1993L, 2007L, 2017L, 2025L)

# The 2025 REDATAM base splits Lima: department 26 = Región Lima (INEI 15,
# provinces 02-10) and 27 = Lima Metropolitana (INEI 1501). Convert to INEI.
redatam_to_inei <- function(u) {
  ifelse(is.na(u), NA_character_,
         ifelse(substr(u, 1, 4) == "2701", paste0("1501", substr(u, 5, 6)),
                ifelse(substr(u, 1, 2) == "26", paste0("15", substr(u, 3, 6)), u)))
}

read_sheet <- function(year, sheet) {
  x <- readxl::read_excel(file.path(cp_dir, sprintf("poblacion_%d.xlsx", year)),
                          sheet = sheet, col_types = "text")
  x <- as.data.frame(x, stringsAsFactors = FALSE)
  for (v in intersect(c("total", "male", "female", "urban", "rural"), names(x)))
    x[[v]] <- as.integer(x[[v]])
  x
}

# ---- Districts ---------------------------------------------------------------
pop <- do.call(rbind, lapply(cp_years, function(y) {
  d <- read_sheet(y, "District")
  if (!"ubigeo_2025" %in% names(d)) d$ubigeo_2025 <- d$ubigeo   # 2025: own code
  data.frame(census = y, ubigeo_census = d$ubigeo,
             inei = redatam_to_inei(d$ubigeo_2025),
             department = d$department, province = d$province, district = d$district,
             total = d$total, male = d$male, female = d$female,
             urban = d$urban, rural = d$rural, stringsAsFactors = FALSE)
}))
stopifnot(!anyDuplicated(pop[, c("census", "ubigeo_census")]),
          with(pop, all(male + female == total)), with(pop, all(urban + rural == total)))
# Sangani (Chanchamayo, Junín) was created in 2026 (Law 32729) and is in the
# 2025 REDATAM tables but not in the 2025 census frame of the package.
pop$inei[!is.na(pop$inei) & !pop$inei %in% units2025$inei] <- NA

# ---- Province, department and national totals --------------------------------
totals <- do.call(rbind, lapply(cp_years, function(y) {
  p <- read_sheet(y, "Province"); d <- read_sheet(y, "Department")
  rbind(
    data.frame(census = y, level = "province", code = p$prov_code,
               department = p$department, province = p$province,
               p[, c("total", "male", "female", "urban", "rural")]),
    data.frame(census = y, level = ifelse(d$dep_code == "00", "national", "department"),
               code = d$dep_code, department = d$department, province = NA_character_,
               d[, c("total", "male", "female", "urban", "rural")]))
}))
for (y in cp_years) {          # every level adds up to the same national total
  s <- totals[totals$census == y, ]
  nat <- s$total[s$level == "national"]
  stopifnot(sum(s$total[s$level == "province"]) == nat,
            sum(s$total[s$level == "department"]) == nat,
            sum(pop$total[pop$census == y]) == nat)
}

# ---- Crosswalk -----------------------------------------------------------------
xw <- utils::read.csv(file.path(cp_dir, "crosswalk_ubigeo_2025.csv"), colClasses = "character",
                      fileEncoding = "UTF-8-BOM", na.strings = "")
for (v in c("ubigeo_2025", "parent_2025", paste0("unit_", cp_years[-5]),
            paste0("unit_", cp_years[-5], "_strict")))
  xw[[v]] <- redatam_to_inei(xw[[v]])
xw$law_origins_2025 <- vapply(strsplit(xw$law_origins_2025, ";"), function(v)
  if (length(v) == 1 && is.na(v)) NA_character_ else paste(redatam_to_inei(v), collapse = ";"), "")
xw$census <- as.integer(xw$census)
xw$population_census <- as.integer(xw$population_census)
xw$created_after <- as.integer(xw$created_after)
xw$ubigeo_2025[!is.na(xw$ubigeo_2025) & !xw$ubigeo_2025 %in% units2025$inei] <- NA  # Sangani

# Crosswalk and population files must agree row by row
chk <- merge(xw[, c("census", "ubigeo_census", "population_census", "ubigeo_2025")],
             pop[, c("census", "ubigeo_census", "total", "inei")],
             by = c("census", "ubigeo_census"), all = TRUE)
stopifnot(nrow(chk) == nrow(xw), nrow(chk) == nrow(pop),
          all(chk$population_census == chk$total),
          identical(is.na(chk$ubigeo_2025), is.na(chk$inei)),
          all(chk$ubigeo_2025 == chk$inei, na.rm = TRUE))

# Parents follow the creation laws (INEI 2020/2022). Check that the crosswalk's
# law origins are those of the package's inei_district_origins, and that each
# parent taken from the law is one of them.
law <- inei_district_origins[!is.na(inei_district_origins$origin_inei), ]
pkg_origins <- tapply(law$origin_inei, law$inei, function(v) paste(sort(unique(v)), collapse = ";"))
xw_origins <- vapply(strsplit(xw$law_origins_2025, ";"), function(v)
  if (length(v) == 1 && is.na(v)) NA_character_ else paste(sort(unique(v)), collapse = ";"), "")
has <- !is.na(xw_origins)
bad <- has & (is.na(pkg_origins[xw$ubigeo_2025]) | xw_origins != pkg_origins[xw$ubigeo_2025])
if (any(bad)) {
  print(unique(data.frame(inei = xw$ubigeo_2025, crosswalk = xw_origins, package = pkg_origins[xw$ubigeo_2025])[bad, ]))
  stop("Law origins differ between the crosswalk and inei_district_origins")
}
xw$parent_agrees_law <- ifelse(
  is.na(xw$parent_2025) | !has, NA,
  mapply(function(p, o) p %in% strsplit(o, ";")[[1]], xw$parent_2025, ifelse(has, xw$law_origins_2025, "")))
stopifnot(all(xw$parent_agrees_law[grepl("^law", xw$parent_confidence)]))

ubigeo_crosswalk <- tibble::as_tibble(data.frame(
  census = xw$census, ubigeo_census = xw$ubigeo_census,
  department = xw$department, province = xw$province, district = xw$district,
  population = xw$population_census,
  inei = xw$ubigeo_2025,
  department_2025 = xw$department_2025, province_2025 = xw$province_2025,
  district_2025 = xw$district_2025,
  method = xw$method, note = xw$note,
  parent_inei = xw$parent_2025, law_origins = xw$law_origins_2025,
  parent_agrees_law = xw$parent_agrees_law, created_after = xw$created_after,
  parent_confidence = xw$parent_confidence, parent_evidence = xw$parent_evidence,
  unit_1981 = xw$unit_1981, unit_1993 = xw$unit_1993,
  unit_2007 = xw$unit_2007, unit_2017 = xw$unit_2017,
  unit_1981_strict = xw$unit_1981_strict, unit_1993_strict = xw$unit_1993_strict,
  unit_2007_strict = xw$unit_2007_strict, unit_2017_strict = xw$unit_2017_strict,
  stringsAsFactors = FALSE))

census_population <- tibble::as_tibble(pop)
census_population_totals <- tibble::as_tibble(totals)

message("Census population: ", paste(sprintf("%d: %s districts, %s people", cp_years,
  format(table(pop$census)[as.character(cp_years)], big.mark = ","),
  format(tapply(pop$total, pop$census, sum)[as.character(cp_years)], big.mark = ",")),
  collapse = "; "))
