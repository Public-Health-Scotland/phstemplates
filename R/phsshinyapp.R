#' phsshinyapp
#' @description Create new shiny app according to the PHS R project structure.
#' This function is meant to be used within RStudio by going to the File menu, then New Project.
#'
#' @param path String: Filepath for the project.
#' @param author String: Name of the main author for the project.
#' @param app_name String: name of application.
#' @param phs_white_logo Logical: Use a white PHS logo.
#' @param git Logical: Initialise the project with Git.
#' @param renv Logical: Initialise the project with package management using renv.
#' @param overwrite Logical: Whether to overwrite directory at existing path when creating directory.
#' @return New project created according to the PHS R project structure.
#' @export
#' @examples
#' \dontrun{
#' phsshinyapp(
#'   path = file.path(getwd(), "testproj"), app_name = "My lovely app",
#'   author = "A Person", n_scripts = 1
#' )
#' }
phsshinyapp <- function(
  path,
  author = get_name(),
  app_name = "WRITE APP NAME HERE",
  phs_white_logo = TRUE,
  git = FALSE,
  renv = FALSE,
  overwrite = FALSE
) {
  # Checking if path already exists
  if (dir.exists(path)) {
    if (overwrite) {
      message("Overwriting existing directory")
    } else {
      overwrite <- rstudioapi::showQuestion(
        title = "Overwrite existing directory?",
        message = "Path already exists. Overwrite existing directory?",
        "Yes",
        "No"
      )
    }
    if (overwrite) {
      # Delete files so they can be overwritten
      deletefiles <- list.files(
        path,
        include.dirs = F,
        full.names = T,
        recursive = T
      )
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
  gitignore <- readLines(system.file(
    package = "phstemplates",
    "text",
    "gitignore.txt"
  ))
  rproj_settings <- readLines(system.file(
    package = "phstemplates",
    "text",
    "rproject_settings.txt"
  ))

  # Getting shiny files from inst/
  readme <- readLines(system.file(
    package = "phstemplates",
    "text",
    "shiny",
    "README.md"
  ))
  readme <- gsub("WRITE APP NAME HERE", app_name, readme)
  setup_code <- readLines(system.file(
    package = "phstemplates",
    "text",
    "shiny",
    "setup.R"
  ))
  css_code <- readLines(system.file(
    package = "phstemplates",
    "text",
    "shiny",
    "shiny_css.css"
  ))
  css_code_phs <- readLines(system.file(
    package = "phstemplates",
    "text",
    "phs_style.css"
  ))
  core_functions <- readLines(system.file(
    package = "phstemplates",
    "text",
    "shiny",
    "core_functions.R"
  ))
  intro_page_code <- readLines(system.file(
    package = "phstemplates",
    "text",
    "shiny",
    "intro_page.R"
  ))
  page_1_code <- readLines(system.file(
    package = "phstemplates",
    "text",
    "shiny",
    "page_1.R"
  ))
  page_1_functions <- readLines(system.file(
    package = "phstemplates",
    "text",
    "shiny",
    "page_1_functions.R"
  ))
  contact_page_code <- readLines(system.file(
    package = "phstemplates",
    "text",
    "shiny",
    "contact_page.R"
  ))
  app_code <- readLines(system.file(
    package = "phstemplates",
    "text",
    "shiny",
    "app.R"
  ))

  # Collect into single text string
  gitignore <- paste(gitignore, collapse = "\n")
  rproj_settings <- paste(rproj_settings, collapse = "\n")
  css_code <- paste(css_code, collapse = "\n")
  css_code_phs <- paste(css_code_phs, collapse = "\n")
  css_code <- paste(css_code_phs, css_code, sep = "\n\n\n")
  readme <- paste(readme, collapse = "\n")
  setup_code <- paste(setup_code, collapse = "\n")
  core_functions <- paste(core_functions, collapse = "\n")
  intro_page_code <- paste(intro_page_code, collapse = "\n")
  page_1_code <- paste(page_1_code, collapse = "\n")
  page_1_functions <- paste(page_1_functions, collapse = "\n")
  contact_page_code <- paste(contact_page_code, collapse = "\n")
  app_code <- paste(app_code, collapse = "\n")

  # Getting app preamble
  app_preamble <- shiny_app_template(app_name = app_name, author = author)
  app_code <- paste0(app_preamble, app_code, collapse = "\n")

  if (!phs_white_logo) {
    app_code <- gsub("phs-logo-white", "phs-logo", app_code)
    css_code <- gsub(
      "navbar-brand \\{color: var\\(--phs-purple\\); background-color: var\\(--phs-purple\\)\\}",
      "navbar-brand \\{color: var\\(--phs-purple\\); background-color: var\\(--white\\)\\}",
      css_code
    )
  }

  # Write to index file
  if (!renv) {
    writeLines("", con = file.path(path, ".Rprofile"))
  }
  if (git) {
    writeLines(gitignore, con = file.path(path, ".gitignore"))
  }
  writeLines(readme, con = file.path(path, "README.md"))
  writeLines(
    rproj_settings,
    con = file.path(path, paste0(basename(path), ".Rproj"))
  )
  writeLines(app_code, con = file.path(path, "app.R"))
  writeLines(setup_code, con = file.path(path, "setup.R"))

  writeLines("", con = file.path(path, "functions", "intro_page_functions.R"))
  writeLines(
    page_1_functions,
    con = file.path(path, "functions", "page_1_functions.R")
  )
  writeLines(
    core_functions,
    con = file.path(path, "functions", "core_functions.R")
  )

  writeLines(intro_page_code, con = file.path(path, "pages", "intro_page.R"))
  writeLines(page_1_code, con = file.path(path, "pages", "page_1.R"))
  writeLines(
    contact_page_code,
    con = file.path(path, "pages", "contact_page.R")
  )

  writeLines(css_code, con = file.path(path, "www", "styles.css"))

  # Getting images needed for shiny app from inst
  logo <- file.copy(
    from = system.file(package = "phstemplates", "images", "phs-logo.png"),
    to = file.path(path, "www", "phs-logo.png")
  )
  logo_white <- file.copy(
    from = system.file(
      package = "phstemplates",
      "images",
      "phs-logo-white.png"
    ),
    to = file.path(path, "www", "phs-logo-white.png")
  )
  favicon <- file.copy(
    from = system.file(package = "phstemplates", "images", "favicon_phs.ico"),
    to = file.path(path, "www", "favicon_phs.ico")
  )

  if (!logo | !favicon | !logo_white) {
    message(
      "PHS logo and favicon could not be copied. Please obtain these images for them to show in the shiny app."
    )
  }

  if (git) {
    git2r::init(file.path(getwd(), path))
    git2r::commit(message = "Initial commit", all = TRUE, session = TRUE)
  }

  if (renv) {
    if (!"renv" %in% utils::installed.packages()[, 1]) {
      warning(
        "renv is not installed. Now attempting to install...",
        immediate. = TRUE
      )
      utils::install.packages("renv")
    }

    options(renv.consent = TRUE)
    renv::init(project = file.path(getwd(), path))
  }
}
