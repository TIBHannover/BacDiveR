#' Split taxon searchTerm
#'
#' @inheritParams retrieve_data
#'
#' @return A character string with possibly sanitised searchType, see example.
sanitise_input <- function(searchTerm, searchType) {
  if (grepl(pattern = "[^[:alnum:] ]",
            x = searchTerm,
            ignore.case = TRUE))
    stop(
      "Illegal character detected! My apologies, but your search can only contain letters, numbers and white-space. Abbreviating genus names (e.g. 'B. subtilis') is not supported. Please spell out your searchTerm ('Bacillus subtilis'), don't use any 'special' characters and try again."
    )

  if (identical(searchType, "taxon"))
    gsub(pattern = " ", replacement = "/", searchTerm)
  else
    searchTerm
}
