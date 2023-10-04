#' add_stylecss
#' @description Add PHS template style.css file to chosen directory.
#'
#' @param path String: path to add style.css file. If left blank, RStudio will prompt the user.
#'
#' @return NULL - Adds style.css file to the directory.
#' @export
#' @examples
#' \dontrun{
#' add_stylecss()
#' }
add_stylecss <- function(path = rstudioapi::selectDirectory(caption = "Select folder to add phs_style.css")) {
  if (is.null(path)) {
    message("phs_style.css file not added.")
    return(NULL)
  }

  # style.css content to add
  stylecss <- readLines(system.file(package = "phstemplates", "text", "phs_style.css"))

  # collect into single text string
  stylecss <- paste(stylecss, collapse = "\n")

  # Search for existing stylecss in path
  if (file.exists(file.path(path, "phs_style.css"))) {
    overwrite <- rstudioapi::showQuestion(
      title = "Overwrite?",
      message = "A style.css file already exists. Select OK to overwrite this file."
    )

    if (!overwrite) {
      message("phs_style.css has not been overwritten.")
      return(NULL)
    }
  }

  writeLines(stylecss, con = file.path(path, "phs_style.css"))
  return(NULL)
}
