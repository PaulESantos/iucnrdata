#' IUCN Red List Vernacular Names Data
#'
#' This dataset contains vernacular (common) names for species included in the IUCN Red List of Threatened Species. The vernacular names are provided in various languages, and for some species, multiple common names exist. Each vernacular name is linked to a taxon from the core dataset through a unique identifier.
#'
#' @format A tibble with 156,417 rows and 4 variables:
#' \describe{
#'   \item{core_id}{\code{integer}. A unique identifier linking the vernacular name to the corresponding taxon in the core dataset.}
#'   \item{language}{\code{character}. The language in which the vernacular name is provided, using standard language codes (e.g., "fra" for French, "eng" for English).}
#'   \item{vernacular_name}{\code{character}. The common or vernacular name of the species in the specified language.}
#'   \item{is_preferred_name}{\code{logical}. Indicates whether the vernacular name is the preferred name (\code{TRUE}) or an alternative name (\code{FALSE}).}
#' }
#'
#' This dataset provides essential information for understanding the
#' common names of species in different languages, which can be useful
#' for local conservation efforts and public communication about species.
#'
#' @source
#' The IUCN Red List of Threatened Species, available through GBIF: \url{https://www.gbif.org/dataset/19491596-35ae-4a91-9a98-85cf505f1bd3}
#'
#' @examples
#' # Load the data
#' data(vernacular_name)
#'
#' # View the first few rows of the dataset
#' head(vernacular_name)
#'
"vernacular_name"
