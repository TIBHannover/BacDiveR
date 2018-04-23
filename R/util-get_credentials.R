#' Read BacDive Login Credentials from .Renviron
#'
#' @param test Logical (default: `FALSE`). Only used by automatic tests.
#'
#' @return A vector or the two character strings `BacDive_email` and `BacDive_password` representing those two environment variables.
get_credentials <- function(test = FALSE) {
  readRenviron(get_Renviron_path())

  if (test == TRUE) {
    id <- Sys.getenv("BacDive_test_email")
    pw <- Sys.getenv("BacDive_test_password")
  } else {
    id <- Sys.getenv("BacDive_email")
    pw <- Sys.getenv("BacDive_password")
  }

  if (!nzchar(id) | !nzchar(pw))
    warning("BacDive login credentials not set completely.\n
             Please run `BacDiveR::prepare_Renviron()`.")
  else
    c(id, pw)
}
