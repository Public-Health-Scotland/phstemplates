#' Convert to a PHS report in MS Word document format
#'
#' Format for converting from R Markdown to a PHS report in MS Word document format.
#' This is an extension of the \code{word_document} format that adds post-processing
#' to include the front cover and table of contents for the report.
#'
#' See the \href{https://bookdown.org/yihui/rmarkdown/word-document.html}{online
#' documentation} for additional details on using the \code{word_document} format.
#'
#' R Markdown documents can have optional metadata that is used to generate a
#' document header that includes the title, author, and date. For more details
#' see the documentation on R Markdown \link[=rmd_metadata]{metadata}.
#'
#' R Markdown documents also support citations. You can find more information on
#' the markdown syntax for citations in the
#' \href{https://pandoc.org/MANUAL.html#citations}{Bibliographies
#' and Citations} article in the online documentation.
#' @inheritParams rmarkdown::pdf_document
#' @inheritParams rmarkdown::html_document
#' @param reference_docx Use the specified file as a style reference in
#'   producing a docx file. For best results, the reference docx should be a
#'   modified version of a docx file produced using pandoc. Pass "default"
#'   to use the rmarkdown default styles.
#' @param cover_page Cover page document file name.
#' @param cover_title Title to be used in the cover page.
#' @param cover_subtitle Subtitle to be used in the cover page.
#' @param cover_date Date to be used in the cover page.
#' @return R Markdown output format to pass to \code{\link{render}}
#' @examples
#' \dontrun{
#' library(rmarkdown)
#' library(phstemplates)
#' render("input.Rmd", phs_report_docx())
#' }
#' @export
phs_report_docx <- function(toc = FALSE,
                            toc_depth = 3,
                            number_sections = FALSE,
                            fig_width = 5,
                            fig_height = 4,
                            fig_caption = TRUE,
                            df_print = "default",
                            highlight = "default",
                            reference_docx = "default",
                            keep_md = FALSE,
                            md_extensions = NULL,
                            pandoc_args = NULL,
                            cover_page = NULL,
                            cover_title = "Title",
                            cover_subtitle = "Subtitle",
                            cover_date = "DD Month YYYY") {

  resolve_highlight <- utils::getFromNamespace("resolve_highlight", "rmarkdown")
  highlighters <- utils::getFromNamespace("highlighters", "rmarkdown")
  reference_intermediates_generator <- utils::getFromNamespace("reference_intermediates_generator", "rmarkdown")

  # knitr options and hooks
  knitr <- rmarkdown::knitr_options(
    opts_chunk = list(dev = "png",
                      dpi = 96,
                      fig.width = fig_width,
                      fig.height = fig_height)
  )

  # base pandoc options for all docx output
  args <- c()

  # table of contents
  args <- c(args, rmarkdown::pandoc_toc_args(toc, toc_depth))

  # Lua filters (added if pandoc > 2)
  lua_filters <- rmarkdown::pkg_file_lua("pagebreak.lua")

  # numbered sections
  if (number_sections) {
    if (rmarkdown::pandoc_available("2.10.1")) {
      args <- c(args, "--number-sections")
    } else {
      lua_filters <- c(lua_filters, rmarkdown::pkg_file_lua("number-sections.lua"))
    }
  }

  # highlighting
  if (!is.null(highlight)) highlight <- resolve_highlight(highlight, highlighters())
  args <- c(args, rmarkdown::pandoc_highlight_args(highlight))

  # reference docx
  args <- c(args, reference_doc_args("docx", reference_docx))

  # pandoc args
  args <- c(args, pandoc_args)

  saved_files_dir <- NULL
  pre_processor <- function(metadata, input_file, runtime, knit_meta, files_dir, output_dir) {
    saved_files_dir <<- files_dir
    NULL
  }

  intermediates_generator <- function(...) {
    reference_intermediates_generator(saved_files_dir, ..., reference_docx)
  }

  post_processor <- function(metadata, input_file, output_file, clean, verbose,
                             cover = cover_page, title = cover_title,
                             stitle = cover_subtitle, dt = cover_date,
                             tocd = toc_depth) {

    officer::read_docx(output_file) %>%
      officer::cursor_reach(keyword = "Introduction") %>%
      officer::body_add_toc(pos = "before", level = tocd) %>%
      officer::body_add_par("Contents", pos = "before", style = "TOC Heading") %>%
      officer::cursor_reach(keyword = "Introduction") %>%
      officer::body_add_break(pos = "before") %>%
      print(output_file)

    # Cover Page
    cover_page <- officer::read_docx(cover) %>%
      officer::body_replace_all_text("Title", title) %>%
      officer::body_replace_all_text("Subtitle", stitle) %>%
      officer::body_replace_all_text("DD Month YYYY", dt)

    # Combine Cover and Report
    cover_page %>%
      officer::cursor_end() %>%
      officer::body_remove() %>%
      officer::body_add_break() %>%
      officer::body_add_docx(output_file) %>%
      officer::set_doc_properties(title = title) %>%
      print(output_file)
  }

  # return output format
  rmarkdown::output_format(
    knitr = knitr,
    pandoc = rmarkdown::pandoc_options(
      to = "docx",
      from = rmarkdown::from_rmarkdown(fig_caption, md_extensions),
      args = args,
      lua_filters = lua_filters
    ),
    keep_md = keep_md,
    df_print = df_print,
    pre_processor = pre_processor,
    intermediates_generator = intermediates_generator,
    post_processor = post_processor
  )
}

reference_doc_args <- function(type, doc) {
  if (is.null(doc) || identical(doc, "default")) return()
  c(paste0("--reference-", if (rmarkdown::pandoc_available("2.0")) "doc" else {
    match.arg(type, c("docx", "odt", "doc"))
  }), rmarkdown::pandoc_path_arg(doc))
}
