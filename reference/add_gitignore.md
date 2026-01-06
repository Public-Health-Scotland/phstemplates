# add_gitignore

Add PHS template .gitignore file to chosen directory.

## Usage

``` r
add_gitignore(
  path = rstudioapi::selectDirectory(caption = "Select folder to add .gitignore"),
  append = NULL
)
```

## Arguments

- path:

  String: path to add .gitignore file. If left blank, will prompt the
  user within R Studio

- append:

  Logical: if a .gitignore already exists, whether to append contents
  (TRUE) or overwrite (FALSE). If left blank will prompt the user within
  R Studio.

## Value

Adds .gitignore file to directory, or appends content to existing file.

## Examples

``` r
if (FALSE) { # \dontrun{
add_gitignore()
} # }
```
