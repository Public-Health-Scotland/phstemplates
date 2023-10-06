#' add_stylecss
#' @description Add PHS template phs_style.css file to chosen directory.
#'
#' @param path String: path to add phs_style.css file. If left blank, RStudio will prompt the user.
#' @param auto_open Logical: Automatically open the phs_style.css after it is compiled?
#'
#' @return NULL - Adds phs_style.css file to the directory.
#' @export
#' @examples
#' \dontrun{
#' add_stylecss()
#' }
add_stylecss <- function(path = rstudioapi::selectDirectory(caption = "Select folder to add phs_style.css"),
                         auto_open = TRUE) {
  if (is.null(path)) {
    message("phs_style.css file not added.")
    return(invisible(NULL))
  }

  # phs_style.css content to add
  stylecss <- readLines(system.file(package = "phstemplates", "text", "phs_style.css"))

  # collect into single text string
  stylecss <- paste(stylecss, collapse = "\n")

  # Search for existing file in path
  if (file.exists(file.path(path, "phs_style.css"))) {
    overwrite <- rstudioapi::showQuestion(
      title = "Overwrite?",
      message = "A phs_style.css file already exists. Select OK to overwrite this file."
    )

    if (!overwrite) {
      message("phs_style.css has not been overwritten.")
      return(invisible(NULL))
    }
  }

  writeLines(stylecss, con = file.path(path, "phs_style.css"))
  message(paste("phs_style.css has been written to", path))

  if (auto_open) {
    rstudioapi::documentOpen(file.path(path, "phs_style.css"))
  }

  return(invisible(NULL))
}
