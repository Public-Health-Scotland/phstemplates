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
phsshinyapp <- function(path, author = Sys.info()[['user']], app_name = "WRITE APP NAME HERE",
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


  # Getting text from inst/
  gitignore <- readLines("inst/text/.gitignore")
  css_code <- readLines("inst/text/shiny_css.css")

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

  # Collect into single text string
  gitignore <- paste(gitignore, collapse = "\n")
  rproj_settings <- paste(rproj_settings, collapse = "\n")
  css_code <- paste(css_code, collapse="\n")

  # Getting shiny app files from shiny_app_template function
  readme <- shiny_app_template(file_to_get = "README.md")
  setup_code <- shiny_app_template(file_to_get = "setup.R")
  core_functions_code <- shiny_app_template(file_to_get = "core_functions.R")
  intro_page_code <- shiny_app_template(file_to_get = "intro.R")
  page_1_code <- shiny_app_template(file_to_get = "page_1.R")
  r_code <- shiny_app_template(file_to_get = "app.R", app_name = app_name, author = author)


  # Write to index file
  if (!renv) {
    writeLines("", con = file.path(path, ".Rprofile"))
  }
  if (git){
    writeLines(gitignore, con = file.path(path, ".gitignore"))
  }
  writeLines(readme, con = file.path(path, "README.md"))
  writeLines(rproj_settings, con = file.path(path, paste0(basename(path), ".Rproj")))
  writeLines(r_code, con = file.path(path, "app.R"))
  writeLines(setup_code, con = file.path(path, "setup.R"))

  writeLines("", con = file.path(path, "functions", "intro_page_functions.R"))
  writeLines("", con = file.path(path, "functions", "page_1_functions.R"))
  writeLines(core_functions_code, con = file.path(path, "functions", "core_functions.R"))

  writeLines(intro_page_code, con = file.path(path, "pages", "intro_page.R"))
  writeLines(page_1_code, con = file.path(path, "pages", "page_1.R"))

  writeLines(css_code, con = file.path(path, "www", "styles.css"))

  # Getting images needed for shiny app from inst
  # TODO: change branch from shiny_template to master just before merge
  logo <- file.copy(
    from = "/inst/images/phs-logo.png",
    to = file.path(path, "www", "phs-logo.png"))
  favicon <- file.copy(
    from = "/inst/images/favicon_phs.ico",
    to = file.path(path, "www", "favicon_phs.ico"))


  if (!logo | !favicon){
    message("PHS logo and favicon could not be copied. Please obtain these images \
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
