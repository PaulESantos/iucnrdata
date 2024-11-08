% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/checks.R
\name{get_iucn_upload_date}
\alias{get_iucn_upload_date}
\title{Get the Upload Date of the IUCN Data File}
\usage{
get_iucn_upload_date()
}
\value{
A character string with the last upload date in "YYYY-MM-DD" format, or \code{NULL} if the date cannot be retrieved.
}
\description{
This function retrieves the last modification date of the iucn_data file
from the GitHub repository.
}
