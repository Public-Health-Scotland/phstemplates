#' new_script
#' @description Create new R script according to the PHI R project template. This function is meant to be used within RStudio by clicking on the Addins dropdown menu.
#'
#' @param author Name of the main author of the script.
#' @return New R script created according to the PHI R project structure.
#' @export
#' @examples
#' \dontrun{
#' new_script(author = "A Person")
#' }
new_script <- function(author = rstudioapi::showPrompt(title = "Author",
                                                       message = "Name of Author",
                                                       default = "Original author(s)")) {

  if (!is.null(author) & rstudioapi::getVersion() >= 1.2) {
    rstudioapi::documentNew(script_template(author = author), type = "r")
  } else if (!is.null(author) & rstudioapi::getVersion() < 1.2) {
    filename <- rstudioapi::showPrompt(title = "Filename",
                                       message = "Filename for new script\nYou can choose a folder to store this in after this",
                                       default = "code.R")
    folder <- rstudioapi::selectDirectory()

    writeLines(script_template(author = author), con = file.path(folder, filename))
    rstudioapi::navigateToFile(file.path(folder, filename))
  }
}
