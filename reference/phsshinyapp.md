# phsshinyapp

Create new shiny app according to the PHS R project structure. This
function is meant to be used within RStudio by going to the File menu,
then New Project.

## Usage

``` r
phsshinyapp(
  path,
  author = get_name(),
  app_name = "WRITE APP NAME HERE",
  phs_white_logo = TRUE,
  git = FALSE,
  renv = FALSE,
  overwrite = FALSE
)
```

## Arguments

- path:

  String: Filepath for the project.

- author:

  String: Name of the main author for the project.

- app_name:

  String: name of application.

- phs_white_logo:

  Logical: Use a white PHS logo.

- git:

  Logical: Initialise the project with Git.

- renv:

  Logical: Initialise the project with package management using renv.

- overwrite:

  Logical: Whether to overwrite directory at existing path when creating
  directory.

## Value

New project created according to the PHS R project structure.

## Examples

``` r
if (FALSE) { # \dontrun{
phsshinyapp(
  path = file.path(getwd(), "testproj"), app_name = "My lovely app",
  author = "A Person", n_scripts = 1
)
} # }
```
