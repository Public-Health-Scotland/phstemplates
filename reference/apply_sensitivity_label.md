# Apply Sensitivity Label

Applies a sensitivity label to a Word or Excel file using openxlsx2 and
built-in XML. Supported labels are 'Personal', 'OFFICIAL', and
'OFFICIAL_SENSITIVE_VMO' (visual markings only).

The function loads the file, applies the specified sensitivity label
using the appropriate XML, and saves the modified file. If successful,
it silently returns the file path.

## Usage

``` r
apply_sensitivity_label(file, label)
```

## Arguments

- file:

  Path to the file (.xlsx, .xlsm, .docx, .docm)

- label:

  Sensitivity label. One of: 'Personal', 'OFFICIAL',
  'OFFICIAL_SENSITIVE_VMO'.

## Value

Silently returns the file path if successful.

## See also

Other Sensitivity Label functions:
[`read_sensitivity_label()`](https://public-health-scotland.github.io/phstemplates/reference/read_sensitivity_label.md)

## Examples

``` r
if (FALSE) { # \dontrun{
# Apply a sensitivity label to an Excel file
# Returns the file path invisibly if successful
apply_sensitivity_label("myfile.xlsx", "Personal")
} # }
```
