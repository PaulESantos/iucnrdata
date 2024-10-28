#' IUCN Red List Taxon Data
#'
#' This dataset contains taxonomic information from the IUCN Red List of Threatened Species, downloaded from the GBIF website. It includes detailed taxonomic classifications and the conservation status of species across various kingdoms, offering a comprehensive view of the species listed in the Red List.
#'
#' @format A tibble with 150,490 rows and 21 variables:
#' \describe{
#'   \item{search_name}{\code{character}. A search-friendly version of the species' scientific name.}
#'   \item{core_id}{\code{character}. A unique identifier linking taxon data with distribution and threat status data.}
#'   \item{scientific_name}{\code{character}. The full scientific name of the taxon, including authorship.}
#'   \item{kingdom}{\code{character}. The kingdom classification of the taxon (e.g., PLANTAE).}
#'   \item{phylum}{\code{character}. The phylum classification of the taxon.}
#'   \item{class}{\code{character}. The class of the taxon.}
#'   \item{order}{\code{character}. The taxonomic order of the taxon.}
#'   \item{family}{\code{character}. The taxonomic family to which the taxon belongs.}
#'   \item{genus}{\code{character}. The genus to which the taxon belongs.}
#'   \item{specific_epithet}{\code{character}. The specific epithet of the taxon, forming the species name along with the genus.}
#'   \item{scientific_name_authorship}{\code{character}. The author(s) who described the taxon.}
#'   \item{taxon_rank}{\code{character}. The rank of the taxon (e.g., species, subspecies, variety).}
#'   \item{infraspecific_epithet}{\code{character}. The epithet for infraspecific taxa, such as subspecies or varieties, if applicable.}
#'   \item{infrasp_tag}{\code{character}. Indicator of the rank for infraspecific taxa (e.g., subspecies, variety, forma).}
#'   \item{taxonomic_status}{\code{character}. The taxon's status, indicating whether it is an accepted name or a synonym.}
#'   \item{accepted_name_usage_id}{\code{integer}. The identifier of the accepted name for synonyms, or the same as the core ID for accepted names.}
#'   \item{bibliographic_citation}{\code{character}. The citation for the taxon entry in the IUCN Red List.}
#'   \item{references}{\code{character}. A URL link to the IUCN Red List entry for the taxon.}
#'   \item{source}{\code{character}. The source of the distribution data.}
#'   \item{threat_status}{\code{character}. The IUCN conservation status of the species (e.g., "Endangered", "Least Concern", "Vulnerable").}
#'   \item{occurrence_status}{\code{character}. Indicates whether the taxon is present or absent in a given locality (e.g., "Present", "Absent").}
#' }
#'
#' The data is sourced from two primary files:
#' 1. `taxon.txt`: Provides taxonomic information, including scientific names, taxon ranks, and accepted name usage IDs.
#' 2. `distribution.txt`: Contains information about the IUCN threat status and occurrence for each taxon.
#'
#' @source
#' The IUCN Red List of Threatened Species, available through GBIF: \url{https://www.gbif.org/dataset/19491596-35ae-4a91-9a98-85cf505f1bd3}
#'
#' @examples
#' # Load the data
#' data(iucn_data)
#'
#' # View the first few rows of the dataset
#' head(iucn_data)
#'
"iucn_data"
