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
#' @family Sensitivity Label functions
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
  file_ext <- tolower(tools::file_ext(file))
  if (!file_ext %in% c("xlsx", "xls", "docx")) {
    cli::cli_abort(
      "{.arg file} must be an Excel workbook or Word document with {.val .xlsx}, {.val .xls}, or {.val .docx} extension, not {.val .{file_ext}}."
    )
  }

  ## Extracting label within Excel workbooks ----

  if (file_ext %in% c("xlsx", "xls")) {
    wb <- openxlsx2::wb_load(file)
    mips <- openxlsx2::wb_get_mips(wb)

    if (is.null(mips) || length(mips) == 0L || mips == "") {
      return("No label")
    }

    # Try to extract label name from XML
    label_name <- which(sensitivity_label_xml == mips) |> names()
  }

  ## Extracting label within Word docs ----

  if (file_ext == "docx") {
    zipdir <- tempdir()
    utils::unzip(file, exdir = zipdir)

    label_file_exists <- file.exists(file.path(
      zipdir,
      "docMetadata",
      "LabelInfo.xml"
    ))

    if (label_file_exists) {
      mips <- xml2::read_xml(file.path(zipdir, "docMetadata", "LabelInfo.xml"))
      label_node <- xml2::xml_find_first(mips, "//clbl:label")
      id_value <- xml2::xml_attr(label_node, "id")
      id_value <- substr(id_value, 2, nchar(id_value) - 1)
      label_id <- grep(id_value, unlist(sensitivity_label_xml))
      label_name <- names(sensitivity_label_xml)[label_id]
    } else {
      return("No label")
    }

    unlink(list.files(zipdir, full.names = TRUE), recursive = TRUE)
  }

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
#' @family Sensitivity Label functions
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
    cli::cli_abort(
      "{.arg file} must be an Excel workbook or Word document with{.val .xlsx}, {.val .xls}, or {.val .docx} extension, not {.val .{file_ext}}."
    )
  }

  # Get label data
  xml <- sensitivity_label_xml[[label]]

  ## Apply label to Excel workbooks ----

  if (file_ext %in% c("xlsx", "xls")) {
    wb <- openxlsx2::wb_load(file)
    wb <- openxlsx2::wb_add_mips(wb, xml)
    openxlsx2::wb_save(wb, file)
  }

  ## Apply label to Word docs ----

  if (file_ext == "docx") {
    # Parsing input
    file_dir <- dirname(file)
    file_name <- basename(file)
    # Removing file type from actual name
    file_name <- tools::file_path_sans_ext(file_name)

    # Zipping process needs its own directory
    # Creates the temporary directory at the same time
    zipdir <- tempdir()

    # Unzip the file into the dir
    utils::unzip(file, exdir = zipdir)

    # Formatting as xml, not character data.
    xml <- xml2::as_xml_document(xml)

    # Create the dir using that name if needed
    if (!dir.exists(file.path(zipdir, "/docMetadata"))) {
      dir.create(
        file.path(zipdir, "/docMetadata"),
        showWarnings = FALSE,
        recursive = TRUE
      )
    }

    # Write the XML data to the temp directory
    xml2::write_xml(
      xml,
      paste0(zipdir, "/docMetadata/LabelInfo.xml"),
      useBytes = TRUE
    )

    # Update content file with new child node if needed
    content <- xml2::read_xml(file.path(zipdir, "/[Content_Types].xml"))
    content_required <- !grepl("docMetadata", content)

    if (content_required) {
      new_node <- xml2::xml_add_child(content, .value = "Override")

      xml2::xml_set_attrs(
        new_node,
        c(
          PartName = "/docMetadata/LabelInfo.xml",
          ContentType = "application/vnd.ms-office.classificationlabels+xml"
        )
      )

      xml2::write_xml(
        content,
        file.path(zipdir, "/[Content_Types].xml"),
        useBytes = TRUE
      )
    }

    # Update .rels file with new child node if needed
    rels_file <- xml2::read_xml(file.path(zipdir, "/_rels/.rels"))
    rels_required <- !grepl("docMetadata", rels_file)

    if (rels_required) {
      xml2::xml_set_attrs(
        xml2::xml_add_child(rels_file, .value = "Relationship"),
        c(
          Id = "rId6",
          Type = "http://schemas.microsoft.com/office/2020/02/relationships/classificationlabels",
          Target = "docMetadata/LabelInfo.xml"
        )
      )

      xml2::write_xml(
        rels_file,
        file.path(zipdir, "/_rels/.rels"),
        useBytes = TRUE
      )
    }

    # Delete original file
    file.remove(file)

    newzip <- file.path(normalizePath(file_dir), paste0(file_name, ".docx"))

    zip::zip(
      zipfile = newzip,
      files = list.files(zipdir),
      recurse = TRUE,
      include_directories = FALSE,
      root = zipdir,
      mode = "mirror"
    ) # end of zip()

    # Delete un-zipped files
    unlink(list.files(zipdir, full.names = TRUE), recursive = TRUE)
  }

  cli::cli_alert_success(
    "Sensitivity label {.val {label}} successfully applied to {.path {basename(file)}}."
  )

  invisible(file)
}
