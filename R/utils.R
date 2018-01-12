get_Renviron_path <- function() {
  path <- Sys.getenv("HOME")
  if (nzchar(path))
    path <- normalizePath("~/")
  file.path(path, ".Renviron")
}



save_credential <- function(type, credential, overwrite_existing = FALSE) {

  r_env_file <- get_Renviron_path()

  if (file.exists(r_env_file)) {
    # Check if credential  has been set before
    r_env_lines <- readLines(r_env_file)
    if (any(grepl(paste0("^BacDive_", type), r_env_lines))) {
      if (!overwrite_existing) {
        stop(
          paste0(
            "There is an existing '",
            type,
            "' environment variable.
            Use 'overwrite_existing = TRUE' if you wish to overwrite it."
          )
        )
      }

      r_env_lines[grepl(paste0("^BacDive_", type), r_env_lines)] <-
        paste0("BacDive_", type, "=", credential)
      writeLines(r_env_lines, r_env_file)
      Sys.setenv(type = credential)
      return(message(sprintf("Updated %s.", type)))
    }
  } else {
    # Create .Renviron if it doesn't already exist
    file.create(r_env_file)
  }

  write(paste0("BacDive_", type, "=", credential), r_env_file, append = TRUE)
  Sys.setenv(type = credential)
  message(sprintf("Saved BacDive_%s.", type))
}

.onAttach <- function(libname, pkgname) {

  id_pw <- get_credentials()
}
