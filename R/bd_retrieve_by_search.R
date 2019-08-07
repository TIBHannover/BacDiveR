#' Retrieve the Results of an Advanced Search
#'
#' [BacDive.DSMZ.de/AdvSearch](https://bacdive.dsmz.de/advsearch) returns a
#' list of results, which you can retrieve in bulk via the URL of the results
#' page. Please see the [vignette "Pre-Configuring Advanced Searches and
#' Retrieving the Results"](https://tibhannover.github.io/BacDiveR/articles/pre-configuring-advanced-searches-and-retrieving-the-results.html#mass-downloading-datasets).
#'
#'
#' @param queryURL Mandatory character string. URL the search results page.
#'
#' @inherit bd_retrieve return
#' @export
#'
#' @examples
#' plant_animal_pathogens <-
#'   bd_retrieve_by_search(
#'     queryURL = paste(
#'       "https://bacdive.dsmz.de/advsearch?site=advsearchsearch",
#'       "params%5B5%5D%5Bsearchterm%5D=1",
#'       "searchparams%5B157%5D%5Bsearchterm%5D=1",
#'       "searchparams%5B158%5D%5Bsearchterm%5D=1",
#'       "advsearch=search",
#'       sep = "&"
#'     )
#'   )
bd_retrieve_by_search <- function(queryURL) {
  # guard against other URLs
  if (!grepl(pattern = "^https:\\/\\/bacdive\\.dsmz\\.de\\/advsearch", queryURL) |
    !grepl("[?&]site=advsearch", queryURL) |
    !grepl("[?&]advsearch=search", queryURL) |
    !grepl("\\&searchparams", queryURL)) {
    stop(
      "I'm sorry, but this doesn't seem like an advanced search URL from
 https://BacDive.DSMZ.de/advsearch! Aborting...\nPlease read
 https://TIBHannover.GitHub.io/BacDiveR/#how-to-use"
    )
  }

  DL_param <- "&csv_bacdive_ids_advsearch=download"

  # ensure that file with result IDs gets downloaded
  if (!grepl(pattern = paste0(DL_param, "$"), x = queryURL)) {
    queryURL <- paste0(queryURL, DL_param)
  }

  cred <- get_credentials()
  response <-
    httr::GET(queryURL, httr::authenticate(cred[1], cred[2]))
  payload <-
    httr::content(response, as = "text", encoding = "UTF-8")

  if (grepl("^[[:digit:]]", payload)) {
    aggregate_datasets(
      payload = strsplit(x = payload, split = "\\n")[[1]],
      from_IDs = TRUE
    )
  } else if (grepl("^<!DOCTYPE", payload)) {
    warning("No datasets found. Please check your advanced search and copy-paste the URL again.")
    list()
  } # needed for logic-checking datasets, see vignette
}
