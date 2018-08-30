#' Repair Singly Escaped Space Characters
#'
#' Prevent "lexical error: invalid character inside string.", see
#' https://github.com/jeroen/jsonlite/issues/47 and
#' https://github.com/TIBHannover/BacDiveR/issues/43.
#'
#' @param JSON A character string containing JSON with invalidly, singly
#'  \-escaped whitespace characters
#'
#' @return A character string containing JSON and _correctly, doubly_ \-escaped
#'   whitespace characters
repair_escaping <- function(JSON) {

  if (grepl("\\r", x = JSON))
    JSON <- purrr::map_chr(.x = JSON, .f = repair, char = "r")

  if (grepl("\\n", JSON))
    JSON <- purrr::map_chr(JSON, repair, "n")

  if (grepl("\\t", JSON))
    JSON <- purrr::map_chr(JSON, repair, "t")

  return(JSON)
}

repair <- function(JSON, char) {
  gsub(
    pattern = paste0("\\", char),
    replacement = paste0("\\\\", char),
    perl = TRUE,
    JSON
  )
}
