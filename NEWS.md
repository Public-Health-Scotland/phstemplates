# phstemplates 1.2.3

* Added accessibility guidance to shiny template.

# phstemplates 1.2.2

* The `compile_report()` and `phs_report_docx()` no longer need to search for the word 'Introduction' to add in the table of contents to PHS report templates.
* The PHS shiny app template now includes the name of the app entered by the user at the top of the readme.

# phstemplates 1.2.1

* Updated accredited official statistics templates to include the accredited badge.

# phstemplates 1.2.0

* Updated official statistics, accredited official statistics (formerly national statistics), official statistics in development and management information templates to 2024 versions.
* Removed the use of the captioner package in report templates as it is no longer on CRAN.

# phstemplates 1.1.1

* Added three Management information templates for Word documents, accessible through RStudio menu: a Management Info Report, A Management Info Summary, and, a Management Info One Page template.
* The Management Info One Page template will accommodate using more than one page and applies page numbers from page 2 onwards, so could also be used as a template for a simple information request response.
* Basic PHS style HTML template.
* RStudio addin for `add_stylecss()` so users can add a PHS style.css file directly from RStudio.
* RStudio addin to update the metadata in existing R scripts for latest update date and R version run on.

# phstemplates 1.1.0

* Added PHS shiny app template, accessible through the RStudio menus or through `phsshinyapp()`.

# phstemplates 1.0.1

* Added `add_gitignore()` function which allows the user to add a PHS style `.gitignore` file to a given directory
* RStudio addin for `add_gitignore()` so users can add `.gitignore` directly from RStudio.
* Minor updates to template text and fixed README link

# phstemplates 1.0.0

* Added the `phs_report_docx` RMarkdown document type.
* Updated the PHS official and national stats report templates to use the `phs_report_docx` RMarkdown document type.
* Removed the ISD national stats summary and report templates.

# phstemplates 0.9.6

* Added PHS official and national stats summary and report documents for 2022.

# phstemplates 0.9.5

* Added `compile_report()` function to handle creating reports.
* Added a code chunk at the top of report templates to help set the working directory.

# phstemplates 0.9.4

* Added PHS official stats summary and report documents.
* Added PHS Powerpoint 16:9 template.

# phstemplates 0.9.3

* Removed use of renv global cache directories.

# phstemplates 0.9.2

* Added PHS ioslides template.
* Some parts of metadata for scripts are now pre-filled.
* Some parts of metadata for scripts automatically removed if using git.

# phstemplates 0.9.1

* Update of PHS national stats summary and report documents.

# phstemplates 0.9.0

* PHS template for RStudio 1.2.
* Fixed gitignore for Excel files.

# phstemplates 0.8.3

* Changes required for change to PHS.

# phstemplates 0.8.2

* Renamed project function to `phsproject()` in preparation for package name change.
* Better error checking of filepaths for the RStudio 1.2 HPS report template.

# phstemplates 0.8.1

* Option to initialise new project with Git enabled.
* RStudio addin to add new R script based on the template.

# phstemplates 0.8.0

* Start new project with more than one code file.
* Added RMarkdown templates for ISD national stats reports and summaries.
