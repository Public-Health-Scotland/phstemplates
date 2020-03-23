# Compile report with table of contents and front cover included


# Parameters: please change as required for your publication
# Note: filenames need to be filepaths if they are not stored in your current R
# working directory
params <- list(
  # Report filename - Please check carefully
  rmd_filename    = "Report.Rmd",
  # Cover page filename - Please check carefully
  cover_filename  = "Cover_Page.docx",
  # Title for cover page
  title           = "My Title",
  # Subtitle for cover page
  subtitle        = "My Subtitle",
  # Date of Publication
  date            = "DD Month YYYY",
  # Output filename for compiled report
  filename_out    = "Report_and_Cover.docx"
)

source("compile.R")
# Note: if it does not find the script, check your working directory with getwd()


# PLEASE READ
# When the report has been compiled with the table of contents and cover page
# included, keep a note of the following:
# In Word 2007, there may be a warning popup when you open the report saying that
# the document contains fields that may refer to other files: click Yes
# If you want to get rid of this warning, re-save the file after opening it
# In Word 2016, there may be no warning popup but the table of contents may not
# immediately appear - to make it appear go to the 'References' tab and click
# 'Update Table'
