#' phiproject
#' @description Create new projects according to the PHI R project structure
#'
#' @param path Filepath for the project.
#' @param author Name of the main author for the project.
#' @param n_scripts Number of code files to start the project with.
#' @return New project created according to the PHI R project structure.
#' @export
#' @examples
#' phiproject(path = file.path(getwd(), "testproj"), author = "A Person", n_scripts = 1)
phiproject <- function(path, author, n_scripts = 1) {
    if (dir.exists(path)) {
        stop("This directory already exists")
    }

    n_scripts <- as.numeric(n_scripts)
    stopifnot(!is.na(n_scripts) && n_scripts >= 1 && n_scripts <= 10)

    dir.create(path, recursive = TRUE, showWarnings = FALSE)
    dir.create(file.path(path, "code"), showWarnings = FALSE)
    dir.create(file.path(path, "data"), showWarnings = FALSE)
    dir.create(file.path(path, "data", "basefiles"), showWarnings = FALSE)
    dir.create(file.path(path, "data", "output"), showWarnings = FALSE)
    dir.create(file.path(path, "data", "temp"), showWarnings = FALSE)

    author <- paste("#", author)

    gitignore <- c(
        ".Rproj.user",
        ".Rhistory",
        ".RData",
        ".Ruserdata",
        "",
        "# 'data' folder #",
        "data/",
        "",
        "# Common text files that may contain data #",
        "*.[cC][sS][vV]",
        "*.[tT][xX][tT]",
        "",
        "# Excel files #",
        "*.[xX][lL][sS][xXmMtT]?",
        "",
        "# SPSS formats #",
        "*.[sS][aA][vV]",
        "*.[zZ][sS][aA][vV]",
        "",
        "# R data files #",
        "*.[rR][dD][aA][tT][aA]",
        "*.[rR][dD][sS]",
        "",
        "# MacOS folder attributes files #",
        ".DS_Store"
    )

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

    rproj_settings <- c(
        "Version: 1.0",
        "",
        "RestoreWorkspace: No",
        "SaveWorkspace: No",
        "AlwaysSaveHistory: Default",
        "",
        "EnableCodeIndexing: Yes",
        "UseSpacesForTab: Yes",
        "NumSpacesForTab: 2",
        "Encoding: UTF-8",
        "",
        "RnwWeave: Sweave",
        "LaTeX: pdfLaTeX"
    )

    # collect into single text string
    gitignore <- paste(gitignore, collapse = "\n")
    r_code <- paste(r_code, collapse = "\n")
    rproj_settings <- paste(rproj_settings, collapse = "\n")

    # write to index file
    writeLines("", con = file.path(path, ".Rprofile"))
    writeLines(gitignore, con = file.path(path, ".gitignore"))
    writeLines(rproj_settings, con = file.path(path, paste0(basename(path), ".Rproj")))
    writeLines(r_code, con = file.path(path, "code", "code.R"))
    writeLines("", con = file.path(path, "code", "functions.R"))
    writeLines("", con = file.path(path, "code", "packages.R"))

    if (n_scripts > 1) {
        script_name <- paste0("code", 2:n_scripts, ".R")
        lapply(file.path(path, "code", script_name), function(x) writeLines(r_code, x))
    }
}
