#' Download Something from BacDive
#'
#' Both `user` and `password` are read from the .Renviron file by default.
#'
#' @param URL A correctly encoded character string, either from construct_url()
#'   or a JSON list
#'
#' @return The R object deserialised from the downloaded JSON
#' @keywords internal
download <- function(URL, user = get_credentials()[1], password = get_credentials()[2]) {
  message(URLs_to_IDs(URL), " ", appendLF = FALSE)

  response <- httr::GET(URL, httr::authenticate(user, password))
  payload <- httr::content(response, as = "text", encoding = "UTF-8")
  jsonlite::fromJSON(payload)
}
