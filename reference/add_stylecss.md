# add_stylecss

Add PHS template phs_style.css file to chosen directory.

## Usage

``` r
add_stylecss(
  path = rstudioapi::selectDirectory(caption = "Select folder to add phs_style.css"),
  shinycss = FALSE,
  auto_open = TRUE
)
```

## Arguments

- path:

  String: path to add phs_style.css file. If left blank, RStudio will
  prompt the user.

- shinycss:

  Logical: Whether to append shiny CSS code to the file (TRUE) or not
  (FALSE). If left blank, RStudio will prompt the user.

- auto_open:

  Logical: Automatically open the phs_style.css after it is compiled?

## Value

NULL - Adds phs_style.css file to the directory.

## Examples

``` r
if (FALSE) { # \dontrun{
add_stylecss()
} # }
```
