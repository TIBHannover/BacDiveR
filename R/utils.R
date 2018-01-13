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

  for (type in c("email", "password")) {
    start_of_line <- paste0("BacDive_", type, "=")
    if (!any(grepl(
      paste0("^", start_of_line),
      readLines(r_env_file, warn = FALSE)
    ))) {
      if (type == "email")
        write("\n", file = r_env_file, append = TRUE)
      write(start_of_line, file = r_env_file, append = TRUE)
    }
  }

  if (any(grepl(paste0("^", start_of_line, "$"), readLines(r_env_file))))
    message(
      "~/.Renviron file prepared. Now please open the ReadMe -- https://github.com/katrinleinweber/BacDiveR/ -- and follow the installation instructions."
    )
}

.onAttach <- function(libname, pkgname) {
  id_pw <- get_credentials()
  id <- id_pw[1]
  pw <- id_pw[2]
  prepare_Renviron()
}
