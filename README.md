<!-- badges: start -->
[![GitHub release (latest by date)](https://img.shields.io/github/v/release/Public-Health-Scotland/phstemplates)](https://github.com/Public-Health-Scotland/phstemplates/releases/latest)
[![R-CMD-check](https://github.com/Public-Health-Scotland/phstemplates/workflows/R-CMD-check/badge.svg)](https://github.com/Public-Health-Scotland/phstemplates/actions)
<!-- badges: end -->

## Contents
- [Installation](#installation)
- [How to use](#how-to-use)
- [Directories](#directories)
- [Files](#files)
- [RMarkdown Templates](#rmarkdown-templates)

## Installation
Install this package by running the following code in R:
```{r install, eval = FALSE}
remotes::install_github("Public-Health-Scotland/phstemplates", ref = "main")
```

If you are working inside the PHS network then this may not work in which case follow these steps:
1. Click **Clone or download**
2. Click **Download ZIP**
3. Save the zip file locally
4. Unzip the zip file
5. Replace the sections marked `<>` below (including the arrows themselves) and run the following code in R:

```{r source-installation, eval = FALSE}
install.packages("<FILEPATH OF UNZIPPED FILE>/phstemplates-main", repos = NULL,
                 type = "source")
```
If you encounter any issues with the automatic installation of package dependencies using this method, you may need to install these manually prior to running the code to install phstemplates. In this case, it should tell you which packages you need. For example, if you need [flextable](https://davidgohel.github.io/flextable) and [officer](https://davidgohel.github.io/officer), install these first:

```{r source-installation-issues, eval = FALSE}
install.packages(c("flextable", "officer"))
```

A further option is to install this package using [drat](https://github.com/eddelbuettel/drat). The advantage of this method is that it should work from within the PHS network but the disadvantage is that it may not always be completely in sync with the latest version of the package on Github. Note that the first line to install the drat package is only needed if you don't already have it installed.

```{r drat-installation, eval = FALSE}
install.packages("drat")
drat::addRepo("alan-y")
install.packages("phstemplates")
```

## Making a new PHS project
To use this project template, install the package by following the instructions above. After doing this you will then be able to create new R projects with the recommended PHS structure within RStudio by clicking **File -> New Project... -> New Directory** and selecting **PHS R Project Template**. Name the project and select a location for the project folder. The original author can also be input - this will automatically add the name to the top section of default scripts within the project. You can then edit the files and folders as appropriate, e.g. rename the R script files or create new sub-folders. The default files and folders contained within the project are described in subsequent sections of this README.

This template aims to instil best practice within PHS and therefore git has been initialised for version control. However, if you are not using this then you can delete the .gitignore file. More information about [version control](https://github.com/Public-Health-Scotland/resources/blob/master/version-control.md).

If you are using git for version control then please be aware that the .gitignore contains the minimum recommended file types and folders to stop data being tracked and pushed to GitHub. Further guidance on using git and GitHub securely can be found [here](https://github.com/Public-Health-Scotland/GitHub-guidance).

This template is also intended to be flexible, so you may not require every file or folder. For example, if you have written long or multiple functions then we would recommend saving these in the dedicated `functions.R` file, which can then be sourced within the main script(s). Additionally, if you are using many packages then these could be saved within the `packages.R` file and sourced similarly. However, decisions on whether these files are required and the exact structure of the folders and scripts should be left up to the analyst's discretion. For more guidance on structuring and writing R scripts follow the organisation's [R Style Guide](https://github.com/Public-Health-Scotland/R-Resources/blob/master/PHS%20R%20style%20guide.md).

### Directories
  * `code` - R scripts required for project
    + `code.R` - example structure for main R script(s)
    + `functions.R` - functions sourced and used in main script(s)
    + `packages.R` - list of packages sourced and used in main script(s)
  * `data` - data required for project
    + `basefiles`
    + `output`
    + `temporary`

### Files
  * `.gitignore` - tells git what files and folders *not* to track or upload to GitHub
  * `README.md` - this page
  * `.Rprofile` - R profile settings
  * `r-project.Proj` - R project]
  
## Making a new PHS shiny app
After installation you will then be able to create new R shiny apps with PHS styling within RStudio by clicking **File -> New Project... -> New Directory** and selecting **PHS R Shiny App**. Name the app and select a location for the project folder. The original author can also be input - this will automatically add the name to the top section of default scripts within the project. You can then edit the files and folders as appropriate, e.g. rename the R script files or create new sub-folders. The default files and folders contained within the project are described in the README which is created inside the new shiny app template.

## Adding a PHS `.gitignore` file to an existing directory
If you want to add a PHS style `.gitignore` to a given directory, you can do this in R Studio by selecting `Addins` on the top banner then scrolling down to the PHSTEMPLATES section and choosing **Add PHS .gitignore file**. This will allow you to choose the location of your new `.gitignore` file. You can also do this directly from the R console using the command `phstemplates::add_gitignore()`.


## RMarkdown Templates
This package currently provides a number of RMarkdown templates including templates for PHS national statistics report and summary documents but please note that these require pandoc v2 (or RStudio v1.2 which comes with the required version of pandoc). You can check the version of pandoc that you have with `rmarkdown::pandoc_version()`.

You can access these templates in RStudio by clicking **File -> New File -> R Markdown -> From Template**.

### Adding a new template
1. Clone phstemplates and load it up in RStudio
2. Create your own Git branch and switch to that branch
3. In R, type `usethis::use_rmarkdown_template("my-template")` where you replace `my-template` with the name you want to give your template. This is actually just the name it gives to the folder that stores your template so the name should not have spaces but can contain dashes or underscores. The name should also not be too long as this may cause issues when building the package. This will create a basic structure for your template within the directory `inst\rmarkdown\templates\my-template`
4. Open up `template.yaml` in the folder just created for your template. Update the name and description as appropriate for your template.
5. Go to the 'skeleton' folder (`inst\rmarkdown\templates\my-template\skeleton`) and delete `skeleton.Rmd`
6. Copy and paste your RMarkdown template file and any associated files required for the template into the 'skeleton' folder (e.g. you may have an MS Word reference document to set up styles)
7. Rename your RMarkdown template file to `skeleton.Rmd`
8. Run `devtools::check()` and make sure the package passes all the checks
9. Run `devtools::install()`, then restart RStudio and check that your templates can be loaded from the RStudio menus
10. Push to Github
11. Create a pull request and ask for a review from an appropriate staff member so the changes can be merged

### Updating an existing template
1. Clone phstemplates and load it up in RStudio
2. Create your own Git branch and switch to that branch
3. Rename your updated template file to `skeleton.Rmd` and place it (and any associated files if they have also been updated) inside the 'skeleton' folder of your template (`inst\rmarkdown\templates\your-template\skeleton`)
4. Run `devtools::check()` and make sure the package passes all the checks
5. Run `devtools::install()`, then restart RStudio and check that your templates can be loaded from the RStudio menus
6. Push to Github
7. Create a pull request and ask for a review from an appropriate staff member so the changes can be merged
