#' Repair Singly Escaped Space Characters
#'
#' Prevent "lexical error: invalid character inside string.", see
#' https://github.com/jeroen/jsonlite/issues/47 and
#' https://github.com/TIBHannover/BacDiveR/issues/43
#'
#' @param JSON A character string containing JSON with invalidly, singly
#'  escaped space characters
#'
#' @return A character string with JSON and correctly, doubly escaped
#'  space characters
repair_escaping <- function(JSON, char) {
  gsub(
    pattern = paste0("\\", char),
    replacement = paste0("\\\\", char),
    perl = TRUE,
    JSON
  )
}
