#' Construct URLs of API searches
#'
#' @inheritParams retrieve_data
construct_url <- function(searchTerm,
                          searchType = "bacdive_id",
                          force = FALSE) {

  if (searchType == "taxon") {
    # reconstruct taxon search from "Genus species subspecies" input, or
    # hierarchical part thereof
    searchTerm <- paste(collapse = "/",
                        # paste0() or paste(sep = "/", …) not useful here,
                        # because list items aren't themselves pasted together.
                        strsplit(searchTerm, " ")[[1]])
  }

  if (!force) {
  sanitised <- sanitise_input(searchTerm, searchType)
  searchTerm <- sanitised[1]
  searchType <- sanitised[2]
  }

  URLencode(
    paste0(
      "https://bacdive.dsmz.de/api/bacdive/",
      searchType,
      "/",
      searchTerm,
      "/?format=json"
    )
  )
}

sanitise_input <- function(searchTerm, searchType) {
  # [ ] enable different spellings, abbreviations etc. by funneling them to the
  #   searchTypes / endpoint designations
  # [ ] warnings for each automatic substitions

  if (searchType != "bacdive_id" &
      (grepl("^[0-9]+$", searchTerm))) {
    searchType <- "bacdive_id"
  } else if (searchType != "sequence" &
             grepl(pattern = "([A-Z][0-9]{5}|[A-Z]{2}[0-9]{6})",
                   x = searchTerm)) {
    # detect nucleotide accession / sequence numbers by matching:
    # 1 letter + 5 numerals OR 2 letters + 6 numerals
    # https://www.ncbi.nlm.nih.gov/Sequin/acc.html
    searchType <- "sequence"
  }
  else if (searchType != "culturecollectionno" &
           grepl(
             "(ACM|ATCC|CIP|DSM|ICPB|JCM|LMG|NCDO|NCTC|PS|QUM)+ [0-9]+(-[0-9]+)?",
             searchTerm
           )) {
    searchType <- "culturecollectionno"
  }

  c(searchTerm, searchType)
}
