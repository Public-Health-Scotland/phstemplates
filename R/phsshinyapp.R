#' phsshinyapp
#' @description Create new shiny app according to the PHS R project structure.
#' This function is meant to be used within RStudio by going to the File menu, then New Project.
#'
#' @param path String: Filepath for the project.
#' @param author String: Name of the main author for the project.
#' @param app_name String: name of application.
#' @param git Logical: Initialise the project with Git.
#' @param renv Logical: Initialise the project with package management using renv.
#' @param overwrite Logical: Whether to overwrite directory at existing path when creating directory.
#' @return New project created according to the PHS R project structure.
#' @export
#' @examples
#' \dontrun{
#' phsshinyapp(path = file.path(getwd(), "testproj"), author = "A Person", n_scripts = 1)
#' }
phsshinyapp <- function(path, author, app_name = "WRITE APP NAME HERE",
                           git = FALSE, renv = FALSE, overwrite = FALSE) {

  # Checking if path already exists
  if (dir.exists(path)) {
    if (overwrite){
      message("Overwriting existing directory")
    } else {
      overwrite <- rstudioapi::showQuestion(title = "Overwrite existing directory?",
                               message = "Path already exists. Overwrite existing directory?",
                               "Yes", "No")
    }
    if (overwrite){
      # Delete files so they can be overwritten
      deletefiles <- list.files(path, include.dirs = F, full.names = T, recursive = T)
      file.remove(deletefiles)
    } else {
      stop("Directory already exists")
    }
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

  r_code <- shiny_app_template(app_name = app_name, author = author)

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
    'source("functions/core_functions.R")',
    '',
    '# LOAD IN DATA HERE',
    '',
    ''
  )

  core_functions_code <- c(
    '####################### Core functions #######################',
    '',
    '# Add n linebreaks',
    'linebreaks <- function(n){HTML(strrep(br(), n))}',
    '',
    '# Remove warnings from icons ----',
    'icon_no_warning_fn = function(icon_name) {',
    '  icon(icon_name, verify_fa=FALSE)',
    '}'
  )

  intro_page_code <- c(
    '####################### Intro Page #######################',
    '',
    'output$intro_page_ui <-  renderUI({',
    '',
    '  div(',
    '	     fluidRow(',
    '            h3("This is a header"),',
    '	           p("This is some text"), ',
    '	           p(strong("This is some bold text"))',
    '	      ) #fluidrow',
    '   ) # div',
    '}) # renderUI'
  )

  page_1_code <- c(
    '####################### Page 1 #######################',
    '',
    'output$page_1_ui <-  renderUI({',
    '',
    '  div(',
    '	     fluidRow(',
    '            h3("This is a header"),',
    '	           p("This is some text"), ',
    '	           p(strong("This is some bold text"))',
    '	      ) #fluidrow',
    '   ) # div',
    '}) # renderUI'
  )

  # Read css

  css_code <- c(
     "/* CSS styles used in the shiny app */",
     "  :root{",
     "    --white: #ffffff;",
     "      --black: #000000;",
     "      --phs-purple: #3F3685;",
     "      --phs-blue: #0078D4;",
     "      --phs-green: #83BB26;",
     "      --phs-graphite: #948DA3;",
     "      --phs-magenta: #9B4393;",
     "      --phs-teal-30: #BCD9DA;",
     "      --phs-teal-50: #8FBFC2;",
     "      --phs-teal-80: #4B999D;",
     "      --phs-purple-80: #655E9D;",
     "      --phs-purple-30: #C5C3DA;",
     "      --phs-magenta-30: #E1C7DF;",
     "      --phs-liberty-10: #F0EFF3;",
     "      --light-grey: #ddd;",
     "  }",
     "",
     "/* Setting header colour */",
     "  h1, .h1, h2, .h2, h3, .h3, h4, .h4, h5, .h5, h6, .h6 {",
     "    color: var(--phs-purple);",
     "  }",
     "/* Body styles */",
     "  body {",
     "    font-family: Arial;",
     "    font-size: 16px;",
     "    line-height: 1.5;",
     "    color: var(--black);",
     "    background-color: var(--white);",
     "  }",
     "",
     "/* Style sidebars/well panels */",
     "  .well {background-color:var(--white); border: 0 solid var(--phs-blue);",
     "    padding: 5px; box-shadow: none; }",
     "",
     "/* Navigation bar following PHS colour scheme */",
     "  .navbar-default {color: var(--white); background-color: var(--phs-purple); }",
     ".navbar-default .navbar-brand, .navbar-default:hover .navbar-brand:hover, .navbar-brand {color: var(--phs-purple); background-color: var(--white)}",
     ".navbar-default .navbar-nav > li > a {color: var(--white);}",
     ".navbar-default .navbar-nav > .active > a, .navbar-default .navbar-nav > .active > a:focus, .navbar-default .navbar-nav > .active > a:hover {",
     "  color: var(--white);",
     "  background-color: var(--phs-purple-80);",
     "}",
     ".navbar-default .navbar-nav > li > a:hover, .navbar-default .navbar-nav > li > a:focus {",
     "  color: var(--white);     background-color: var(--phs-purple-80);}",
     "",
     "/* Style hyperlinks */",
     "  .externallink {color: var(--phs-purple); font-weight: bold;}",
     ".externallink:hover {color: var(--phs-teal-50);}",
     "",
     "/* Border tables - th, td puts within the table as well */",
     "  .border-table{border:1px solid var(--phs-purple);}",
     "th, td {",
     "  border: 1px solid var(--phs-purple-30);",
     "  padding-right: 1px;",
     "}",
     ".container-fluid {",
     "  padding-right: 15px;",
     "  padding-left: 20px;",
     "  margin-right: 15px;",
     "  margin-left: 15px;",
     "}",
     "",
     "/* Button styles */",
     "  .btn {",
     "    background-color: var(--phs-teal-50);",
     "    color: black; background-image:none;",
     "    border: 2px solid var(--phs-purple);",
     "    border-radius: 10px;",
     "  }",
     ".btn:hover{background-color:#9F9BC2; border: 2px solid var(--phs-purple-30);",
     "    box-shadow: 0 12px 16px 0 rgba(0,0,0,0.24), 0 8px 20px 0 rgba(0,0,0,0.19);",
     "}",
     ".btn:focus{background-color:#9F9BC2; border: 2px solid var(--phs-purple-30);",
   "    box-shadow: 0 12px 16px 0 rgba(0,0,0,0.24), 0 8px 20px 0 rgba(0,0,0,0.19);}",
     ".btn:active{background-color:#9F9BC2; border: 2px solid var(--phs-purple-30);",
     "    box-shadow: 0 12px 16px 0 rgba(0,0,0,0.24), 0 8px 20px 0 rgba(0,0,0,0.19);}",
     ".btn:checked{background-color:#9F9BC2; border: 2px solid var(--phs-purple-30);",
     "    box-shadow: 0 12px 16px 0 rgba(0,0,0,0.24), 0 8px 20px 0 rgba(0,0,0,0.19);}",
     "",
     "/* Title of selectize input boxes*/",
     "  label {",
     "    display: inline-block;",
     "    max-width: 100%;",
     "    margin-bottom: 5px;",
     "    font-weight: bold;",
     "    color: var(--phs-purple);",
     "  }",
     "/* Links */",
     "  a {",
     "    color: var(--phs-purple);",
     "    text-decoration: none;",
     "  }",
     "",
     "/* Dropdown menu */",
     "  .dropdown-menu>.active>a, .dropdown-menu>.active>a:focus, .dropdown-menu>.active>a:hover {",
     "    color: var(--white);",
     "    text-decoration: none;",
     "    background-color: var(--phs-teal-50);",
     "    outline: 0;",
     "  }",
     "",
     "/* Data table page selectors */",
     "",
     "  .pagination > li > a",
     "{",
     "  background-color: var(--phs-liberty-10);",
     "  color: var(--phs-purple);",
     "  transition: background-color .3s;",
     "}",
     "",
     ".pagination > li > a:focus,",
     ".pagination > li > a:hover,",
     ".pagination > li > span:focus,",
     ".pagination > li > span:hover",
     "{",
     "  color:var(--phs-purple);",
     "  background-color: var(--phs-teal-50);",
     "  border-color: var(--phs-teal-80);",
     "  border-radius: 5px;",
     "}",
     "",
     ".pagination > .active > a",
     "{",
     "  color: var(--phs-purple);",
     "  background-color: var(--phs-teal-50) !Important;",
     "  border: solid 1px var(--phs-teal-50) !Important;",
     "}",
     "",
     ".pagination > .active > a:hover",
     "{",
     "  background-color: var(--phs-teal-50) !Important;",
     "  border: solid 1px var(--phs-teal-50);",
     "}",
     "",
     "/* data table */",
     "",
     "  .table > .tbody > tr.active th,",
     ".table > .tbody > tr.active td{",
     "  background-color: var(--phs-purple);",
     "  color: var(--white);",
     "}",
     "",
     "/*"
  )

  # collect into single text string
  gitignore <- paste(gitignore, collapse = "\n")
  rproj_settings <- paste(rproj_settings, collapse = "\n")
  r_code <- paste(r_code, collapse = "\n")
  setup_code <- paste(setup_code, collapse="\n")
  core_functions_code <- paste(core_functions_code, collapse="\n")

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
  writeLines(core_functions_code, con = file.path(path, "functions", "core_functions.R"))

  writeLines(intro_page_code, con = file.path(path, "pages", "intro_page.R"))
  writeLines(page_1_code, con = file.path(path, "pages", "page_1.R"))

  writeLines(css_code, con = file.path(path, "www", "styles.css"))

  # Getting images needed for shiny app by downloading from Github
  # TODO: change branch from shiny_template to master just before merge
  download_logo <- utils::download.file(
    url="https://raw.githubusercontent.com/Public-Health-Scotland/phstemplates/shiny_template/images/phs-logo.png",
    destfile=file.path(path, "www", "phs-logo.png"),
    method="auto")
  download_favicon <- utils::download.file(
    url="https://raw.githubusercontent.com/Public-Health-Scotland/phstemplates/shiny_template/images/favicon_phs.ico",
    destfile=file.path(path, "www", "favicon_phs.ico"),
    method="auto")

  if (download_logo | download_favicon){
    message("PHS logo and favicon download failed. Please obtain these images \
            for them to show in the shiny app")
  }


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
