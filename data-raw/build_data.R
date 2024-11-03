## code to prepare `iucnrdata` data package goes here
library(tidyverse)
# load data files
# taxonomy data
taxonomy_v1 <- arrow::read_csv_arrow("2024-1/taxonomy.csv",
                                     col_names = TRUE) |>
  janitor::clean_names()

taxonomy_v2 <- arrow::read_csv_arrow("2024-2/taxonomy.csv",
                                     col_names = TRUE) |>
  janitor::clean_names()


names(taxonomy_v1)
names(taxonomy_v2)

dim(taxonomy_v1)
dim(taxonomy_v2)

taxonomy_v1 |>
  pesa::check_na()

taxonomy_v2 |>
  pesa::check_na()

# Remove the variables infra_type, infra_name, infra_authority,
# and subpopulation_name from both datasets, as they do not contain
# any information.

taxonomy_v1 <- taxonomy_v1 |>
  dplyr::select(-c(infra_type, infra_name, infra_authority,
                   subpopulation_name))

taxonomy_v2 <- taxonomy_v2 |>
  dplyr::select(-c(infra_type, infra_name, infra_authority,
                   subpopulation_name))


#' Taxonomy Dataset for IUCN Species 2024 - 1
#'
#' The `taxonomy_2024_v1` dataset provides comprehensive taxonomic information
#' for species included in the IUCN Red List. This dataset includes various
#' taxonomic ranks and other relevant details for each taxon, serving as
#' a core reference for linking additional datasets on species distribution,
#' conservation status, and vernacular names.
#'
#' @format A tibble with 163,040 rows and 11 variables:
#' \describe{
#'   \item{internal_taxon_id}{\code{integer}. Unique identifier for
#'    each taxon record, linking it to the core dataset.}
#'   \item{scientific_name}{\code{character}. Full scientific name of
#'   the taxon.}
#'   \item{kingdom_name}{\code{character}. Kingdom classification of the taxon.}
#'   \item{phylum_name}{\code{character}. Phylum classification of the taxon.}
#'   \item{class_name}{\code{character}. Class classification of the taxon.}
#'   \item{order_name}{\code{character}. Order classification of the taxon.}
#'   \item{family_name}{\code{character}. Family classification of the
#'    taxon.}
#'   \item{genus_name}{\code{character}. Genus to which the taxon belongs.}
#'   \item{species_name}{\code{character}. Species epithet, which, combined
#'    with the genus, forms the species name.}
#'   \item{authority}{\code{character}. Author(s) who originally described
#'    the taxon.}
#'   \item{taxonomic_notes}{\code{character}. Additional notes regarding
#'   the taxon's classification or historical data, if available.}
#' }
#'
#' @source IUCN Red List of Threatened Species
#'

#' Taxonomy Dataset for IUCN Species 2024 - 2
#'
#' The `taxonomy_2024_v2` dataset provides comprehensive taxonomic information
#' for species included in the IUCN Red List. This dataset includes various
#' taxonomic ranks and other relevant details for each taxon, serving as
#' a core reference for linking additional datasets on species distribution,
#' conservation status, and vernacular names.
#'
#' @format A tibble with 166,061 rows and 11 variables:
#' \describe{
#'   \item{internal_taxon_id}{\code{integer}. Unique identifier for
#'    each taxon record, linking it to the core dataset.}
#'   \item{scientific_name}{\code{character}. Full scientific name of
#'   the taxon.}
#'   \item{kingdom_name}{\code{character}. Kingdom classification of the taxon.}
#'   \item{phylum_name}{\code{character}. Phylum classification of the taxon.}
#'   \item{class_name}{\code{character}. Class classification of the taxon.}
#'   \item{order_name}{\code{character}. Order classification of the taxon.}
#'   \item{family_name}{\code{character}. Family classification of the
#'    taxon.}
#'   \item{genus_name}{\code{character}. Genus to which the taxon belongs.}
#'   \item{species_name}{\code{character}. Species epithet, which, combined
#'    with the genus, forms the species name.}
#'   \item{authority}{\code{character}. Author(s) who originally described
#'    the taxon.}
#'   \item{taxonomic_notes}{\code{character}. Additional notes regarding
#'   the taxon's classification or historical data, if available.}
#' }
#'
#' @source IUCN Red List of Threatened Species


# simple_summary.csv a flat table containing the taxonomy for each taxon,
# Red List Category, Red List Criteria, version of criteria used, and
# current population trend.

iucn_2024_v1 <- arrow::read_csv_arrow("2024-1/simple_summary.csv") |>
  janitor::clean_names() |>
  dplyr::select(-c(infra_type, infra_name, infra_authority))

iucn_2024_v2 <- arrow::read_csv_arrow("2024-2/simple_summary.csv") |>
  janitor::clean_names() |>
  dplyr::select(-c(infra_type, infra_name, infra_authority))

iucn_2024_v1 |>
  glimpse()

iucn_2024_v2 |>
  glimpse()


iucn_2024_v1 |>
  pesa::check_na()
iucn_2024_v2 |>
  pesa::check_na()


#' IUCN Red List Dataset 2024 (v1)
#'
#' A dataset containing the International Union for Conservation of
#' Nature (IUCN) Red List taxonomy and assessment data for 163,040 taxa,
#' as of 2024. The data includes information on taxonomic classification,
#' Red List Category, Red List Criteria, criteria version, and population
#' trends.
#'
#' @format A tibble with 163,040 rows and 16 variables:
#' \describe{
#'   \item{assessment_id}{Integer. Unique identifier for each IUCN assessment.}
#'   \item{internal_taxon_id}{Integer. Internal ID for each taxon within the IUCN system.}
#'   \item{scientific_name}{Character. The scientific name of the taxon.}
#'   \item{kingdom_name}{Character. The kingdom to which the taxon belongs.}
#'   \item{phylum_name}{Character. The phylum to which the taxon belongs.}
#'   \item{order_name}{Character. The order of the taxon.}
#'   \item{class_name}{Character. The class of the taxon.}
#'   \item{family_name}{Character. The family to which the taxon belongs.}
#'   \item{genus_name}{Character. The genus of the taxon.}
#'   \item{species_name}{Character. The species name of the taxon.}
#'   \item{authority}{Character. The taxonomic authority for the species, indicating the source of its scientific name.}
#'   \item{redlist_category}{Character. The IUCN Red List category of the taxon, indicating its conservation status (e.g., "Near Threatened", "Critically Endangered").}
#'   \item{redlist_criteria}{Character. The criteria used to assign the Red List category.}
#'   \item{criteria_version}{Numeric. Version of the criteria used in the assessment, typically 3.1 or 2.3.}
#'   \item{population_trend}{Character. The current trend in the population of the taxon (e.g., "Decreasing", "Stable").}
#'   \item{scopes}{Character. Geographic scope of the assessment, such as "Global" or "Global & Europe".}
#' }
#'
"iucn_2024_v1"

usethis::use_data(iucn_2024_v1, overwrite = TRUE, compress = "xz")
usethis::use_data(iucn_2024_v2, overwrite = TRUE, compress = "xz")


# COMON NAMES


common_names_2024_v1 <- arrow::read_csv_arrow("2024-1/common_names.csv") |>
  janitor::clean_names()
common_names_2024_v1
common_names_2024_v1 |>
  pesa::check_na()


common_names_2024_v2 <- arrow::read_csv_arrow("2024-2/common_names.csv") |>
  janitor::clean_names()
common_names_2024_v2


usethis::use_data(common_names_2024_v2,
                  overwrite = TRUE,
                  compress = "xz")

glimpse(common_names_2024_v2)


