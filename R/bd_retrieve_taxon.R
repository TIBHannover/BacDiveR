#' @rdname bd_retrieve
#' @param name Mandatory character string, specifying the taxon. Abbreviations
#'   like "B. halotolerans" are not allowed!
#' @export
#' @examples
#' datasets_Bh <- bd_retrieve_taxon(name = "Bacillus halotolerans")
#' datasets_Thh <- bd_retrieve_taxon(name = "Tetragenococcus halophilus halophilus")
bd_retrieve_taxon <- function(name) {
  bd_retrieve_data(searchTerm = name, searchType = "taxon")
}
