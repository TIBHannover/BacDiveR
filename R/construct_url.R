construct_url <- function(searchTerm,
                          searchType = "bacdive_id") {
  # reconstruct taxon search from "Genus species subspecies" input, or
  # hierarchical part thereof
  if (searchType == "taxon") {
    searchTerm <- paste(collapse = "/",
                        # paste0() or paste(sep = "/", …) not useful here,
                        # because list items aren't themselves pasted together.
                        strsplit(searchTerm, " ")[[1]])
  }

  URLencode(paste0(
    "https://bacdive.dsmz.de/api/bacdive/",
    searchType,
    "/",
    searchTerm,
    "/"
  ))
}
