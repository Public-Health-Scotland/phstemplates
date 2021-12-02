#' compile_report
#' @description Compile report with table of contents and front cover included.
#'
#' @param rmd_filename Report filename.
#' @param cover_filename Cover page filename.
#' @param title Title for cover page.
#' @param subtitle Subtitle for cover page.
#' @param date Date of Publication.
#' @param filename_out Output filename for compiled report.
#' @param auto_open Automatically open the report after it is compiled?
#' @return Report with table of contents and front cover included in docx format.
#' @export
#' @examples
#' \dontrun{
#' compile_report()
#' }
compile_report <- function(rmd_filename = list.files(pattern = "\\.Rmd$")[1],
                           cover_filename = "Cover_Page.docx",
                           title = "My Title",
                           subtitle = "My Subtitle",
                           date = "DD Month YYYY",
                           filename_out = "Report_and_Cover.docx",
                           auto_open = TRUE) {

  rmd_exists <- file.exists(rmd_filename)
  cover_exists <- file.exists(cover_filename)

  if (!rmd_exists) {
    message("Error: Cannot find the input Rmd file. Have you input the wrong filename?")
  }

  if (!cover_exists) {
    message("Error: Cannot find the input Cover Page file. Have you input the wrong filename?")
  }

  if (!(rmd_exists && cover_exists)) {
    message("If you are not using full filepaths to your input files:")
    message("Has the working directory been set properly?\n")
    message("Here is your working directory\n", getwd(), "\n")
    message("and here are the files in it")
    print(list.files())

    message("If the input files you expect to see are not listed, the working directory will be wrong")
  } else {
    message("Found all required input files. Compiling report...")

    # Create Report and Add Table of Contents
    rmarkdown::render(rmd_filename, output_file = "temp_report.docx",
                      envir = new.env())

    officer::read_docx("temp_report.docx") %>%
      officer::cursor_reach(keyword = "Introduction") %>%
      officer::body_add_toc(pos = "before") %>%
      officer::body_add_par("Contents", pos = "before", style = "TOC Heading") %>%
      officer::cursor_reach(keyword = "Introduction") %>%
      officer::body_add_break(pos = "before") %>%
      print("temp_report2.docx")

    # Cover Page
    cover_page <- officer::read_docx(cover_filename) %>%
      officer::body_replace_all_text("Title", title) %>%
      officer::body_replace_all_text("Subtitle", subtitle) %>%
      officer::body_replace_all_text("DD Month YYYY", date)

    # Combine Cover and Report
    cover_page %>%
      officer::cursor_end() %>%
      officer::body_remove() %>%
      officer::body_add_break() %>%
      officer::body_add_docx("temp_report2.docx") %>%
      officer::set_doc_properties(title = title) %>%
      print(filename_out)

    # Remove Temporary Files
    unlink(c("temp_report.docx", "temp_report2.docx"))

    message("Report saved as ", filename_out)
    message("When the report opens, you may get a warning popup saying:\n",
            "This document contains fields that may refer to other files. ",
            "Do you want to update the fields in this document?\n",
            "Click Yes\n",
            "This appears because the table of contents was added programmatically\n",
            "If you want to get rid of this warning, re-save the file after opening it")

    if (auto_open) {
      file.show(filename_out)
    }
  }
}
