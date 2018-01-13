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
    stop("BacDive login credentials not set completely. Please run prepare_Renviron().")

  return(c(id, pw))
}
