aggregate_datasets <- function(payload)
{
  URLs <- aggregate_result_URLs(payload)
  IDs <- URLs_to_IDs(URLs)
  message("Data download in progress for BacDive-IDs: ", appendLF = FALSE)

  taxon_data <- list()
  for (i in seq(length(URLs))) {
    message(IDs[i], " ", appendLF = FALSE)
    taxon_data[i] <- download(paste0(URLs[i], "?format=json"))
  }
  taxon_data <- lapply(taxon_data, jsonlite::fromJSON)
  names(taxon_data) <- IDs
  return(taxon_data)
}