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
  download_param <- "&csv_bacdive_ids_advsearch=download"

  if (!grepl(pattern = paste0(download_param, "$"), x = queryURL)) {
    queryURL <- paste0(queryURL, download_param)
  }

  payload <- RCurl::getURL(queryURL)

  if (grepl("^[[:digit:]]", payload)) {
    aggregate_datasets(strsplit(x = payload, split = "\\n")[[1]], from_IDs = TRUE)
  } else if (grepl("^<!DOCTYPE", payload)) {
    return(list())
  } # needed for logic-checking datasets, see vignette
}
