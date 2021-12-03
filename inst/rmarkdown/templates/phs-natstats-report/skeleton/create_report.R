# Compile report with table of contents and front cover included

# Please change within compile_report() as required for your publication
# Note: filenames need to be filepaths if they are not stored in your current R
# working directory
phstemplates::compile_report(
  rmd_filename   = list.files(pattern = "\\.Rmd$")[1],
  cover_filename = "phs-natstats-cover.docx",
  title          = "My Title",
  subtitle       = "My Subtitle",
  date           = "DD Month YYYY",
  filename_out   = "Report_and_Cover.docx",
  auto_open      = TRUE
)
