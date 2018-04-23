#' Construct Path of User's .Renviron File
#'
#' @return A character vector representing the path to the user's `.Renviron`
#'   file.
construct_Renviron_path <- function() {
  path <- Sys.getenv("HOME")
  if (nzchar(path))
    path <- normalizePath("~/")
  file.path(path, ".Renviron")
}


.onAttach <- function(libname, pkgname) {
  get_credentials()
  prepare_Renviron()
}
