get_Renviron_path <- function() {
  path <- Sys.getenv("HOME")
  if (nzchar(path))
    path <- normalizePath("~/")
  file.path(path, ".Renviron")
}



prepare_Renviron <- function() {
  r_env_file <- get_Renviron_path()

  if (!file.exists(r_env_file))
    file.create(r_env_file)

  message <- "add your BacDive login credentials.\n# See https://github.com/katrinleinweber/BacDiveR/\n# for more installation instructions."

  # add credential keys if none exist
  for (type in c("email", "password")) {
    start_of_line <- paste0("BacDive_", type, "=")
    if (!any(grepl(
      paste0("^", start_of_line),
      readLines(r_env_file, warn = FALSE)
    ))) {
      if (type == "email")
        write(paste("\n# Please", message), file = r_env_file, append = TRUE)
      write(start_of_line, file = r_env_file, append = TRUE)
    }
  }

  # prompt user to fill empty credential values/variables
  if (any(grepl(paste0("^", start_of_line, "$"), readLines(r_env_file)))) {
    message(paste(r_env_file, "prepared. If you don't see it open now, please run `file.edit(r_env_file)` and", message))
    utils::file.edit(r_env_file)
  }
}

.onAttach <- function(libname, pkgname) {
  get_credentials()
  prepare_Renviron()
}
