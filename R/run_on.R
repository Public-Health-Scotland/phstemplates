run_on <- function(linebreak = FALSE) {
  out <- paste0(
    "# Written/run on RStudio ",
    rstudioapi::versionInfo()$mode, " ",
    rstudioapi::versionInfo()$version, " and R ",
    version$major, ".", version$minor
  )

  ifelse(linebreak, paste0(out, "\n"), out)
}
