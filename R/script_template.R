script_template <- function(author = "Original author(s)") {
  author <- paste("#", author)

  r_code <- c(
    "##########################################################",
    "# Name of script",
    "# Publication (delete if not applicable)",
    author,
    "# Original date (delete if using version control)",
    "# Latest update author (delete if using version control)",
    "# Latest update date (delete if using version control)",
    "# Latest update description (delete if using version control)",
    "# Type of script (e.g. extraction, preparation, modelling)",
    "# Written/run on (e.g. R Studio Server or Desktop)",
    "# Version of R that the script was most recently run on",
    "# Description of content",
    "# Approximate run time",
    "##########################################################",
    "",
    "",
    "### 1 - Housekeeping ----",
    "# This section should be the only section of the script which requires manual changes ",
    "# for future updates and includes:",
    "#   loading packages",
    "source(\"code/packages.R\") # Remove this line if loading packages here",
    "#   setting filepaths and extract dates",
    "#   defining functions",
    "source(\"code/functions.R\") # Remove this line if defining functions here",
    "#   setting plot parameter",
    "#   specifying codes (e.g. ICD-10 codes)",
    "",
    "",
    "### 2 Section Heading ----",
    "",
    "",
    "### 3 Section Heading ----",
    "",
    "",
    "### END OF SCRIPT ###"
  )
  r_code <- paste(r_code, collapse = "\n")

  return(r_code)
}
