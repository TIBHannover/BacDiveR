#' @rdname bd_retrieve
#' @param accession Mandatory character string of a sequence accession number.
#' @export
#' @examples
#' \donttest{
#' dataset_AJ000733 <- bd_retrieve_by_sequence(accession = "AJ000733")
#' }
bd_retrieve_by_sequence <- function(accession) {
  bd_retrieve_data(searchTerm = accession, searchType = "sequence")
}
