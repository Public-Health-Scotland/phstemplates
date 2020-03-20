# Load required libraries
library(officer)
library(magrittr)



# Create Report and Add Table of Contents ---------------------------------

rmarkdown::render(params$rmd_filename, output_file = "temp_report.docx",
                  envir = new.env())

read_docx("temp_report.docx") %>%
  cursor_reach(keyword = "Introduction") %>%
  body_add_break(pos = "before") %>%
  body_add_toc() %>%
  body_add_par("Contents", pos = "before", style = "Contents Header") %>%
  cursor_reach(keyword = "Introduction") %>%
  body_add_break(pos = "before") %>%
  print("temp_report2.docx")



# Cover Page --------------------------------------------------------------

cover_page <- read_docx("Cover_Page.docx") %>%
  body_replace_all_text("Insert publication title here", params$title) %>%
  body_replace_all_text("Subtitle", params$subtitle) %>%
  body_replace_all_text("DD Month YYYY", params$date)



# Combine Cover and Report ------------------------------------------------

cover_page %>%
  body_add_break() %>%
  cursor_end() %>%
  body_add_docx("temp_report2.docx") %>%
  print(params$filename_out)



# Remove Temporary Files --------------------------------------------------

unlink(c("temp_report.docx", "temp_report2.docx"))
