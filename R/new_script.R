#' new_script
#' @description Create new R script according to the PHS template. This function is meant to be used within RStudio by clicking on the Addins dropdown menu.
#'
#' @return New R script created according to the PHS R project structure.
#' @export
#' @examples
#' \dontrun{
#' new_script()
#' }
new_script <- function() {

  author = rstudioapi::showPrompt(title = "Author",
                                  message = "Name of Author",
                                  default = Sys.info()[["user"]])

  git <- rstudioapi::showQuestion(title = "Git",
                                 message = "Are you version controlling using git?",
                                 "Yes", "No")

  r_code <- script_template(author = author)

  if (git) {
    lines_to_remove <- paste("# Original date \\(delete if using version control\\)",
                             "# Latest update author \\(delete if using version control\\)",
                             "# Latest update date \\(delete if using version control\\)",
                             "# Latest update description \\(delete if using version control\\)\n",
                             sep = "\n")
    r_code <- gsub(lines_to_remove, "", r_code)
  }

  if (!is.null(author) & rstudioapi::getVersion() >= 1.2) {
    rstudioapi::documentNew(r_code, type = "r")
  } else if (!is.null(author) & rstudioapi::getVersion() < 1.2) {
    filename <- rstudioapi::showPrompt(title = "Filename",
                                       message = "Filename for new script\nYou can choose a folder to store this in after this",
                                       default = "code.R")
    folder <- rstudioapi::selectDirectory()

    writeLines(r_code, con = file.path(folder, filename))
    rstudioapi::navigateToFile(file.path(folder, filename))
  }
}
