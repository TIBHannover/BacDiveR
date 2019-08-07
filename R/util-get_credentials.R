#' Read BacDive Login Credentials from .Renviron
#'
#' @return A vector or the two character strings `BacDive_email`
#'   and `BacDive_password` representing those two environment variables.
#' @keywords internal
get_credentials <- function() {
  readRenviron(construct_Renviron_path())

  id <- Sys.getenv("BacDive_email")
  pw <- Sys.getenv("BacDive_password")

  if (!nzchar(id) | !nzchar(pw)) {
    warning("BacDive login credentials not set completely.\n
             Please run `BacDiveR::prepare_Renviron()`.")
  } else {
    c(id, pw)
  }
}
