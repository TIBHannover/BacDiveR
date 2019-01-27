#' @rdname bd_retrieve
#' @param name Mandatory character string, specifying the taxon. Abbreviations
#'   like "B. halotolerans" are not allowed!
#' @export
#' @examples
#' \donttest{
#' datasets_Bh <- bd_retrieve_by_taxon(name = "Bacillus halotolerans")
#' datasets_Bss <- bd_retrieve_by_taxon(name = "Bacillus subtilis subtilis")
#' }
bd_retrieve_by_taxon <- function(name) {
  bd_retrieve_data(searchTerm = name, searchType = "taxon")
}
