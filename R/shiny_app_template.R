shiny_app_template <- function(
  app_name = "WRITE APP NAME HERE",
  author = get_name()
) {
  author <- paste("# Original author(s):", author)
  orig_date <- paste("# Original date:", Sys.Date())

  r_code <- c(
    "##########################################################",
    paste0("# ", app_name),
    author,
    orig_date,
    run_on(),
    "# Description of content",
    "##########################################################",
    "",
    "",
    "# Get packages",
    'source("setup.R")',
    "",
    ""
  )

  r_code <- paste(r_code, collapse = "\n")

  return(r_code)
}
