#' Prepare .Renviron File
#'
#' @return Doesn't return any value, but writes (to and if necessary, creates)
#'   the .Renviron file so users can type in their `BacDive_email` and
#'   `BacDive_password` manually.
#' @export
#'
#' @examples
#' \donttest{
#' prepare_Renviron()
#' }
#' @keywords internal
prepare_Renviron <- function() {
  r_env_file <- construct_Renviron_path()

  if (!file.exists(r_env_file)) {
    file.create(r_env_file)
    Sys.chmod(r_env_file, mode = "0600")
  }

  message <-
    "add your BacDive login credentials.\n# See https://github.com/tibhannover/BacDiveR/\n# for more installation instructions."

  # add credential keys if none exist
  for (type in c("email", "password")) {
    start_of_line <- paste0("BacDive_", type, "=")
    if (!any(grepl(
      paste0("^", start_of_line),
      readLines(r_env_file, warn = FALSE)
    ))) {
      if (identical(type, "email")) {
        write(paste("\n# Please", message),
          file = r_env_file,
          append = TRUE
        )
      }
      write(start_of_line, file = r_env_file, append = TRUE)
    }
  }

  # detect empty credential values/variables & prompt user to fill them
  if (any(grepl(paste0("^", start_of_line, "$"), readLines(r_env_file)))) {
    message(
      r_env_file,
      " prepared. If you don't see it open now, please run: `file.edit(file.path(Sys.getenv('HOME'), '.Renviron'))` and ",
      message
    )
    utils::file.edit(r_env_file)
  }
}
