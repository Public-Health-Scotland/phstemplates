#' create_phs_html
#' @description Creates template `.qmd` file for a html report with PHS formatting.
#'
#' @param file_name Character string of name given to output `.qmd` file.
#'
#' @return Quarto document for html with PHS formatting.
#' @export
#' @examples
#' \dontrun{
#' create_phs_html()
#' }

create_phs_html <- function(file_name = NULL) {
  if (is.null(file_name)) {
    stop("You must provide a valid file_name")
  }

  # set extension name
  ext_name = "phs-html-quarto"

  # check for available extensions (future proofing for multiple templates)
  stopifnot(ext_name %in% c("phs-html-quarto"))

  # check for existing _extensions directory
  if (!file.exists("_extensions")) {
    dir.create("_extensions")
  }
  message("Created '_extensions' folder")

  # create folder
  if (!file.exists(file.path("_extensions", ext_name))) {
    dir.create(file.path("_extensions", ext_name))
  }

  # copy template from internals
  file.copy(
    from = system.file(
      file.path("extdata", "_extensions", ext_name),
      package = "phstemplates"
    ),
    to = "_extensions",
    overwrite = TRUE,
    recursive = TRUE,
    copy.mode = TRUE
  )

  # copy logo .png from internals
  file.copy(
    from = system.file(
      file.path("images", "phs-logo.png"),
      package = "phstemplates"
    ),
    to = file.path("_extensions", ext_name),
    overwrite = TRUE,
    recursive = TRUE,
    copy.mode = TRUE
  )

  # add phs .css file
  phstemplates::add_stylecss(
    path = file.path("_extensions", ext_name),
    shinycss = FALSE,
    auto_open = FALSE
  )

  # logic check to make sure extension files were moved
  n_files <- length(dir(file.path("_extensions", ext_name)))

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
    file.path(
      "_extensions",
      "phs-html-quarto",
      "phs-html-quarto-report-template.qmd"
    ),
    paste0(file_name, ".qmd", collapse = "")
  )

  # open the new file in the editor
  utils::file.edit(paste0(file_name, ".qmd", collapse = ""))
}
