#' Split taxon searchTerm
#'
#' @inherit retrieve_data param searchTerm
#'
#' @inherit paste return
#'
#' @examples split_taxon_URL("Bacillus subtilis subtilis")
#'   => "Bacillus/subtilis/subtilis"
sanitise_input <- function(searchTerm, searchType) {
  if (grepl(pattern = "[^[:alnum:] ]", x = searchTerm))
    stop(
      "Illegal character detected! Your search can only contain letters, numbers and white-space. For example, abbreviations with dot ('B. subtilis') is not supported, I'm sorry. Please spell out your searchTerm ('Bacillus subtilis') and don't use any 'special' characters."
    )

  if (searchType == "taxon" & grepl(pattern = " ", x = searchTerm))
    searchTerm <- gsub(pattern = " ",
                       replacement = "/",
                       x = searchTerm)

  return(searchTerm)
}
