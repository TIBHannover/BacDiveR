#' @rdname bd_retrieve
#' @param collection_no Mandatory character string. A culture collection
#'   number by which the associated dataset(s) will be retrieved.
#' @export
#' @examples
#' dataset_DSM_319 <- bd_retrieve_by_culture(collection_no = "DSM 319")
bd_retrieve_by_culture <- function(collection_no) {
  bd_retrieve_data(searchTerm = collection_no, searchType = "culturecollectionno")
}
