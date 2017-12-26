guess_searchType <- function(searchTerm, searchType) {
  # [ ] enable different spellings, abbreviations etc. by funneling them to the
  #   searchTypes / endpoint designations

  searchType_ori <- searchType

  if (searchType != "bacdive_id" &
      grepl("^[0-9]+$", searchTerm)) {
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
  } else if (searchType != "taxon" &
             !grepl("[0-9]+", x = searchTerm)) {
    searchType <- "taxon"
  }

  if (searchType != searchType_ori) {
    warning(
      paste0(
        "searchType looked very much like a ",
        searchType,
        ", so I set it to that. If you don't want me to second-guess your inputs, please set force = FALSE"
      )
    )
  }

  c(searchTerm, searchType)
}
