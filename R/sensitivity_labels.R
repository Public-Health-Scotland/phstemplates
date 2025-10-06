#' Read Sensitivity Label
#' @description Reads the sensitivity label from a Excel or Word file using
#' openxlsx2 package functions. Returns the label name, 'no label' if none is found,
#' or errors if unexpected.
#'
#' @param file Path to the file (.xlsx, .xls, ".docx")
#' @return The sensitivity label name, or 'no label' if none is found.
#' @examples
#' \dontrun{
#' # Read the sensitivity label from an Excel file
#' # Returns the label name or "no label" if none exists
#' label <- read_sensitivity_label("myfile.xlsx")
#' print(label)  # "Personal"
#' }
#' @export
read_sensitivity_label <- function(file) {
  # Parameter validation
  if (missing(file)) {
    cli::cli_abort(
      "{.arg file} is missing with no default."
    )
  }

  if (is.null(file)) {
    cli::cli_abort(
      "{.arg file} must not be {.val NULL}."
    )
  }

  if (!is.character(file) || length(file) != 1L || is.na(file) || file == "") {
    cli::cli_abort(
      "{.arg file} must be a single non-empty character string."
    )
  }

  # Check file existence
  if (!file.exists(file)) {
    cli::cli_abort(
      "File {.path {file}} does not exist."
    )
  }

  # Check file is valid
  file_extension <- tolower(tools::file_ext(file))
  if (!file_extension %in% c("xlsx", "xls", "docx")) {
    cli::cli_abort(
      "{.arg file} must be an Excel workbook or Word document with {.val .xlsx}, {.val .xls}, or {.val .docx} extension, not {.val .{file_ext}}."
    )
  }

  ## Extracting label within Excel workbooks ----

  if(file_ext %in% c("xlsx", "xls")){
    wb <- openxlsx2::wb_load(file)
    mips <- openxlsx2::wb_get_mips(wb)
  }

  ## Extracting label within Word docs ----

  if(file_ext == "docx"){
    mips <- openxlsx2::read_xml(unzip(file,'docMetadata/LabelInfo.xml'))
  }

  if (is.null(mips) || length(mips) == 0L || mips == "") {
    return("No label")
  }

  # Try to extract label name from XML
  label_name <- which(sensitivity_label_xml == mips) |> names()

  if (length(label_name) == 0L) {
    cli::cli_abort(
      "Unknown sensitivity label ID found in file {.path {file}}."
    )
  }

  return(label_name)
}


#' Apply Sensitivity Label
#' @description Applies a sensitivity label to an Excel file using openxlsx2
#' and built-in XML. Supported labels are 'Personal', 'OFFICIAL', and
#' 'OFFICIAL_SENSITIVE_VMO' (visual markings only).
#'
#' The function loads the Excel file, applies the specified sensitivity label
#' using the appropriate XML, and saves the modified file. If successful, it
#' silently returns the file path.
#'
#' @param file Path to the Excel file (.xlsx or .xls)
#' @param label Sensitivity label. One of: 'Personal', 'OFFICIAL',
#' 'OFFICIAL_SENSITIVE_VMO'.
#' @return Silently returns the file path if successful.
#' @export
#' @examples
#' \dontrun{
#' # Apply a sensitivity label to an Excel file
#' # Returns the file path invisibly if successful
#' apply_sensitivity_label("myfile.xlsx", "Personal")
#' }
apply_sensitivity_label <- function(file, label) {
  # Parameter validation
  if (missing(file)) {
    cli::cli_abort(
      "{.arg file} is missing with no default."
    )
  }

  if (missing(label)) {
    cli::cli_abort(
      "{.arg label} is missing with no default."
    )
  }

  if (is.null(file)) {
    cli::cli_abort(
      "{.arg file} must not be {.val NULL}."
    )
  }

  if (is.null(label)) {
    cli::cli_abort(
      "{.arg label} must not be {.val NULL}."
    )
  }

  if (!is.character(file) || length(file) != 1L || is.na(file) || file == "") {
    cli::cli_abort(
      "{.arg file} must be a single non-empty character string."
    )
  }

  if (
    !is.character(label) || length(label) != 1L || is.na(label) || label == ""
  ) {
    cli::cli_abort(
      "{.arg label} must be a single non-empty character string."
    )
  }

  # Validate label against supported options
  valid_labels <- c("Personal", "OFFICIAL", "OFFICIAL_SENSITIVE_VMO")
  if (!label %in% valid_labels) {
    cli::cli_abort(
      "{.arg label} must be one of {.or {.val {valid_labels}}}, not {.val {label}}."
    )
  }

  # Check file existence
  if (!file.exists(file)) {
    cli::cli_abort(
      "File {.path {file}} does not exist."
    )
  }

  # Check file is Excel workbook
  file_extension <- tolower(tools::file_ext(file))
  if (!file_extension %in% c("xlsx", "xls")) {
    cli::cli_abort(
      "{.arg file} must be an Excel workbook with {.val .xlsx} or {.val .xls} extension, not {.val .{file_extension}}."
    )
  }

  # Load workbook and apply label
  wb <- openxlsx2::wb_load(file)
  xml <- sensitivity_label_xml[[label]]
  wb <- openxlsx2::wb_add_mips(wb, xml)
  openxlsx2::wb_save(wb, file)

  cli::cli_alert_success(
    "Sensitivity label {.val {label}} successfully applied to {.path {basename(file)}}."
  )

  invisible(file)
}
