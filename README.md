## Installation
Install this package with:

```{r install, eval = FALSE}
devtools::install_github("alan-y/phiproject")
```

# *Title of project*
*Description of project*

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
  
## How to use

To use this template, download the repository as a zip file and save it to your local network.
You can then edit the files and folders accordingly, e.g. rename the project or R script files and update the README with a project description and contents.

This template aims to instil best practice within PHI and therefore git has been
initiliased for version control. However, if you are not 
using this then you can delete the .gitignore file. More information about [version control](https://github.com/NHS-NSS-transforming-publications/resources/blob/master/version-control.md).

If you are using git for version control then please be aware that the .gitignore contains the minimum recommended file types and folders to stop data being tracked and pushed to GitHub. Further guidance on using git and GitHub securely can be found [here](https://github.com/NHS-NSS-transforming-publications/GitHub-guidance).

This template is also intended to be flexible, so you may not require every file or folder. For example, if you have written long or multiple functions then we would recommend saving these in the dedicated `functions.R` file, which can then be sourced within the main script(s). Additionally, if you are using many packages then these could be saved within the `packages.R` file and sourced similarly. However, decisions on the exact structure of the folders and scripts should be left up to the analyst's discretion. For more information on structuring and writing R scripts see the [PHI R Style Guide](https://github.com/Health-SocialCare-Scotland/R-Resources/blob/master/PHI%20R%20style%20guide.md).
