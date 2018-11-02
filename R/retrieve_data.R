#' Retrieve (a) Dataset(s) from BacDive
#'
#' @param searchTerm Mandatory character string (in case of `searchType = `
#'   `sequence`, `culturecollectionno` or `taxon`) or integer (in case of
#'   `bacdive_id`), specifying what shall be searched for.
#'
#' @param searchType Mandatory character string that specifies which type of
#'   search will be performed (technically, which API endpoint). Can be `taxon`
#'   (default), `bacdive_id`, `sequence`, or `culturecollectionno`.
#'
#' @return A list of lists containing either a single BacDive dataset in case
#'   the `searchTerm` was unambiguous (`bacdive_id`, `sequence`,
#'   `culturecollectionno`), or a large list containing all datasets that match
#'   an ambiguous `searchTerm` (most `taxon`s).
#'
#' @export
#' @examples
#'   \donttest{dataset_717 <- retrieve_data(searchTerm = 717, searchType = "bacdive_id")}
#'   \donttest{dataset_DSM_319 <- retrieve_data(searchTerm = "DSM 319", searchType = "culturecollectionno")}
#'   \donttest{dataset_AJ000733 <- retrieve_data(searchTerm = "AJ000733", searchType = "sequence")}
#'   \donttest{datasets_Bh <- retrieve_data(searchTerm = "Bacillus halotolerans")}
retrieve_data <- function(searchTerm,
                          searchType = "taxon") {
  payload <- download(construct_url(searchTerm, searchType))

  if (is_dataset(payload)) {
    payload <- list(payload)
    names(payload) <- searchTerm
    return(payload)
  }
  else if (is_ID_refererence(payload)) {
    retrieve_data(searchTerm = URLs_to_IDs(payload$url), searchType = "bacdive_id")
  }
  else if (is_results_list(payload)) {
    aggregate_datasets(payload)
  }
  else if (identical(payload$detail, "Not found")) {
    if (identical(searchType, "bacdive_id")) {
      warning(paste0("BacDive has no dataset with bacdive_id ", searchTerm, "."))
    } else {
      warning(paste0(
        "BacDive has no result for ", searchType, " = ", searchTerm, ". Please check that both terms are correct, type '?retrieve_data' and read through the 'searchType' section to learn more."
      ))
    }

    list()
  }
}


is_dataset <- function(payload) {
  identical(
    names(payload),
    c(
      "taxonomy_name",
      "morphology_physiology",
      "culture_growth_condition",
      "environment_sampling_isolation_source",
      "application_interaction",
      "molecular_biology",
      "strain_availability",
      "references"
    )
  )
}

is_results_list <- function(payload) {
  identical(names(payload), c("count", "next", "previous", "results"))
}

is_ID_refererence <- function(payload) {
  all.equal(nrow(payload), ncol(payload), 1) &&
    # class(payload) == "data.frame" &&
    names(payload) == "url"
  # && grepl("https://bacdive.dsmz.de/api/bacdive/bacdive_id/\\d+/",
  #          payload$url)
}
