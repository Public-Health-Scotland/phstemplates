#' update_metadata
#' @description Updates metadata in the PHS R script template for existing script. This function is meant to be used within RStudio by clicking on the Addins dropdown menu.
#'
#' @return Updated metadata in the R script.
#' @export
#' @examples
#' \dontrun{
#' update_metadata()
#' }
update_metadata <- function() {
  pos <- grep("^# Written", rstudioapi::getSourceEditorContext()$contents, )
  if (length(pos) > 0) {
    pos <- min(pos)
    pos_range <- rstudioapi::document_range(c(pos, 0), c((pos + 1), 0))
    rstudioapi::insertText(
      pos_range,
      run_on(linebreak = TRUE),
      id = rstudioapi::documentId(allowConsole = FALSE)
    )
  } else {
    warning(
      "The default PHS R script metadata was not detected, so the R version was not updated."
    )
  }

  if (!git2r::in_repository()) {
    latest_date <- paste0("# Latest update date: ", Sys.Date(), "\n")

    pos <- grep(
      "^# Latest update date",
      rstudioapi::getSourceEditorContext()$contents
    )
    if (length(pos) > 0) {
      pos <- min(pos)
      pos_range <- rstudioapi::document_range(c(pos, 0), c((pos + 1), 0))
      rstudioapi::insertText(
        pos_range,
        latest_date,
        id = rstudioapi::documentId(allowConsole = FALSE)
      )
    } else {
      warning(
        "The default PHS R script metadata was not detected, so the 'latest date' was not updated."
      )
    }
  }
}
