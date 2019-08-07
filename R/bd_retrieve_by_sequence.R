#' @rdname bd_retrieve
#' @param accession Mandatory character string. A sequence accession number by
#'   which the associated dataset(s) will be retrieved.
#' @export
#' @examples
#' dataset_AJ000733 <- bd_retrieve_by_sequence(accession = "AJ000733")
bd_retrieve_by_sequence <- function(accession) {
  bd_retrieve_data(searchTerm = accession, searchType = "sequence")
}
