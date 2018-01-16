#' Guess Search Type
#'
#' @inheritParams retrieve_data
#'
#' @return a character vector containing the searchTerm again, and the possibly
#'   second-guessed searchType
#'
guess_searchType <- function(searchTerm, searchType) {
  searchType_ori <- searchType

  if (searchType != "bacdive_id" &
      grepl("^[0-9]+$", searchTerm) |
      searchType == "bacdive-id" |
      searchType == "bacdiveid" |
      searchType == "id") {
    searchType <- "bacdive_id"
  } else if (searchType != "sequence" &
             grepl(pattern = "([A-Z][0-9]{5}|[A-Z]{2}[0-9]{6})",
                   x = searchTerm) |
             searchType == "accession") {
    # detect nucleotide accession / sequence numbers by matching:
    # 1 letter + 5 numerals OR 2 letters + 6 numerals
    # https://www.ncbi.nlm.nih.gov/Sequin/acc.html
    searchType <- "sequence"
  }
  else if (searchType != "culturecollectionno" &
           grepl(x = searchTerm,
                 pattern = "(ACM|ATCC|CIP|DSM|ICPB|JCM|LMG|NCDO|NCTC|PS|QUM)+ [0-9]+(-[0-9]+)?") |
           searchType == "culturenumber" |
           searchType == "cultureno" |
           searchType == "collection" |
           searchType == "ccn") {
    searchType <- "culturecollectionno"
  } else if (searchType != "taxon" &
             !grepl("[0-9]+", x = searchTerm)) {
    searchType <- "taxon"
  }

  if (searchType != searchType_ori) {
    warning(
      paste0(
        "Your searchTerm seems to mismatch the provided searchType, but matches a '",
        searchType,
        "', so I searched for that. If you don't want me to second-guess your searchTerm-to-searchType combinations, please set force_search = FALSE."
      )
    )
  }

  return(searchType)
}
