#' phsproject
#' @description Create new projects according to the PHS R project structure. This function is meant to be used within RStudio by going to the File menu, then New Project.
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
#' phsproject(path = file.path(getwd(), "testproj"), author = "A Person", n_scripts = 1)
#' }
phsproject <- function(path, author, n_scripts = 1, git = FALSE, renv = FALSE) {
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

    r_code <- script_template(author = author)

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
    rproj_settings <- paste(rproj_settings, collapse = "\n")

    # write to index file
    if (!renv) {
        writeLines("", con = file.path(path, ".Rprofile"))
    }
    
    writeLines(rproj_settings, con = file.path(path, paste0(basename(path), ".Rproj")))
    writeLines(r_code, con = file.path(path, "code", "code.R"))
    writeLines("", con = file.path(path, "code", "functions.R"))
    writeLines("", con = file.path(path, "code", "packages.R"))

    if (n_scripts > 1) {
        script_name <- paste0("code", 2:n_scripts, ".R")
        lapply(file.path(path, "code", script_name), function(x) writeLines(r_code, x))
    }

    if (git) {
        writeLines(gitignore, con = file.path(path, ".gitignore"))
        
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

        if (Sys.info()[["sysname"]] != "Windows" && file.access("/conf/linkage/output/renv_cache", mode = 2) == 0) {
            renv_rprofile <- "Sys.setenv(RENV_PATHS_ROOT = \"/conf/linkage/output/renv_cache\")"
        } else if (Sys.info()[["sysname"]] == "Windows" && file.access("//stats/cl-out/renv_cache/Windows_test", mode = 2) == 0) {
            renv_rprofile <- "Sys.setenv(RENV_PATHS_ROOT = \"//stats/cl-out/renv_cache/Windows_test\")"
        } else {
            renv_rprofile <- ""
        }
        writeLines(renv_rprofile, con = file.path(path, ".Rprofile"))

        renv::init(project = file.path(getwd(), path))
    }
}
