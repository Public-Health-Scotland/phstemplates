## Contents
- [Installation](#installation)
- [How to use](#how-to-use)
- [Directories created in PHI project](#directories)
- [Files created in PHI project](#files)

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
install.packages("<FILEPATH OF UNZIPPED FILE>/phiproject", repos = NULL,
                 type="source", lib = "<YOUR R PACKAGE LIBRARY DIRECTORY>")
```

## How to use

To use this project template, install the package by following the instructions above. Then simply run the following line of code in R:
```{r install, eval = FALSE}
library(phiproject)
```
After doing this you will then be able to create new R projects with the recommended PHI structure within RStudio by clicking File -> New Project... -> New Directory and selecting PHI R Project Template. As usual, name the project and select a location for the project folder. The original author can also be input - this will automatically add the name to the top section of default scripts within the project. You can then edit the files and folders as appropriate, e.g. rename the R script files or create new sub-folders. The default files and folders contained within the project are described in subsequent sections of this README.

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
  * `.Renviron` - R environment
  * `.Rprofile` - R profile settings
  * `.gitignore` - tells git what files and folders *not* to track or upload to GitHub
  * `README.md` - this page
  * `r-project.Proj` - R project
  

