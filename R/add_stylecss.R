#' add_stylecss
#' @description Add PHS template phs_style.css file to chosen directory.
#'
#' @param path String: path to add phs_style.css file. If left blank, RStudio will prompt the user.
#' @param shinycss Logical: Whether to append shiny CSS code to the file (TRUE) or not (FALSE). If left blank, RStudio will prompt the user.
#'
#' @return NULL - Adds phs_style.css file to the directory.
#' @export
#' @examples
#' \dontrun{
#' add_stylecss()
#' }
add_stylecss <- function(path = rstudioapi::selectDirectory(caption = "Select folder to add phs_style.css"),
                         shinycss = FALSE) {

if (missing(shinycss) && interactive()) {
shinycss <- rstudioapi::showQuestion(
                           title = "Shiny CSS",
                           message = "Do you want to append Shiny CSS code to the file?",
                           ok = "Yes", 
                           cancel = "No"
                         )
                         }                                    
  if (is.null(path)) {
    message("phs_style.css file not added.")
    return(invisible(NULL))
  }

  # phs_style.css content to add
  stylecss <- readLines(system.file(package = "phstemplates", "text", "phs_style.css"))

  # collect into single text string
  stylecss <- paste(stylecss, collapse = "\n")

  # Append shiny CSS if required
  if (shinycss) {
    shinycss <- readLines(system.file(package = "phstemplates", "text", "shiny", "shiny_css.css"))
    shinycss <- paste(shinycss, collapse = "\n")
    stylecss <- paste(stylecss, shinycss, sep = "\n\n\n")
  }

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
  rstudioapi::documentOpen(file.path(path, "phs_style.css"))
  return(invisible(NULL))
}
