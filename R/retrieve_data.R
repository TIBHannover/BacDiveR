#' @export
retrieve_data <- function(searchTerm,
                          searchType = "taxon") {
  .Deprecated(
    c(
      "bd_retrieve_by_culture",
      "bd_retrieve_by_sequence",
      "bd_retrieve",
      "bd_retrieve_taxon"
    )
  )

  # guard against invalid input
  searchTerm <- sanitise_term(searchTerm)
  searchType <- sanitise_type(searchType)

  bd_retrieve_data(searchTerm, searchType)
}

#' @export
bd_retrieve_data <- function(searchTerm, searchType = "taxon") {

  # expand taxon/species
  if (identical(searchType, "taxon") & grepl("\\s", searchTerm)) {
    searchTerm <- sanitise_taxon(searchTerm)
  }

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
    warning(
      "BacDive responded: 'Not found' to our query for '",
      searchType,
      " = ",
      searchTerm,
      "'. Please double-check both these query parameters, or try https://BacDive.DSMZ.de/AdvSearch"
    )

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


sanitise_term <- function(searchTerm) {
  if (grepl(
    pattern = "[^[:alnum:] ]",
    x = searchTerm,
    ignore.case = TRUE
  ) |
    grepl("(true|false|nil)", searchTerm, ignore.case = TRUE)) {
    stop(
      "Illegal character detected! My apologies, but your search can only contain letters, numbers and white-space. Abbreviating genus names (e.g. 'B. subtilis') is not supported. Please spell out your searchTerm ('Bacillus subtilis'), don't use any 'special' characters and try again."
    )
  } else {
    searchTerm
  }
}


sanitise_type <- function(searchType) {
  if (!(searchType %in% c("bacdive_id", "culturecollectionno", "sequence", "taxon"))) {
    stop("'", searchType, "' isn't a valid search against https://BacDive.DSMZ.de/api/bacdive/! Aborting... Please read https://TIBHannover.GitHub.io/BacDiveR/#how-to-use")
  }
  else {
    searchType
  }
}


sanitise_taxon <- function(searchTerm) {
  gsub(pattern = "\\s", replacement = "/", searchTerm)
}
