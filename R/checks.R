#' Functions to help check the iucnr data is okay and up to date.

#' View the version of iucnrdata available.
#'
#' @param long Whether to return the version date with version number.
#'
#' @importFrom glue glue
#'
#' @export
#'
iucnrdata_version <- function(long=TRUE) {

  extraer_fecha <- function(fecha_texto) {
    # Extraer la parte de la fecha "AAAA-MM-DD" utilizando expresiones regulares
    fecha_match <- regmatches(fecha_texto, regexpr("\\d{4}-\\d{2}-\\d{2}", fecha_texto))

    # Convertir la cadena de texto a formato Date
    fecha_formato <- as.Date(fecha_match, format = "%Y-%m-%d")

    return(fecha_formato)
  }

  pkg_info <- utils::packageDescription("iucnrdata") # Cambia "nombre_del_paquete" por el nombre real del paquete

  # Extraer la versión y la fecha de publicación desde el metadata del paquete
  version <- pkg_info$Version
  version_date <- pkg_info$Packaged |> extraer_fecha()

  if (long) {
    glue::glue("Version {version} ({version_date})")
  } else {
    version
  }
}
iucnrdata_version()

#' Check if the packaged version of iucnr is up to date.
#'
#' @param silent Raise a warning if the version is out of date.
#'
#' @export
#'
iucn_check_version <- function(silent=FALSE) {
  latest_date <- get_iucn_upload_date()
  extraer_fecha <- function(fecha_texto) {
    # Extraer la parte de la fecha "AAAA-MM-DD" utilizando expresiones regulares
    fecha_match <- regmatches(fecha_texto, regexpr("\\d{4}-\\d{2}-\\d{2}", fecha_texto))

    # Convertir la cadena de texto a formato Date
    fecha_formato <- as.Date(fecha_match, format = "%Y-%m-%d")

    return(fecha_formato)
  }

  pkg_info <- utils::packageDescription("iucnrdata") # Cambia "nombre_del_paquete" por el nombre real del paquete

  # Extraer la versión y la fecha de publicación desde el metadata del paquete
  version <- pkg_info$Version
  version_date <- pkg_info$Packaged |> extraer_fecha()

  up_to_date <- latest_date == version_date

if (! silent & ! up_to_date) {
    msg <- glue::glue("iucnrdata not the most recent version!",
                      "Using {iucnrdata_version()} uploaded on {version_date}.",
                      "Latest version was uploaded on {latest_date}.",
                      .sep="\n")
    warning(msg)
  }

  up_to_date
}


#' Function to convert date from a specific format to 'ddmmyyyy'
#' @keywords internal
convert_repo_date <- function(date_input) {
  # Regular expression to extract date components
  pattern <- "^(\\w{3}),\\s+(\\d{1,2})\\s+(\\w{3})\\s+(\\d{4})\\s+\\d{2}:\\d{2}:\\d{2}\\s+GMT$"

  # Check if the input date matches the expected pattern
  if (grepl(pattern, date_input)) {

    # Mapping of month names to their corresponding numeric representations
    months <- c("Jan" = "01", "Feb" = "02", "Mar" = "03", "Apr" = "04",
                "May" = "05", "Jun" = "06", "Jul" = "07", "Aug" = "08",
                "Sep" = "09", "Oct" = "10", "Nov" = "11", "Dec" = "12")

    # Extract the date components using the regular expression
    date_formatted <- sub(pattern, "\\2 \\3 \\4", date_input)

    # Get the day, month (text), and year from the formatted date
    day <- substring(date_formatted, 1, 2)         # Day in numeric format
    month_text <- substring(date_formatted, 4, 6)   # Month in text format
    year <- substring(date_formatted, 8, 11)        # Year in numeric format

    # Convert the month from text to its numeric representation
    month_number <- months[month_text]

    # Construct the final date in 'ddmmyyyy' format
    final_date <- paste0(c(year, month_number, day), collapse = "-")
    return(final_date)  # Return the formatted date
  } else {
    # Raise an error if the input date does not match the expected format
    stop("The input date does not match the expected format.")
  }
}





#' Get the Upload Date of the IUCN Data File
#'
#' This function retrieves the last modification date of the iucn_data file
#' from the GitHub repository.
#'
#' @return A character string with the last upload date in "YYYY-MM-DD" format, or `NULL` if the date cannot be retrieved.
#' @importFrom httr GET headers status_code
#' @export
get_iucn_upload_date <- function() {
  # URL to check the last modification date of the data file on GitHub
  api_url <- "https://api.github.com/repos/PaulESantos/iucnrdata/contents/data/iucn_2024.rda"

  # Make a GET request to retrieve file metadata
  response <- httr::GET(api_url)
  # Check if the request was successful
  if (httr::status_code(response) == 404) {
    # Extract the last modified date from headers
    last_modified <- httr::headers(response)$`date`
    # Convert to "YYYY-MM-DD" format if last_modified exists
    if (!is.null(last_modified)) {
      upload_date <- convert_repo_date(last_modified)
      return(upload_date)
    } else {
      message("No last modified date available in headers.")
      return(NULL)
    }
  } else {
    message("Failed to retrieve the last modified date from GitHub.")
    return(NULL)
  }
}

#-------------------------
utils::globalVariables(c(
  "metadata"
))
