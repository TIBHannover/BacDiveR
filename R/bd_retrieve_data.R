#' @keywords internal
bd_retrieve_data <- function(searchTerm, searchType) {
  searchType <- sanitise_type(searchType)
  searchTerm <- sanitise_term(searchTerm, searchType)

  payload <- download(construct_url(searchTerm, searchType))

  if (is_dataset(payload)) {
    payload <- list(payload)
    names(payload) <- searchTerm
    return(payload)
  }
  else if (is_ID_reference(payload)) {
    bd_retrieve_data(
      searchTerm = URLs_to_IDs(payload$url),
      searchType = "bacdive_id"
    )
  }
  else if (is_results_list(payload)) {
    aggregate_datasets(payload)
  }
  else if (identical(payload$detail, "Not found")) {
    warning(
      "BacDive responded: '", payload$detail,
      "' to our last search for '", searchTerm,
      "'. Please double-check this parameter or try https://TIBHannover.GitHub.io/BacDiveR/articles/pre-configuring-advanced-searches-and-retrieving-the-results.html"
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

is_ID_reference <- function(payload) {
  all.equal(nrow(payload), ncol(payload), 1) &
    "url" %in% names(payload)
}


sanitise_term <- function(searchTerm, searchType) {
  if (grepl(
    pattern = "[^[:alnum:] ]",
    x = searchTerm,
    ignore.case = TRUE
  ) |
    grepl("(true|false|nil)", searchTerm, ignore.case = TRUE)) {
    stop(
      "Illegal character detected! My apologies, but your search can only contain letters, numbers and white-space. Abbreviating genus names (e.g. 'B. subtilis') is not supported. Please spell out your searchTerm ('Bacillus subtilis'), don't use any 'special' characters and try again."
    )
  } else if (identical(searchType, "taxon") & grepl("\\s", searchTerm)) {
    gsub(pattern = "\\s", replacement = "/", searchTerm)
    # expand "Taxon species" to "taxon/species"
  } else {
    searchTerm
  }
}


sanitise_type <- function(searchType) {
  if (!(searchType %in% c("bacdive_id", "culturecollectionno", "sequence", "taxon"))) {
    stop(
      "'",
      searchType,
      "' isn't a valid search against https://BacDive.DSMZ.de/api/bacdive/! Aborting... Please read https://TIBHannover.GitHub.io/BacDiveR/#how-to-use"
    )
  }
  else {
    searchType
  }
}


construct_url <- function(searchTerm,
                          searchType = "bacdive_id") {
  utils::URLencode(
    paste(
      "https://bacdive.dsmz.de/api/bacdive",
      searchType,
      searchTerm,
      "?format=json",
      sep = "/"
    )
  )
}
