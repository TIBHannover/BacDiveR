warn_slow_download <- function(N_datasets)
  {
  warning(
    paste0(
      N_datasets,
      " BacDive datasets are being downloaded... Please note: Depending on your internet connection speed, and the BacDive server load right now, this might take some time and may cause R(Studio) to become temporarily unresponsive. Maybe go for a walk for a few (I'm guessing: ",
      round(N_datasets / 4 / 60, 1),
      " to ",
      round(N_datasets / 3 / 60, 1),
      ") minutes ;-)\n\n"
    )
  )
  # numbers based on a microbenchmark of:
  #   retrieve_data(searchTerm = "Bacillus subtilis subtilis",
  #                 searchType = "taxon",
  #                 force_taxon_download = TRUE)
  #   retrieve_data(searchTerm = "Pseudomonas",
  #                 searchType = "taxon",
  #                 force_taxon_download = TRUE)
  # resulting in: 31.83312 and 260.64956 s respectively, indicating a download
  # rate of about 3 to 4 datasets per second.
}
