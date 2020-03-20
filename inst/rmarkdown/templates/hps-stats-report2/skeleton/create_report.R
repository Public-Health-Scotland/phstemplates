# Compile report with table of contents and front cover included


# Parameters - This should be the only section that needs edited
# Change as required for your publication
# Note: filenames need to be filepaths if they are not stored in your R working
# directory
params <- list(
  rmd_filename    = "Report.Rmd",
  cover_filename  = "Cover_Page.docx",
  title           = "My Title",
  subtitle        = "My Subtitle",
  date            = "DD Month YYYY",
  filename_out    = "Report_and_Cover.docx"
)

source("create_report_source.R")


# PLEASE READ
# When the report has been compiled with the table of contents and cover page
# included, keep a note of the following:
# In Word 2007, there may be a warning popup when you open the report saying that
# the document contains fields that may refer to other files: click Yes
# If you want to get rid of this warning, re-save the file after opening it
# In Word 2016, there may be no warning popup but the table of contents may not
# immediately appear - to make it appear go to the 'References' tab and click
# 'Update Table'
