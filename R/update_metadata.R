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
  update_run_on <- rstudioapi::showQuestion(
    title = "Update Run On",
    message = "Update metadata for R version?",
    "Yes", "No"
  )

  update_latest_date <- rstudioapi::showQuestion(
    title = "Update Latest Date",
    message = "Update latest date?",
    "Yes", "No"
  )

  if (update_run_on) {
    run_on <- paste0("# Written/run on RStudio ",
                     rstudioapi::versionInfo()$mode, " ",
                     rstudioapi::versionInfo()$version, " and R ",
                     version$major, ".", version$minor, "\n")

    pos <- grep("^# Written", rstudioapi::getSourceEditorContext()$contents,)
    if (length(pos) > 0) {
      pos <- min(pos)
      pos_range <- rstudioapi::document_range(c(pos, 0), c((pos + 1), 0))
      rstudioapi::insertText(pos_range, run_on,
                             id = rstudioapi::documentId(allowConsole = FALSE))
    } else {
      message("PHS R script metadata for R version not detected")
    }
  }

  if (update_latest_date) {
    latest_date <- paste0("# Latest update date: ", Sys.Date(), "\n")

    pos <- grep("^# Latest update date",
                rstudioapi::getSourceEditorContext()$contents)
    if (length(pos) > 0) {
      pos <- min(pos)
      pos_range <- rstudioapi::document_range(c(pos, 0), c((pos + 1), 0))
      rstudioapi::insertText(pos_range, latest_date,
                             id = rstudioapi::documentId(allowConsole = FALSE))
    } else {
      message("PHS R script metadata for latest date not detected")
    }
  }
}
