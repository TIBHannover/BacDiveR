#' Retrieve Results of an Advanced Search/Query
#'
#' @param queryURL URL of a query prepated on [BacDive.DSMZ.de/AdvSearch
#'   ](https://bacdive.dsmz.de/advsearch), as explained in the vignette "The
#'   semi-automatic approach: retrieving data through a pre-configured advanced
#'   search".
#'
#' @inherit retrieve_data return
#' @export
#'
#' @examples
#'   data_miller <- retrieve_search_results(queryURL = "https://bacdive.dsmz.de/advsearch?site=advsearch&searchparams[78][contenttype]=text&searchparams[78][typecontent]=contains&searchparams[78][searchterm]=Miller&advsearch=search")
#'
retrieve_search_results <- function(queryURL) {

  download_param <- "&csv_bacdive_ids_advsearch=download"

  if (!grepl(pattern = paste0("$", download_param), x = queryURL))
    queryURL <- paste0(queryURL, download_param)

  result_IDs <-
    strsplit(x = RCurl::getURL(queryURL), split = "\\n")[[1]]

  aggregate_datasets(result_IDs, from_IDs = TRUE)
}
