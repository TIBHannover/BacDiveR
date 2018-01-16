#' Guess SearchType
#'
#' @inheritParams retrieve_data
#'
#' @return a character vector containing the searchTerm again, and the possibly
#'   second-guessed searchType
#'
guess_searchType <- function(searchTerm, searchType) {
  searchType_ori <- searchType

  searchType <- dplyr::case_when(
    searchType != "bacdive_id" &
      grepl("^[0-9]+$", searchTerm) |
      searchType == "bacdive-id" |
      searchType == "bacdiveid" |
      searchType == "id"
    ~ "bacdive_id",

    # detect nucleotide accession / sequence numbers by matching:
    # 1 letter + 5 numerals OR 2 letters + 6 numerals
    # https://www.ncbi.nlm.nih.gov/Sequin/acc.html
    searchType != "sequence" &
      grepl(pattern = "([A-Z][0-9]{5}|[A-Z]{2}[0-9]{6})",
            x = searchTerm) |
      searchType == "accession"
    ~ "sequence",

    searchType != "culturecollectionno" &
      grepl(x = searchTerm,
            pattern = "(ACM|ATCC|CIP|DSM|ICPB|JCM|LMG|NCDO|NCTC|PS|QUM)+ [0-9]+(-[0-9]+)?") |
      searchType == "culturenumber" |
      searchType == "cultureno" |
      searchType == "collection" |
      searchType == "ccn"
    ~ "culturecollectionno",

    searchType != "taxon" &
      !grepl("[0-9]+", x = searchTerm)
    ~ "taxon",

    TRUE ~ searchType
  )

  if (searchType != searchType_ori) {
    warning(
      paste0(
        "There seems to be a mismatch between your searchTerm ('",
        searchTerm,
        "') and your searchType ('",
        searchType_ori,
        "')! However, because the forlder matches the searchType '",
        searchType,
        "',I searched for that. If you don't want me to second-guess your searchTerm-to-searchType combinations, please set force_search = TRUE"
      )
    )
  }

  return(searchType)
}
