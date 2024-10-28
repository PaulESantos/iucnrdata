## code to prepare `get_iucn_data` dataset goes here
library(tidyverse)
# download The IUCN Red List of Threatened Species ----
# from https://www.gbif.org/dataset/19491596-35ae-4a91-9a98-85cf505f1bd3

url <- "https://hosted-datasets.gbif.org/datasets/iucn/iucn-2022-1.zip"


# if site down, use emergency script to update (not part of package)
# or wait until site is back up

# download to temporary place and extract
temp <- tempfile()
download.file(url, temp)
unzip(temp, exdir="iucn-files")

# load data files
# taxon names data
taxon_data <- arrow::read_tsv_arrow("raw_data/taxon.txt",
                                   col_names = FALSE)
colnames(taxon_data) <-   c(
  "core_id",
  "scientific_name",
  "kingdom",
  "phylum",
  "class",
  "order",
  "family",
  "genus",
  "specific_epithet",
  "scientific_name_authorship",
  "taxon_rank",
  "infraspecific_epithet",
  "taxonomic_status",
  "accepted_name_usage_id",
  "bibliographic_citation",
  "references")
# Variables description:
# `core_id`: A unique identifier for each taxon record, linking to the
#           core dataset.
# `scientific_name`: The full scientific name of the species or taxon,
#           including the author name.
# `kingdom`: The kingdom to which the taxon belongs (e.g., PLANTAE).
# `phylum`: The phylum classification of the taxon (e.g., TRACHEOPHYTA).
# `class`: The class of the taxon.
# `order`: The taxonomic order of the taxon.
# `family`: The taxonomic family of the taxon.
# `genus`: The genus to which the taxon belongs.
# `specific_epithet`: The specific epithet, which combined with the
#           genus forms the species name.
# `scientific_name_authorship`: The author(s) who described the taxon.
# `taxon_rank`: The rank of the taxon (e.g., species, subspecies).
#  `species`
#  `subspecies (plantae)`
#  `variety`
#  `subspecies`
#  `forma`

# `infraspecific_epithet`: The epithet for infraspecific taxa.
# `taxonomic_status`: The taxon’s status, indicating whether it is
#           accepted or a synonym.
# `accepted_name_usage_id`: The ID of the accepted name if the taxon is
#           a synonym, or its own ID if accepted. this tag id is used
#           to link taxon data with other dataset distribution and
#           vernacular name.
# `bibliographic_citation`: The full citation for the taxon’s entry in
#           the IUCN Red List, including authors and year.
# `references`: A URL link to the IUCN Red List entry for the taxon.

# distribution data
distribution_data <- arrow::read_tsv_arrow("raw_data/distribution.txt",
                                   col_names = FALSE)
colnames(distribution_data) <- c("core_id",
                           "source",
                           "establishment_means",
                           "threat_status",
                           "country_code",
                           "locality", "occurrence_status")
# Variables description:
# - `core_id`: A unique identifier for each record, linking to a specific taxon or entity in the core dataset.
# - `establishment_means`: No information available.
# - `country_code`: No information available.
# - `locality`: Contains only the value "Global"
# - `occurrence_status`: Values include "Present" and "Absent"
# - `threat_status`: Contains the following values:
#   - "Endangered"
#   - "Least Concern"
#   - "Near Threatened"
#   - "Vulnerable"
#   - "Critically Endangered"
#   - "Data Deficient"
#   - "Extinct"
#   - "Extinct in the Wild"
#   - "least concern"
#   - "near threatened"
#   - "conservation dependent"

###

# Merging taxon data with distribution data
# This step adds the threat status from the distribution data to the
# taxon data

iucn_data <- taxon_data |>
  dplyr::left_join(distribution_data,
            by = c("accepted_name_usage_id" = "core_id")) |>
  dplyr::select(-c(establishment_means, country_code, locality)) |>
  dplyr::mutate(scientific_name = dplyr::if_else(
    scientific_name == "Barleria mpandensis ssp. mpandensis",
    "Barleria mpandensis subsp. mpandensis",
    scientific_name
  )) |>
  dplyr::mutate(taxon_rank = dplyr::if_else(
    scientific_name == "Barleria mpandensis subsp. mpandensis",
    "subspecies (plantae)",
    taxon_rank
  )) |>
  dplyr::mutate(infrasp_tag = dplyr::case_when(
    kingdom == "ANIMALIA" & taxon_rank == "subspecies" ~ "ssp.",
    kingdom == "FUNGI" & taxon_rank == "variety" ~  "var.",
    kingdom == "FUNGI" & taxon_rank == "subspecies" ~ "ssp.",
    kingdom == "PLANTAE" & taxon_rank == "subspecies (plantae)" ~ "subsp.",
    kingdom == "PLANTAE" & taxon_rank == "variety" ~  "var.",
    kingdom == "PLANTAE" & taxon_rank == "forma" ~ "fma.",
    TRUE ~ NA_character_
  )) |>
#  dplyr::select(scientific_name,
#                family,
#                genus,
#                specific_epithet,
#                infraspecific_epithet,
#                infrasp_tag,
#                taxon_rank,
#                taxonomic_status,
#                accepted_name_usage_id,
#                core_id,
#                threat_status
#  ) |>
  dplyr::mutate(search_name = dplyr::case_when(
    is.na(infrasp_tag) ~ paste0(genus, " ", specific_epithet),
    !is.na(infrasp_tag) ~ paste0(genus, " ",
                                 specific_epithet, " ",
                                 infrasp_tag, " ",
                                 infraspecific_epithet)
  ) ) |>
  dplyr::mutate(threat_status = stringr::str_to_sentence(threat_status)) |>
  dplyr::filter(taxonomic_status == "accepted") |>
  dplyr::relocate(search_name)

usethis::use_data(iucn_data,
                  compress = "xz",
                  ascii = TRUE,
                  overwrite = TRUE)

# vernacular names data
vernacular_name <- arrow::read_tsv_arrow("raw_data/vernacularname.txt",
                                         col_names = FALSE)
colnames(vernacular_name) <- c("core_id", "language",
                               "vernacular_name",
                               "is_preferred_name")
# Variables description:
# `core_id`: A unique identifier for each record, linking to a specific taxon or entity in the core dataset.
# `language`: The language in which the vernacular (common) name is
#             provided. For example, "fra" for French, "eng" for
#             English, etc.
# `vernacular_name`: The common or vernacular name of the species in
#                    the specified language.
# `is_preferred_name`: A logical variable indicating whether the
#                      vernacular name is the preferred name (TRUE)
#                      or an alternative name (FALSE).


vernacular_name <- vernacular_name |>
  dplyr::mutate(language = stringr::str_to_upper(language) )


usethis::use_data(vernacular_name,
                  compress = "xz",
                  overwrite = TRUE)
