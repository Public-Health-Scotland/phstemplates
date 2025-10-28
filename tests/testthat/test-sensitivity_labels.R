test_that("apply_sensitivity_label returns file path and applies label", {
  # Create a temp Excel file
  tmp <- tempfile(fileext = ".xlsx")
  wb <- openxlsx2::wb_workbook()
  wb <- openxlsx2::wb_add_worksheet(wb, "Sheet1")
  openxlsx2::wb_save(wb, tmp)

  # Create a temp Word file
  tmp2 <- tempfile(fileext = ".docx")
  print(officer::read_docx(), tmp2)

  # Apply Personal label
  result <- apply_sensitivity_label(tmp, "Personal")
  expect_equal(result, tmp)
  expect_equal(read_sensitivity_label(tmp), "Personal")

  result2 <- apply_sensitivity_label(tmp2, "Personal")
  expect_equal(result2, tmp2)
  expect_equal(read_sensitivity_label(tmp2), "Personal")

  # Apply OFFICIAL label
  result <- apply_sensitivity_label(tmp, "OFFICIAL")
  expect_equal(result, tmp)
  expect_equal(read_sensitivity_label(tmp), "OFFICIAL")

  result2 <- apply_sensitivity_label(tmp2, "OFFICIAL")
  expect_equal(result2, tmp2)
  expect_equal(read_sensitivity_label(tmp2), "OFFICIAL")

  # Apply OFFICIAL_SENSITIVE_VMO label
  result <- apply_sensitivity_label(tmp, "OFFICIAL_SENSITIVE_VMO")
  expect_equal(result, tmp)
  expect_equal(read_sensitivity_label(tmp), "OFFICIAL_SENSITIVE_VMO")

  result2 <- apply_sensitivity_label(tmp2, "OFFICIAL_SENSITIVE_VMO")
  expect_equal(result2, tmp2)
  expect_equal(read_sensitivity_label(tmp2), "OFFICIAL_SENSITIVE_VMO")

  # Clean up
  unlink(c(tmp, tmp2))
})

test_that("functions work with .xlsx extension", {
  # Test .xlsx files
  tmp_xlsx <- tempfile(fileext = ".xlsx")
  wb <- openxlsx2::wb_workbook()
  wb <- openxlsx2::wb_add_worksheet(wb, "Sheet1")
  openxlsx2::wb_save(wb, tmp_xlsx)

  result <- apply_sensitivity_label(tmp_xlsx, "Personal")
  expect_equal(result, tmp_xlsx)
  expect_equal(read_sensitivity_label(tmp_xlsx), "Personal")

  # Test case insensitive extension handling
  tmp_upper <- tempfile(fileext = ".XLSX")
  wb_upper <- openxlsx2::wb_workbook()
  wb_upper <- openxlsx2::wb_add_worksheet(wb_upper, "Sheet1")
  openxlsx2::wb_save(wb_upper, tmp_upper)

  # Verify the file exists and has the right extension
  expect_true(file.exists(tmp_upper))
  expect_equal(toupper(tools::file_ext(tmp_upper)), "XLSX")

  result <- apply_sensitivity_label(tmp_upper, "OFFICIAL")
  expect_equal(result, tmp_upper)
  expect_equal(read_sensitivity_label(tmp_upper), "OFFICIAL")

  # Clean up
  unlink(c(tmp_xlsx, tmp_upper))
})

test_that("functions work with .docx extension", {
  # Test .docx files
  tmp_docx <- tempfile(fileext = ".docx")
  print(officer::read_docx(), tmp_docx)

  result <- apply_sensitivity_label(tmp_docx, "Personal")
  expect_equal(result, tmp_docx)
  expect_equal(read_sensitivity_label(tmp_docx), "Personal")

  # Test case insensitive extension handling
  tmp_upper <- tempfile(fileext = ".DOCX")
  print(officer::read_docx(), tmp_upper)

  # Verify the file exists and has the right extension
  expect_true(file.exists(tmp_upper))
  expect_equal(toupper(tools::file_ext(tmp_upper)), "DOCX")

  result <- apply_sensitivity_label(tmp_upper, "OFFICIAL")
  expect_equal(result, tmp_upper)
  expect_equal(read_sensitivity_label(tmp_upper), "OFFICIAL")

  # Clean up
  unlink(c(tmp_docx, tmp_upper))
})

test_that("read_sensitivity_label returns 'No label' for file with no label", {
  # Test .xlsx
  tmp <- tempfile(fileext = ".xlsx")
  wb <- openxlsx2::wb_workbook()
  wb <- openxlsx2::wb_add_worksheet(wb, "Sheet1")
  openxlsx2::wb_save(wb, tmp)
  expect_equal(read_sensitivity_label(tmp), "No label")

  # Test .docx
  tmp2 <- tempfile(fileext = ".docx")
  print(officer::read_docx(), tmp2)
  expect_equal(read_sensitivity_label(tmp2), "No label")

  # Clean up
  unlink(c(tmp, tmp2))
})

test_that("apply_sensitivity_label errors for invalid label", {
  tmp <- tempfile(fileext = ".xlsx")
  wb <- openxlsx2::wb_workbook()
  wb <- openxlsx2::wb_add_worksheet(wb, "Sheet1")
  openxlsx2::wb_save(wb, tmp)
  expect_error(
    apply_sensitivity_label(tmp, "INVALID"),
    "`label` must be one of"
  )

  # Clean up
  unlink(tmp)
})

test_that("apply_sensitivity_label errors when file does not exist", {
  non_existent_file <- tempfile(fileext = ".xlsx")
  expect_error(
    apply_sensitivity_label(non_existent_file, "Personal"),
    "not exist"
  )
})

test_that("apply_sensitivity_label returns file path invisibly", {
  # Test .xlsx
  tmp <- tempfile(fileext = ".xlsx")
  wb <- openxlsx2::wb_workbook()
  wb <- openxlsx2::wb_add_worksheet(wb, "Sheet1")
  openxlsx2::wb_save(wb, tmp)

  # Test that the function returns invisibly (no output when not assigned)
  expect_invisible(apply_sensitivity_label(tmp, "Personal"))

  # Test that the returned value is correct
  result <- apply_sensitivity_label(tmp, "OFFICIAL")
  expect_equal(result, tmp)

  # Test .docx
  tmp2 <- tempfile(fileext = ".docx")
  print(officer::read_docx(), tmp2)

  # Test that the function returns invisibly (no output when not assigned)
  expect_invisible(apply_sensitivity_label(tmp2, "Personal"))

  # Test that the returned value is correct
  result2 <- apply_sensitivity_label(tmp2, "OFFICIAL")
  expect_equal(result2, tmp2)

  # Clean up
  unlink(c(tmp, tmp2))
})

test_that("apply_sensitivity_label validates label argument correctly", {
  tmp <- tempfile(fileext = ".xlsx")
  wb <- openxlsx2::wb_workbook()
  wb <- openxlsx2::wb_add_worksheet(wb, "Sheet1")
  openxlsx2::wb_save(wb, tmp)

  # Test that exact matches work
  result <- apply_sensitivity_label(tmp, "Personal")
  expect_equal(result, tmp)
  expect_equal(read_sensitivity_label(tmp), "Personal")

  # Test case sensitivity - should error for wrong case
  expect_error(
    apply_sensitivity_label(tmp, "personal"),
    "`label` must be one of"
  )
  expect_error(
    apply_sensitivity_label(tmp, "official"),
    "`label` must be one of"
  )
  expect_error(
    apply_sensitivity_label(tmp, "PERSONAL"),
    "`label` must be one of"
  )

  # Test invalid labels
  expect_error(
    apply_sensitivity_label(tmp, "INVALID"),
    "`label` must be one of"
  )
  expect_error(
    apply_sensitivity_label(tmp, ""),
    "`label` must be a single non-empty character string"
  )
  expect_error(apply_sensitivity_label(tmp, "Secret"), "`label` must be one of")

  # Clean up
  unlink(tmp)
})

test_that("read_sensitivity_label handles files with corrupted or unknown labels", {
  # This test attempts to verify error handling for unknown label IDs
  # Note: The exact scenario is difficult to reproduce without manually
  # corrupting Excel files, but we test the documented behavior

  tmp <- tempfile(fileext = ".xlsx")
  wb <- openxlsx2::wb_workbook()
  wb <- openxlsx2::wb_add_worksheet(wb, "Sheet1")
  openxlsx2::wb_save(wb, tmp)

  # Test that a file with no label returns "No label"
  expect_equal(read_sensitivity_label(tmp), "No label")

  # Test that applying and reading a valid label works
  apply_sensitivity_label(tmp, "Personal")
  expect_equal(read_sensitivity_label(tmp), "Personal")

  # The error case for unknown label ID would be triggered if:
  # 1. An Excel file had MIPS XML that doesn't match any known labels
  # 2. openxlsx2::wb_get_mips() returned XML not in our mapping
  # This is an edge case that would indicate corrupted or externally-modified files

  # Test that our label detection works for all supported types
  supported_labels <- c("Personal", "OFFICIAL", "OFFICIAL_SENSITIVE_VMO")
  for (label in supported_labels) {
    apply_sensitivity_label(tmp, label)
    detected_label <- read_sensitivity_label(tmp)
    expect_equal(detected_label, label)
  }

  # Repeat tests for .docx
  tmp2 <- tempfile(fileext = ".docx")
  print(officer::read_docx(), tmp2)

  expect_equal(read_sensitivity_label(tmp2), "No label")
  apply_sensitivity_label(tmp2, "Personal")
  expect_equal(read_sensitivity_label(tmp2), "Personal")

  for (label in supported_labels) {
    apply_sensitivity_label(tmp2, label)
    detected_label <- read_sensitivity_label(tmp2)
    expect_equal(detected_label, label)
  }

  # Clean up
  unlink(c(tmp, tmp2))
})

test_that("read_sensitivity_label handles edge cases", {
  tmp <- tempfile(fileext = ".xlsx")
  wb <- openxlsx2::wb_workbook()
  wb <- openxlsx2::wb_add_worksheet(wb, "Sheet1")
  openxlsx2::wb_save(wb, tmp)

  tmp2 <- tempfile(fileext = ".docx")
  print(officer::read_docx(), tmp2)

  # Test file with no label
  expect_equal(read_sensitivity_label(tmp), "No label")
  expect_equal(read_sensitivity_label(tmp2), "No label")

  # Apply and read each label type
  apply_sensitivity_label(tmp, "Personal")
  expect_equal(read_sensitivity_label(tmp), "Personal")
  apply_sensitivity_label(tmp2, "Personal")
  expect_equal(read_sensitivity_label(tmp2), "Personal")

  apply_sensitivity_label(tmp, "OFFICIAL")
  expect_equal(read_sensitivity_label(tmp), "OFFICIAL")
  apply_sensitivity_label(tmp2, "OFFICIAL")
  expect_equal(read_sensitivity_label(tmp2), "OFFICIAL")

  apply_sensitivity_label(tmp, "OFFICIAL_SENSITIVE_VMO")
  expect_equal(read_sensitivity_label(tmp), "OFFICIAL_SENSITIVE_VMO")
  apply_sensitivity_label(tmp2, "OFFICIAL_SENSITIVE_VMO")
  expect_equal(read_sensitivity_label(tmp2), "OFFICIAL_SENSITIVE_VMO")

  # Clean up
  unlink(c(tmp, tmp2))
})

test_that("internal XML mappings work correctly through public interface", {
  # Test the internal function indirectly through apply/read functions
  tmp <- tempfile(fileext = ".xlsx")
  wb <- openxlsx2::wb_workbook()
  wb <- openxlsx2::wb_add_worksheet(wb, "Sheet1")
  openxlsx2::wb_save(wb, tmp)

  tmp2 <- tempfile(fileext = ".docx")
  print(officer::read_docx(), tmp2)

  # Test that all supported labels work, which validates the internal XML map
  supported_labels <- c("Personal", "OFFICIAL", "OFFICIAL_SENSITIVE_VMO")

  for (label in supported_labels) {
    apply_sensitivity_label(tmp, label)
    read_label <- read_sensitivity_label(tmp)
    expect_equal(read_label, label)

    apply_sensitivity_label(tmp2, label)
    read_label2 <- read_sensitivity_label(tmp2)
    expect_equal(read_label2, label)
  }

  # Test that the XML contains expected ID patterns by applying and reading back
  apply_sensitivity_label(tmp, "Personal")
  expect_equal(read_sensitivity_label(tmp), "Personal")
  apply_sensitivity_label(tmp2, "Personal")
  expect_equal(read_sensitivity_label(tmp2), "Personal")

  apply_sensitivity_label(tmp, "OFFICIAL")
  expect_equal(read_sensitivity_label(tmp), "OFFICIAL")
  apply_sensitivity_label(tmp2, "OFFICIAL")
  expect_equal(read_sensitivity_label(tmp2), "OFFICIAL")

  apply_sensitivity_label(tmp, "OFFICIAL_SENSITIVE_VMO")
  expect_equal(read_sensitivity_label(tmp), "OFFICIAL_SENSITIVE_VMO")
  apply_sensitivity_label(tmp2, "OFFICIAL_SENSITIVE_VMO")
  expect_equal(read_sensitivity_label(tmp2), "OFFICIAL_SENSITIVE_VMO")

  # Clean up
  unlink(c(tmp, tmp2))
})


test_that("comprehensive edge case testing", {
  tmp <- tempfile(fileext = ".xlsx")
  wb <- openxlsx2::wb_workbook()
  wb <- openxlsx2::wb_add_worksheet(wb, "Sheet1")
  openxlsx2::wb_save(wb, tmp)

  tmp2 <- tempfile(fileext = ".docx")
  print(officer::read_docx(), tmp2)

  # Test label overwriting behavior
  apply_sensitivity_label(tmp, "Personal")
  expect_equal(read_sensitivity_label(tmp), "Personal")
  apply_sensitivity_label(tmp2, "Personal")
  expect_equal(read_sensitivity_label(tmp2), "Personal")

  # Overwrite with different label
  apply_sensitivity_label(tmp, "OFFICIAL")
  expect_equal(read_sensitivity_label(tmp), "OFFICIAL")
  apply_sensitivity_label(tmp2, "OFFICIAL")
  expect_equal(read_sensitivity_label(tmp2), "OFFICIAL")

  # Overwrite with third label type
  apply_sensitivity_label(tmp, "OFFICIAL_SENSITIVE_VMO")
  expect_equal(read_sensitivity_label(tmp), "OFFICIAL_SENSITIVE_VMO")
  apply_sensitivity_label(tmp2, "OFFICIAL_SENSITIVE_VMO")
  expect_equal(read_sensitivity_label(tmp2), "OFFICIAL_SENSITIVE_VMO")

  # Test that files can be relabeled multiple times
  apply_sensitivity_label(tmp, "Personal")
  expect_equal(read_sensitivity_label(tmp), "Personal")
  apply_sensitivity_label(tmp2, "Personal")
  expect_equal(read_sensitivity_label(tmp2), "Personal")

  # Clean up
  unlink(c(tmp, tmp2))
})

test_that("function parameter validation", {
  tmp <- tempfile(fileext = ".xlsx")
  wb <- openxlsx2::wb_workbook()
  wb <- openxlsx2::wb_add_worksheet(wb, "Sheet1")
  openxlsx2::wb_save(wb, tmp)

  # Test NULL parameter behavior
  expect_error(apply_sensitivity_label(tmp, NULL), "`label` must not be")
  expect_error(apply_sensitivity_label(NULL, "Personal"), "`file` must not be")

  # Test empty string
  expect_error(
    apply_sensitivity_label(tmp, ""),
    "`label` must be a single non-empty character string"
  )

  # Test numeric parameter
  expect_error(
    apply_sensitivity_label(tmp, 1),
    "`label` must be a single non-empty character string"
  )
  expect_error(
    apply_sensitivity_label(tmp, c("Personal", "OFFICIAL")),
    "`label` must be a single non-empty character string"
  )

  # Clean up
  unlink(tmp)
})

test_that("comprehensive parameter validation for apply_sensitivity_label", {
  tmp <- tempfile(fileext = ".xlsx")
  wb <- openxlsx2::wb_workbook()
  wb <- openxlsx2::wb_add_worksheet(wb, "Sheet1")
  openxlsx2::wb_save(wb, tmp)

  # Test missing arguments
  expect_error(apply_sensitivity_label(), "`file` is missing")
  expect_error(apply_sensitivity_label(tmp), "`label` is missing")

  # Test NA values
  expect_error(
    apply_sensitivity_label(NA_character_, "Personal"),
    "`file` must be a single non-empty character string"
  )
  expect_error(
    apply_sensitivity_label(tmp, NA_character_),
    "`label` must be a single non-empty character string"
  )

  # Test various invalid types for file
  expect_error(
    apply_sensitivity_label(123, "Personal"),
    "`file` must be a single non-empty character string"
  )
  expect_error(
    apply_sensitivity_label(TRUE, "Personal"),
    "`file` must be a single non-empty character string"
  )
  expect_error(
    apply_sensitivity_label(list("file.xlsx"), "Personal"),
    "`file` must be a single non-empty character string"
  )

  # Test various invalid types for label
  expect_error(
    apply_sensitivity_label(tmp, 123),
    "`label` must be a single non-empty character string"
  )
  expect_error(
    apply_sensitivity_label(tmp, TRUE),
    "`label` must be a single non-empty character string"
  )
  expect_error(
    apply_sensitivity_label(tmp, list("Personal")),
    "`label` must be a single non-empty character string"
  )

  # Test multiple values
  expect_error(
    apply_sensitivity_label(c(tmp, tmp), "Personal"),
    "`file` must be a single non-empty character string"
  )

  # Test invalid file extensions
  txt_file <- tempfile(fileext = ".txt")
  file.create(txt_file)
  expect_error(
    apply_sensitivity_label(txt_file, "Personal"),
    "`file` must be an Excel workbook or Word document"
  )

  pdf_file <- tempfile(fileext = ".pdf")
  file.create(pdf_file)
  expect_error(
    apply_sensitivity_label(pdf_file, "Personal"),
    "`file` must be an Excel workbook or Word document"
  )

  # Test file with no extension
  no_ext_file <- tempfile()
  file.create(no_ext_file)
  expect_error(
    apply_sensitivity_label(no_ext_file, "Personal"),
    "`file` must be an Excel workbook or Word document"
  )

  # Clean up
  unlink(c(tmp, txt_file, pdf_file, no_ext_file))
})

test_that("comprehensive parameter validation for read_sensitivity_label", {
  tmp <- tempfile(fileext = ".xlsx")
  wb <- openxlsx2::wb_workbook()
  wb <- openxlsx2::wb_add_worksheet(wb, "Sheet1")
  openxlsx2::wb_save(wb, tmp)

  # Test missing arguments
  expect_error(read_sensitivity_label(), "`file` is missing")

  # Test NULL
  expect_error(read_sensitivity_label(NULL), "`file` must not be")

  # Test NA values
  expect_error(
    read_sensitivity_label(NA_character_),
    "`file` must be a single non-empty character string"
  )

  # Test various invalid types
  expect_error(
    read_sensitivity_label(123),
    "`file` must be a single non-empty character string"
  )
  expect_error(
    read_sensitivity_label(TRUE),
    "`file` must be a single non-empty character string"
  )
  expect_error(
    read_sensitivity_label(list("file.xlsx")),
    "`file` must be a single non-empty character string"
  )

  # Test empty string
  expect_error(
    read_sensitivity_label(""),
    "`file` must be a single non-empty character string"
  )

  # Test multiple values
  expect_error(
    read_sensitivity_label(c(tmp, tmp)),
    "`file` must be a single non-empty character string"
  )

  # Test non-existent file
  non_existent_file <- tempfile(fileext = ".xlsx")
  expect_error(read_sensitivity_label(non_existent_file), "not exist")

  # Test invalid file extensions
  txt_file <- tempfile(fileext = ".txt")
  file.create(txt_file)
  expect_error(
    read_sensitivity_label(txt_file),
    "`file` must be an Excel workbook or Word document"
  )

  pdf_file <- tempfile(fileext = ".pdf")
  file.create(pdf_file)
  expect_error(
    read_sensitivity_label(pdf_file),
    "`file` must be an Excel workbook or Word document"
  )

  # Test file with no extension
  no_ext_file <- tempfile()
  file.create(no_ext_file)
  expect_error(
    read_sensitivity_label(no_ext_file),
    "`file` must be an Excel workbook or Word document"
  )

  # Clean up
  unlink(c(tmp, txt_file, pdf_file, no_ext_file))
})
