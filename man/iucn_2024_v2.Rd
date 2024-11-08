% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/iucn_2024_v2.R
\docType{data}
\name{iucn_2024_v2}
\alias{iucn_2024_v2}
\title{IUCN Red List Dataset 2024 (v2)}
\format{
A tibble with 166,061 rows and 16 variables:
\describe{
\item{assessment_id}{\code{integer}. Unique identifier for each IUCN assessment.}
\item{internal_taxon_id}{\code{integer}. Internal ID for each taxon within the IUCN system.}
\item{scientific_name}{\code{character}. The scientific name of the taxon.}
\item{kingdom_name}{\code{character}. The kingdom to which the taxon belongs.}
\item{phylum_name}{\code{character}. The phylum to which the taxon belongs.}
\item{order_name}{\code{character}. The order of the taxon.}
\item{class_name}{\code{character}. The class of the taxon.}
\item{family_name}{\code{character}. The family to which the taxon belongs.}
\item{genus_name}{\code{character}. The genus of the taxon.}
\item{species_name}{\code{character}. The species name of the taxon.}
\item{authority}{\code{character}. The taxonomic authority for the species, indicating the source of its scientific name.}
\item{redlist_category}{\code{character}. The IUCN Red List category of the taxon, indicating its conservation status (e.g., "Near Threatened", "Critically Endangered").}
\item{redlist_criteria}{\code{character}. The criteria used to assign the Red List category, providing justification for the conservation status.}
\item{criteria_version}{\code{numeric}. Version of the criteria used in the assessment, typically 3.1.}
\item{population_trend}{\code{character}. The current trend in the population of the taxon (e.g., "Decreasing", "Stable").}
\item{scopes}{\code{character}. Geographic scope of the assessment, such as "Global" or "Global & Europe".}
}

This updated dataset offers comprehensive data on the taxonomic and conservation status
of taxa assessed by the IUCN Red List, supporting biodiversity research, conservation planning,
and policy-making efforts.
}
\usage{
iucn_2024_v2
}
\description{
This dataset contains the International Union for Conservation of
Nature (IUCN) Red List taxonomy and assessment data for 166,061 taxa,
as of 2024. The dataset includes detailed information on taxonomic classification,
Red List Category, Red List Criteria, criteria version, and population trends.
}
\keyword{datasets}
