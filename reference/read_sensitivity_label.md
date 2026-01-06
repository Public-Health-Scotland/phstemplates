# Read Sensitivity Label

Reads the sensitivity label from a Word or Excel file using openxlsx2
package functions. Returns the label name, 'no label' if none is found,
or errors if unexpected.

## Usage

``` r
read_sensitivity_label(file)
```

## Arguments

- file:

  Path to the file (.xlsx, .xlsm, .docx, docm)

## Value

The sensitivity label name, or 'no label' if none is found.

## See also

Other Sensitivity Label functions:
[`apply_sensitivity_label()`](https://public-health-scotland.github.io/phstemplates/reference/apply_sensitivity_label.md)

## Examples

``` r
if (FALSE) { # \dontrun{
# Read the sensitivity label from an Excel file
# Returns the label name or "no label" if none exists
label <- read_sensitivity_label("myfile.xlsx")
print(label)  # "Personal"
} # }
```
