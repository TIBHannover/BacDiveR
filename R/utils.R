get_Renviron_path <- function() {
  path <- Sys.getenv("HOME")
  if (nzchar(path))
    path <- normalizePath("~/")
  file.path(path, ".Renviron")
}

.onAttach <- function(libname, pkgname) {

  id_pw <- get_credentials()
}
