aggregate_datasets <- function(payload, from_IDs = FALSE)
{
  if (from_IDs)
  {
    IDs <- payload
    URLs <- purrr::map_chr(.x = IDs, .f = construct_url)
  }
  else
  {
    URLs <- aggregate_result_URLs(payload)
    IDs <- URLs_to_IDs(URLs)
  }

  message("Data download in progress for BacDive-IDs: ", appendLF = FALSE)
  taxon_data <- purrr::map(URLs, download)
  taxon_data <- purrr::map(taxon_data, jsonlite::fromJSON)
  names(taxon_data) <- IDs

  return(taxon_data)
}
