#' Download Something from BacDive
#'
#' Both `user` and `password` are read from the .Renviron file.
#'
#' @param URL A correctly encoded character string, either from construct_url()
#'   or a JSON list
#'
#' @return The R object deserialised from the downloaded JSON
#' @keywords internal
#' @import httr
#' @importFrom jsonlite fromJSON
download <- function(URL) {
  message(URLs_to_IDs(URL), " ", appendLF = FALSE)

  URL_p1 <- "^https:\\/\\/"
  URL_p2 <- "bacdive\\.dsmz\\.de\\/api\\/bacdive"

  # Check for "proper credentials" test in URL (see test-download.R),
  # or check for valid, but non-test BacDive URL
  if (grepl(paste0(URL_p1, "\\w+", ":", "\\w+", URL_p2), URL)) {
    response <- GET(URL)
  } else if (
    !grepl(paste0(URL_p1, URL_p2), URL) | !grepl("?format=json$", URL)) {
    stop("I refuse to connect to", URL, "because it's not a BacDive URL!")
  } else {
    cred <- get_credentials()
    response <- GET(URL, authenticate(cred[1], cred[2]))
  }

  payload <- content(response, as = "text", encoding = "UTF-8")
  data <- fromJSON(payload)

  if (response$status_code == 403) {
    stop(paste(data, "\nCheck your credentials (e.g. `file.show('~/.Renviron')` in and R console), and try copy-pasting your login credentials into https://bacdive.dsmz.de/api/bacdive/ to test them. Correct as necessary and try your data download again."))
  } else {
    return(data)
  }
}
