#' What system is the code being run on
#'
#' Collates RStudio and R version information into
#' a character vector which can be used elsewhere.
#'
#' @param linebreak (Default: FALSE) - Should a
#' linebreak be appended to the 'run on' text?
#'
#' @noRd
run_on <- function(linebreak = FALSE) {
  out <- paste0(
    "# Written/run on RStudio ",
    rstudioapi::versionInfo()$mode, " ",
    rstudioapi::versionInfo()$version, " and R ",
    version$major, ".", version$minor
  )

  ifelse(linebreak, paste0(out, "\n"), out)
}
