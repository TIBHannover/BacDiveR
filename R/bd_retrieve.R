#' Retrieve (a) Dataset(s) from BacDive
#'
#' This function family replaces the old `retrieve_data(searchTerm = "…", searchType = "…")`
#' function. It still works, but is deprecated and will be removed soon.
#' Please update your scripts to these new functions!
#'
#' @param id Mandatory character string or integer. The BacDive strain ID
#'   whose data you want to retrieve.
#'
#' @return A (large) list containing either a single BacDive dataset in case
#'   your parameter / search was unambiguous, or if ambiguous: all matching datasets.
#'   Read [BacDive.DSMZ.de/api/bacdive](https://bacdive.dsmz.de/api/bacdive/)
#'   to learn more.
#'
#' @export
#' @examples
#' \dontrun{
#' \donttest{
#' dataset_717 <- bd_retrieve(id = 717)
#' dataset_717 <- bd_retrieve(id = "717")
#' }}
#' @rdname bd_retrieve
bd_retrieve <- function(id) {
  bd_retrieve_data(searchTerm = as.character(id), searchType = "bacdive_id")
}
