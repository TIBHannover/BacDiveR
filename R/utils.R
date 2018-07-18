.onAttach <- function(libname, pkgname) {
  get_credentials()
  prepare_Renviron()
}
