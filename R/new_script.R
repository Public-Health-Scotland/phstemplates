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
    remove_start <- gregexpr("# Original", r_code)[[1]][1] - 1
    remove_end <- gregexpr("Latest update description \\(delete if using version control\\)\n", r_code)[[1]]
    remove_end <- as.integer(remove_end + attr(remove_end, "match.length"))

    r_code_part1 <- substr(r_code, 1, remove_start)
    r_code_part2 <- substr(r_code, remove_end, nchar(r_code))

    r_code <- paste0(r_code_part1, r_code_part2, collapse = "")
  }

  if (!is.null(author) & rstudioapi::getVersion() >= 1.2) {
    invisible(rstudioapi::documentNew(r_code, type = "r"))
  } else if (!is.null(author) & rstudioapi::getVersion() < 1.2) {
    filename <- rstudioapi::showPrompt(title = "Filename",
                                       message = "Filename for new script\nYou can choose a folder to store this in after this",
                                       default = "code.R")
    folder <- rstudioapi::selectDirectory()

    writeLines(r_code, con = file.path(folder, filename))
    rstudioapi::navigateToFile(file.path(folder, filename))
  }
}
