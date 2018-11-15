#' Retrieve Results of an Advanced Search/Query
#'
#' @param queryURL URL of a query prepared on [BacDive.DSMZ.de/AdvSearch](https://bacdive.dsmz.de/advsearch),
#'   as explained in the vignette "Pre-Configuring Advanced Searches and Retrieving the Results".
#'
#' @inherit retrieve_data return
#' @export
#'
#' @examples
#'   \donttest{data_miller <- retrieve_search_results(queryURL = "https://bacdive.dsmz.de/advsearch?site=advsearch&searchparams[78][contenttype]=text&searchparams[78][typecontent]=contains&searchparams[78][searchterm]=Miller&advsearch=search")}
#'
retrieve_search_results <- function(queryURL) {

  # guard against other URLs
  if (!grepl(pattern = "^https:\\/\\/bacdive\\.dsmz\\.de\\/advsearch", queryURL) |
    !grepl("[?&]site=advsearch", queryURL) |
    !grepl("[?&]advsearch=search", queryURL) |
    !grepl("\\&searchparams", queryURL)) {
    stop(
      "This isn't an advanced search URL from https://BacDive.DSMZ.de/advsearch! Aborting...\nPlease read https://TIBHannover.GitHub.io/BacDiveR/#how-to-use"
    )
  }

  download_param <- "&csv_bacdive_ids_advsearch=download"

  if (!grepl(pattern = paste0(download_param, "$"), x = queryURL)) {
    queryURL <- paste0(queryURL, download_param)
  }

  cred <- get_credentials()

  payload <- httr::GET(queryURL, httr::authenticate(cred[1], cred[2]))
  payload <- httr::content(payload, as = "text", encoding = "UTF-8")

  if (grepl("^[[:digit:]]", payload)) {
    aggregate_datasets(
      payload = strsplit(x = payload, split = "\\n")[[1]],
      from_IDs = TRUE
    )
  } else if (grepl("^<!DOCTYPE", payload)) {
    list()
  } # needed for logic-checking datasets, see vignette
}
