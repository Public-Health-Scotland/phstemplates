# phsproject

Create new projects according to the PHS R project structure. This
function is meant to be used within RStudio by going to the File menu,
then New Project.

## Usage

``` r
phsproject(
  path,
  author,
  n_scripts = 1,
  git = FALSE,
  renv = FALSE,
  overwrite = FALSE
)
```

## Arguments

- path:

  Filepath for the project.

- author:

  Name of the main author for the project.

- n_scripts:

  Number of code files to start the project with.

- git:

  Initialise the project with Git.

- renv:

  Initialise the project with package management using renv.

- overwrite:

  Logical: Whether to overwrite directory at existing path when creating
  directory.

## Value

New project created according to the PHS R project structure.

## Examples

``` r
if (FALSE) { # \dontrun{
phsproject(path = file.path(getwd(), "testproj"), author = "A Person", n_scripts = 1)
} # }
```
