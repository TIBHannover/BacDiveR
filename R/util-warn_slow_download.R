warn_slow_download <- function(N_datasets) {
  if (N_datasets > 20) {
    min <- floor(N_datasets / 4)
    max <- ceiling(N_datasets / 2)

    message(
      "Downloading ",
      N_datasets,
      " datasets will probably take ",
      ifelse(
        min > 3600,
        yes = floor(min / 3600),
        no = ifelse(min < 60, min, floor(min / 60))
      ),
      " to ",
      ifelse(min > 3600,
        ceiling(min / 3600),
        ifelse(min < 60, max, ceiling(max / 60))
      ),
      ifelse(min > 3600,
        " hours",
        ifelse(min < 60, " seconds", " minutes")
      ),
      ".",
      ifelse(
        min > 1800,
        " Maybe work on something else in the meantime ;-)",
        ifelse(min > 180, " Maybe go for a walk ;-)", "")
      )
    )
    # numbers based on a measurement of:
    #   bd_retrieve_taxon("Bacillus subtilis subtilis")
    #   bd_retrieve_taxon("Pseudomonas")
    #   bd_retrieve_by_search("https://bacdive.dsmz.de/advsearch?advsearch=search&site=advsearch&searchparams%5B70%5D%5Bcontenttype%5D=text&searchparams%5B70%5D%5Btypecontent%5D=contains&searchparams%5B70%5D%5Bsearchterm%5D=archaea")
    #   bd_retrieve_by_search("https://bacdive.dsmz.de/advsearch?advsearch=search&site=advsearch&searchparams%5B70%5D%5Bcontenttype%5D=text&searchparams%5B70%5D%5Btypecontent%5D=contains&searchparams%5B70%5D%5Bsearchterm%5D=bacteria")
    # resulting in: 31.83312, 260.64956, 171.851 and 25353.37 s respectively, indicating a download
    # rate of about 2 to 4 datasets per second.
  }
}
