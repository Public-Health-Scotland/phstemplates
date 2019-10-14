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

  if (!is.null(author)) {
    rstudioapi::documentNew(script_template(author = author), type = "r")
  }
}
