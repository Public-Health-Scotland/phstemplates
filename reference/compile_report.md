# compile_report

Compile report with table of contents and front cover included.

## Usage

``` r
compile_report(
  rmd_filename = list.files(pattern = "\\.Rmd$")[1],
  cover_filename = "Cover_Page.docx",
  title = "My Title",
  subtitle = "My Subtitle",
  date = "DD Month YYYY",
  filename_out = "Report_and_Cover.docx",
  auto_open = TRUE,
  toc_level = 3
)
```

## Arguments

- rmd_filename:

  Report filename.

- cover_filename:

  Cover page filename.

- title:

  Title for cover page.

- subtitle:

  Subtitle for cover page.

- date:

  Date of Publication.

- filename_out:

  Output filename for compiled report.

- auto_open:

  Automatically open the report after it is compiled?

- toc_level:

  Maximum title level to use for table of contents.

## Value

Report with table of contents and front cover included in docx format.

## Examples

``` r
if (FALSE) { # \dontrun{
compile_report()
} # }
```
