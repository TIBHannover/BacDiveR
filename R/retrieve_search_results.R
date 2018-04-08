retrieve_search_results <- function(queryURL) {

  download_param <- "&csv_bacdive_ids_advsearch=download"

  if (!grepl(pattern = paste0("$", download_param), x = queryURL))
      queryURL <- paste0(queryURL, download_param)

  result_IDs <- strsplit(x = RCurl::getURL(queryURL), split = "\\n")[[1]]

  aggregate_datasets(result_IDs, from_IDs = TRUE)
}
