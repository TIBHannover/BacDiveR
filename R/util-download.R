#' Download Something from BacDive
#'
#' @param URL A correctly encoded character string, either from construct_url()
#'   or a JSON list
#'
#' @return The R object unserialised from the downloaded JSON
#' @keywords internal
download <- function(URL) {
  message(URLs_to_IDs(URL), " ", appendLF = FALSE)

  cred <- get_credentials()

  payload <- httr::GET(URL, httr::authenticate(cred[1], cred[2]))
  payload <- httr::content(payload, as = "text", encoding = "UTF-8")
  jsonlite::fromJSON(payload)
}
