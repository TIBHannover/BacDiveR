#' Construct Path of User's .Renviron File
#'
#' @return A character vector representing the path to the user's `.Renviron`
#'   file.
#' @keywords internal
construct_Renviron_path <- function()
{
  path <- Sys.getenv("HOME")
  if (nzchar(path))
    path <- normalizePath("~/")
  return(file.path(path, ".Renviron"))
}
