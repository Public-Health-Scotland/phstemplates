#' @keywords internal
.get_sensitivity_xml_map <- function() {
  list(
    Personal = '<clbl:labelList xmlns:clbl="http://schemas.microsoft.com/office/2020/mipLabelMetadata"><clbl:label id="{9569d428-cde8-4093-8c72-538d9175bce5}" enabled="1" method="Privileged" siteId="{10efe0bd-a030-4bca-809c-b5e6745e499a}" contentBits="0" removed="0"/></clbl:labelList>',
    OFFICIAL = '<clbl:labelList xmlns:clbl="http://schemas.microsoft.com/office/2020/mipLabelMetadata"><clbl:label id="{b4199b9c-a89e-442f-9799-431511f14748}" enabled="1" method="Privileged" siteId="{10efe0bd-a030-4bca-809c-b5e6745e499a}" contentBits="0" removed="0"/></clbl:labelList>',
    OFFICIAL_SENSITIVE_VMO = '<clbl:labelList xmlns:clbl="http://schemas.microsoft.com/office/2020/mipLabelMetadata"><clbl:label id="{155b7326-c67d-4d6b-b15a-6628f0f8cfe7}" enabled="1" method="Privileged" siteId="{10efe0bd-a030-4bca-809c-b5e6745e499a}" contentBits="3" removed="0"/></clbl:labelList>'
  )
}

#' Read Sensitivity Label
#' @description Reads the sensitivity label from a Word or Excel file using
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
#' @family {Sensitivity Label functions}
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
#' @description Applies a sensitivity label to a Word or Excel file using openxlsx2
#' and built-in XML. Supported labels are 'Personal', 'OFFICIAL', and
#' 'OFFICIAL_SENSITIVE_VMO' (visual markings only).
#'
#' The function loads the file, applies the specified sensitivity label
#' using the appropriate XML, and saves the modified file. If successful, it
#' silently returns the file path.
#'
#' @param file Path to the file (.xlsx, .xls, ".docx")
#' @param label Sensitivity label. One of: 'Personal', 'OFFICIAL',
#' 'OFFICIAL_SENSITIVE_VMO'.
#' @return Silently returns the file path if successful.
#' @family {Sensitivity Label functions}
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

  # Check file is valid
  file_ext <- tolower(tools::file_ext(file))
  if (!file_ext %in% c("xlsx", "xls", "docx")) {
    cli::cli_abort("{.arg file} must be an Excel workbook or Word document with{.val .xlsx}, {.val .xls}, or {.val .docx} extension, not {.val .{file_ext}}.")
  }

  # Get label data
  xml <- sensitivity_label_xml[[label]]


  ## Apply label to Excel workbooks ----

  if(file_ext %in% c("xlsx", "xls")){
    wb <- openxlsx2::wb_load(file)
    wb <- openxlsx2::wb_add_mips(wb, xml)
    openxlsx2::wb_save(wb, file)
  }

  ## Apply label to Word docs ----

  if(file_ext == "docx"){
    # Parsing input
    file_path <- dirname(file)
    file_name <- basename(file)
    # Removing file type from actual name
    file_name <- sub(paste0(".", file_ext), "", file_name)

    # Zipping process needs its own directory
    zipdir <- file.path(file_path, tempdir(), fsep = "") # keep fsep as blank

    # Create the dir using that name
    dir.create(zipdir)

    # Unzip the file into the dir
    unzip(file, exdir= zipdir)

    # Formatting as xml, not character data.
    xml <- xml2::as_xml_document(xml)

    # Create the dir using that name
    dir.create(file.path(zipdir, "/docMetadata"), showWarnings = FALSE, recursive = TRUE)

    # Write the XML data to the temp directory
    xml2::write_xml(xml, paste0(zipdir, "/docMetadata/LabelInfo.xml"), useBytes = TRUE)

    # Update content file with new child node
    content <- xml2::read_xml(file.path(zipdir, "/[Content_Types].xml"))
    new_node <- xml2::xml_add_child(content, .value = "Override")

    xml2::xml_set_attrs(new_node, c(
      PartName = "/docMetadata/LabelInfo.xml",
      ContentType = "application/vnd.ms-office.classificationlabels+xml"
    ))

    xml2::write_xml(content, file.path(zipdir, "/[Content_Types].xml"), useBytes = TRUE)

    # Update .rels file with new child node
    rels_file <- xml2::read_xml(file.path(zipdir, "/_rels/.rels"))

    xml2::xml_set_attrs(xml2::xml_add_child(rels_file, .value = "Relationship"), c(
      Id = "rId6",
      Type="http://schemas.microsoft.com/office/2020/02/relationships/classificationlabels",
      Target="docMetadata/LabelInfo.xml"
    ))


    xml2::write_xml(rels_file, file.path(zipdir, "/_rels/.rels"), useBytes = TRUE)

    # Delete original file
    file.remove(file)

    newzip <- file.path(file_path, paste0(file_name, ".docx"))
    file.create(newzip)


    zip::zip(zipfile = newzip,
             files = list.files(zipdir),
             recurse = TRUE,
             include_directories = FALSE,
             root = zipdir,
             mode = "mirror") # end of zip()

    # Delete un-zipped files
    unlink(zipdir, recursive = TRUE)

    # Delete tmp folder
    unlink(file.path(file_path, "tmp"), recursive = TRUE)

  }

  cli::cli_alert_success(
    "Sensitivity label {.val {label}} successfully applied to {.path {basename(file)}}."
  )

  invisible(file)
}

