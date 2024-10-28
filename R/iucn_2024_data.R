#' IUCN Species Data 2024
#'
#' A dataset containing the IUCN Red List conservation status of
#' various species, including subspecies and subpopulations.
#' The data includes species scientific names, threat categories,
#' and additional information such as the core ID and rank.
#'
#' @format A tibble with  166,503  rows and 7 columns:
#' \describe{
#'   \item{category}{\code{character}. The IUCN Red List category for each species, indicating its risk of extinction. Categories include "CR" (Critically Endangered), "EN" (Endangered), "VU" (Vulnerable), "LC" (Least Concern), "NT" (Near Threatened), "DD" (Data Deficient), and others.}
#'   \item{threat_status}{\code{character}. A descriptive representation of the conservation status, corresponding to the IUCN Red List category, e.g., "Critically Endangered", "Vulnerable", "Least Concern".}
#'   \item{core_id}{\code{integer}. A unique identifier for each species or subspecies within the dataset.}
#'   \item{scientific_name}{\code{character}. The scientific name of the species, including the genus and species epithet.}
#'   \item{subspecies}{\code{character}. The subspecies name, if applicable.}
#'   \item{rank}{\code{character}. The taxonomic rank below species level, such as "var." (variety) or "subsp." (subspecies).}
#'   \item{subpopulation}{\code{character}. The specific subpopulation designation, if applicable, for species that are divided into distinct subpopulations.}
#' }
#'
#' @details This dataset provides the conservation status as determined by the IUCN Red List for 2024. The data includes species with subspecies and subpopulation-level classifications where available. Subpopulations are identified for some species, and specific subpopulations are assigned threat statuses separately.
#'
#' @examples
#' # Load the data
#' data(iucn_2024)
#'
#' # View the first few rows of the dataset
#' head(iucn_2024)
#'
#' @source International Union for Conservation of Nature (IUCN) Red List 2024.
"iucn_2024"
