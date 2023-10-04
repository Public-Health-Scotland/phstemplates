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
add_stylecss <- function(path = rstudioapi::selectDirectory(caption = "Select folder to add style.css")) {
  if (is.null(path)) {
    return(message("style.css file not added."))
  }

  # style.css content to add
  stylecss <- readLines(system.file(package = "phstemplates", "text", "stylecss.txt"))

  # collect into single text string
  stylecss <- paste(stylecss, collapse = "\n")

  # Search for existing stylecss in path
  file_exists <- file.exists(paste0(path, "/style.css"))

  if (file_exists) {
    write_out <- rstudioapi::showQuestion(
      title = "Overwrite?",
      message = "You already have a style.css file. Select OK if you want to overwrite this file?",
    )
  } else {
    write_out <- TRUE
  }

  if (write_out) {
    writeLines(stylecss, con = paste0(path, "/style.css"))
  } else {
    return(message("style.css file not added."))
  }
}
