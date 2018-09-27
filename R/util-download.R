#' Download Something from BacDive
#'
#' @param URL represented by a correctly encoded character string with spaces,
#'   thanks to utils::URLencode.
#' @param userpwd A character string of the format
#'   `BacDive_email:BacDive_password`. Retrieved from `.Renviron` my default,
#'   but also used with something else by the tests.
#'
#' @return A serialised JSON string.
#' @keywords internal
download <-
  function(URL,
             userpwd = paste(get_credentials(), collapse = ":")) {
    message(URLs_to_IDs(URL), " ", appendLF = FALSE)

    payload <- RCurl::getURL(URL,
      userpwd = userpwd,
      httpauth = 1L
    )

    return(repair_escaping(payload))
    # Needs to remain here, not between jsonlite::fromJSON & download above,
    # because retrieve_search_results() doesn't call it directly, but only
    # through aggregate_datasets().
  }
