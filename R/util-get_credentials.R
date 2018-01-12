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
    stop(
      "BacDive login credentials not set completely. Please:
      1. run the following command in the R console: file.edit('~/.Renviron'),
      2. on a new line, add: BacDive_email=,
      3. add the email address directly behind the =,
      4. on another line, add: BacDive_password=,
      5. add your BacDive password directly behind the =.
      6. run the command: readRenviron('~/.Renviron')"
    )

  return(c(id, pw))
}
