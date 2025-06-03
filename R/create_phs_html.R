#' create_phs_html
#' @description Creates template `.qmd` file for a html report with PHS formatting.
#'
#' @param file_name Character string of name given to output `.qmd` file.
#' @param ext_name Character string of extension folder name (default = "phs-html-quarto")
#'
#' @return Quarto document for html with PHS formatting.
#' @export
#' @examples
#' \dontrun{
#' create_phs_html()
#' }

create_phs_html <- function(file_name = NULL, ext_name = "phs-html-quarto") {
  if (is.null(file_name)) {
    stop("You must provide a valid file_name")
  }

  # check for available extensions
  stopifnot("Extension not in package" = ext_name %in% c("phs-html-quarto"))

  # check for existing _extensions directory
  if (!file.exists("_extensions")) dir.create("_extensions")
  message("Created '_extensions' folder")

  # create folder
  if (!file.exists(paste0("_extensions/", ext_name)))
    dir.create(paste0("_extensions/", ext_name))

  # copy from internals
  file.copy(
    from = system.file(
      paste0("extdata/_extensions/", ext_name),
      package = "phstemplates"
    ),
    to = paste0("_extensions/"),
    overwrite = TRUE,
    recursive = TRUE,
    copy.mode = TRUE
  )

  # logic check to make sure extension files were moved
  n_files <- length(dir(paste0("_extensions/", ext_name)))

  if (n_files >= 2) {
    message(paste(
      ext_name,
      "was installed to _extensions folder in current working directory."
    ))
  } else {
    message("Extension appears not to have been created")
  }

  # create new qmd report based on skeleton
  file.copy(
    "_extensions/phs-html-quarto/phs-html-quarto-report-template.qmd",
    paste0(file_name, ".qmd", collapse = "")
  )

  # open the new file in the editor
  file.edit(paste0(file_name, ".qmd", collapse = ""))
}
