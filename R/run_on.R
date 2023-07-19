run_on <- function() {
  paste0(
    "# Written/run on RStudio ",
    rstudioapi::versionInfo()$mode, " ",
    rstudioapi::versionInfo()$version, " and R ",
    version$major, ".", version$minor
  )
}
