#' shiny_template
#' @description Create new shiny app according to the PHS R project structure.
#' This function is meant to be used within RStudio by going to the File menu, then New Project.
#'
#' @param path Filepath for the project.
#' @param author Name of the main author for the project.
#' @param n_scripts Number of code files to start the project with.
#' @param git Initialise the project with Git.
#' @param renv Initialise the project with package management using renv.
#' @return New project created according to the PHS R project structure.
#' @export
#' @examples
#' \dontrun{
#' shiny_template(path = file.path(getwd(), "testproj"), author = "A Person", n_scripts = 1)
#' }
shiny_template <- function(path, author, app_name = "WRITE APP NAME HERE",
                           git = FALSE, renv = FALSE) {
  if (dir.exists(path)) {
    stop("This directory already exists")
  }

  # Making directory structure
  dir.create(path, recursive = TRUE, showWarnings = FALSE)
  dir.create(file.path(path, "data"), showWarnings = FALSE)
  dir.create(file.path(path, "pages"), showWarnings = FALSE)
  dir.create(file.path(path, "functions"), showWarnings = FALSE)
  dir.create(file.path(path, "www"), showWarnings = FALSE)


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
    "*.[xX][lL][sS]*",
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

  r_code <- shiny_template(app_name = app_name, author = author)

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

  setup_code <- c(
    '####################### Setup #######################',
    '',
    '# Shiny packages',
    'library(shiny)',
    'library(shinycssloaders)',
    '',
    '# Data wrangling packages',
    'library(dplyr)',
    'library(magrittr)',
    '',
    '# Plotting packages',
    'library(plotly)',
    '',
    '# PHS styling packages',
    'library(phsstyles)',
    '',
    '# Load core functions',
    'source("functions/core_functions.R)',
    '',
    '# LOAD IN DATA HERE',
    '',
    ''
  )

  # collect into single text string
  gitignore <- paste(gitignore, collapse = "\n")
  rproj_settings <- paste(rproj_settings, collapse = "\n")
  r_code <- paste(r_code, collapse = "\n")
  setup_code <- paste(setup_code, collapse="\n")

  # write to index file
  if (!renv) {
    writeLines("", con = file.path(path, ".Rprofile"))
  }
  if (git){
    writeLines(gitignore, con = file.path(path, ".gitignore"))
  }
  writeLines(rproj_settings, con = file.path(path, paste0(basename(path), ".Rproj")))
  writeLines(r_code, con = file.path(path, "app.R"))
  writeLines(setup_code, con = file.path(path, "setup.R"))

  writeLines("", con = file.path(path, "functions", "intro_page_functions.R"))
  writeLines("", con = file.path(path, "functions", "page_1_functions.R"))
  writeLines("", con = file.path(path, "functions", "core_functions.R")) #

  writeLines("", con = file.path(path, "pages", "intro_page.R"))
  writeLines("", con = file.path(path, "pages", "page_1.R"))

  writeLines("", con = file.path(path, "www", "styles.css")) #


  if (git) {
    if (Sys.info()[["sysname"]] == "Windows") {
      shell(paste("cd", path, "&&", "git init"))
    } else {
      system(paste("cd", path, "&&", "git init"))
    }
  }

  if (renv) {
    if (!"renv" %in% utils::installed.packages()[, 1]) {
      warning("renv is not installed. Now attempting to install...",
              immediate. = TRUE)
      utils::install.packages("renv")
    }

    options(renv.consent = TRUE)
    renv::init(project = file.path(getwd(), path))
  }
}
