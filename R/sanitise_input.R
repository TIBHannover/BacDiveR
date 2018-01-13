#' Split taxon searchTerm
#'
#' @inheritParams retrieve_data
#'
#' @return A character string with possibly sanitised searchType, see examples.
#'
#' @examples sanitise_input("Bacillus subtilis") # "Bacillus/subtilis"
#'   sanitise_input("B. subtilis") # ERROR
sanitise_input <- function(searchTerm, searchType) {
  if (grepl(pattern = "[^[:alnum:] ]", x = searchTerm))
    stop(
      "Illegal character detected! My apologies, but your search can only contain letters, numbers and white-space. Abbreviating genus names (e.g. 'B. subtilis') is not supported. Please spell out your searchTerm ('Bacillus subtilis'), don't use any 'special' characters and try again."
    )

  if (searchType == "taxon" & grepl(pattern = " ", x = searchTerm))
    searchTerm <- gsub(pattern = " ",
                       replacement = "/",
                       x = searchTerm)

  return(searchTerm)
}
