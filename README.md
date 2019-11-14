## Contents
- [Installation](#installation)
- [How to use](#how-to-use)
- [Directories created in PHI project](#directories)
- [Files created in PHI project](#files)
- [RMarkdown Templates](#rmarkdown-templates)

## Installation
Install this package by running the following code in R:
```{r install, eval = FALSE}
devtools::install_github("Health-SocialCare-Scotland/phiproject")
```

If you are working inside the NSS network then this may not work in which case follow these steps:
1. Click **Clone or download**
2. Click **Download ZIP**
3. Save the zip file locally
4. Unzip the zip file
5. Replace the sections marked `<>` below (including the arrows themselves) and run the following code in R:

```{r source-installation, eval = FALSE}
install.packages("<FILEPATH OF UNZIPPED FILE>/phiproject-master", repos = NULL,
                 type = "source")
```

## How to use

To use this project template, install the package by following the instructions above. After doing this you will then be able to create new R projects with the recommended PHI structure within RStudio by clicking File -> New Project... -> New Directory and selecting PHI R Project Template. As usual, name the project and select a location for the project folder. The original author can also be input - this will automatically add the name to the top section of default scripts within the project. You can then edit the files and folders as appropriate, e.g. rename the R script files or create new sub-folders. The default files and folders contained within the project are described in subsequent sections of this README.

This template aims to instil best practice within PHI and therefore git has been initiliased for version control. However, if you are not using this then you can delete the .gitignore file. More information about [version control](https://github.com/NHS-NSS-transforming-publications/resources/blob/master/version-control.md).

If you are using git for version control then please be aware that the .gitignore contains the minimum recommended file types and folders to stop data being tracked and pushed to GitHub. Further guidance on using git and GitHub securely can be found [here](https://github.com/NHS-NSS-transforming-publications/GitHub-guidance).

This template is also intended to be flexible, so you may not require every file or folder. For example, if you have written long or multiple functions then we would recommend saving these in the dedicated `functions.R` file, which can then be sourced within the main script(s). Additionally, if you are using many packages then these could be saved within the `packages.R` file and sourced similarly. However, decisions on whether these files are required and the exact structure of the folders and scripts should be left up to the analyst's discretion. For more guidance on structuring and writing R scripts follow the [PHI R Style Guide](https://github.com/Health-SocialCare-Scotland/R-Resources/blob/master/PHI%20R%20style%20guide.md).

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
  * `r-project.Proj` - R project

## RMarkdown Templates

This package currently provides two RMarkdown templates: [one for producing ISD national statistics reports and one for producing ISD national statistics summary documents](https://github.com/NHS-NSS-transforming-publications/National-Stats-Template). You can access these templates in RStudio by clicking File -> New File -> R Markdown -> From Template.

### Adding a new template to phiproject
1. Clone phiproject and load it up in RStudio
2. Create your own Git branch and switch to that branch
3. In R, type `usethis::use_rmarkdown_template("my-template")` where you replace `my-template` with the name you want to give your template. This is actually just the name it gives to the folder that stores your template so the name should not have spaces but can contain dashes or underscores. This will create a basic structure for your template within the directory `inst\rmarkdown\templates\my-template`
4. Open up `template.yaml` in the folder just created for your template. Update the name and description as appropriate for your template.
5. Go to the 'skeleton' folder (`inst\rmarkdown\templates\my-template\skeleton`) and delete `skeleton.Rmd`
6. Copy and paste your RMarkdown template file and any associated files required for the template into the 'skeleton' folder (e.g. you may have an MS Word reference document to set up styles)
7. Rename your RMarkdown template file to `skeleton.Rmd`
8. Run `devtools::check()` and make sure the package passes all the checks
9. Run `devtools::install()`, then restart RStudio and check that your templates can be loaded from the RStudio menus
10. Push to Github
11. Create a pull request and ask for a review from an appropriate staff member so the changes can be merged

### Updating an existing template for phiproject
1. Clone phiproject and load it up in RStudio
2. Create your own Git branch and switch to that branch
3. Rename your updated template file to `skeleton.Rmd` and place it (and any associated files if they have also been updated) inside the 'skeleton' folder of your template (`inst\rmarkdown\templates\your-template\skeleton`)
4. Run `devtools::check()` and make sure the package passes all the checks
5. Run `devtools::install()`, then restart RStudio and check that your templates can be loaded from the RStudio menus
6. Push to Github
7. Create a pull request and ask for a review from an appropriate staff member so the changes can be merged
