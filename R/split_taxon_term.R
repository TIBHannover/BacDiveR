#' Split taxon searchTerm
#'
#' @inherit retrieve_data param searchTerm
#'
#' @inherit paste return
#'
#' @examples split_taxon_URL("Bacillus subtilis subtilis")
#'   => "Bacillus/subtilis/subtilis"
split_taxon_term <- function(searchTerm) {
  gsub(pattern = " ", replacement = "/", x = searchTerm)
}
