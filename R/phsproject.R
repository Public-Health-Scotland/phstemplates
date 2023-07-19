#' phsproject
#' @description Create new projects according to the PHS R project structure. This function is meant to be used within RStudio by going to the File menu, then New Project.
#'
#' @param path Filepath for the project.
#' @param author Name of the main author for the project.
#' @param n_scripts Number of code files to start the project with.
#' @param git Initialise the project with Git.
#' @param renv Initialise the project with package management using renv.
#' @param overwrite Logical: Whether to overwrite directory at existing path when creating directory.
#' @return New project created according to the PHS R project structure.
#' @export
#' @examples
#' \dontrun{
#' phsproject(path = file.path(getwd(), "testproj"), author = "A Person", n_scripts = 1)
#' }
phsproject <- function(path, author, n_scripts = 1, git = FALSE, renv = FALSE, overwrite = FALSE) {
  # Checking if path already exists
  if (dir.exists(path)) {
    if (overwrite) {
      message("Overwriting existing directory")
    } else {
      overwrite <- rstudioapi::showQuestion(
        title = "Overwrite existing directory?",
        message = "Path already exists. Overwrite existing directory?",
        "Yes", "No"
      )
    }
    if (overwrite) {
      # Delete files so they can be overwritten
      deletefiles <- list.files(path, include.dirs = F, full.names = T, recursive = T)
      file.remove(deletefiles)
    } else {
      stop("Directory already exists")
    }
  }

  n_scripts <- as.numeric(n_scripts)
  stopifnot(!is.na(n_scripts) && n_scripts >= 1 && n_scripts <= 10)

  dir.create(path, recursive = TRUE, showWarnings = FALSE)
  dir.create(file.path(path, "code"), showWarnings = FALSE)
  dir.create(file.path(path, "data"), showWarnings = FALSE)
  dir.create(file.path(path, "data", "basefiles"), showWarnings = FALSE)
  dir.create(file.path(path, "data", "output"), showWarnings = FALSE)
  dir.create(file.path(path, "data", "temp"), showWarnings = FALSE)

  gitignore <- readLines(system.file(package = "phstemplates", "text", "gitignore.txt"))

  r_code <- script_template(author = author)

  if (git) {
    remove_start <- gregexpr("# Latest", r_code)[[1]][1] - 1
    remove_end <- gregexpr("Latest update description \\(delete if using version control\\)\n", r_code)[[1]]
    remove_end <- as.integer(remove_end + attr(remove_end, "match.length"))

    r_code_part1 <- substr(r_code, 1, remove_start)
    r_code_part2 <- substr(r_code, remove_end, nchar(r_code))

    r_code <- paste0(r_code_part1, r_code_part2, collapse = "")
  }

  rproj_settings <- readLines(system.file(package = "phstemplates", "text", "rproject_settings.txt"))

  # collect into single text string
  gitignore <- paste(gitignore, collapse = "\n")
  rproj_settings <- paste(rproj_settings, collapse = "\n")

  # write to index file
  if (!renv) {
    writeLines("", con = file.path(path, ".Rprofile"))
  }
  writeLines(gitignore, con = file.path(path, ".gitignore"))
  writeLines(rproj_settings, con = file.path(path, paste0(basename(path), ".Rproj")))
  writeLines(r_code, con = file.path(path, "code", "code.R"))
  writeLines("", con = file.path(path, "code", "functions.R"))
  writeLines("", con = file.path(path, "code", "packages.R"))

  if (n_scripts > 1) {
    script_name <- paste0("code", 2:n_scripts, ".R")
    lapply(file.path(path, "code", script_name), function(x) writeLines(r_code, x))
  }

  if (git) {
    git2r::init(file.path(getwd(), path))
  }

  if (renv) {
    if (!"renv" %in% utils::installed.packages()[, 1]) {
      rlang::check_installed(pkg = "renv")
    }

    options(renv.consent = TRUE)
    renv::init(project = file.path(getwd(), path))
  }
}
