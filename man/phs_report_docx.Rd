% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/phs_report_docx.R
\name{phs_report_docx}
\alias{phs_report_docx}
\title{Convert to a PHS report in MS Word document format}
\usage{
phs_report_docx(
  toc = FALSE,
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
  cover_date = "DD Month YYYY"
)
}
\arguments{
\item{toc}{\code{TRUE} to include a table of contents in the output}

\item{toc_depth}{Depth of headers to include in table of contents}

\item{number_sections}{\code{TRUE} to number section headings}

\item{fig_width}{Default width (in inches) for figures}

\item{fig_height}{Default height (in inches) for figures}

\item{fig_caption}{\code{TRUE} to render figures with captions}

\item{df_print}{Method to be used for printing data frames. Valid values
include "default", "kable", "tibble", and "paged". The "default" method
uses a corresponding S3 method of \code{print}, typically
\code{print.data.frame}. The "kable" method uses the
\code{\link[knitr:kable]{knitr::kable}} function. The "tibble" method uses
the \pkg{tibble} package to print a summary of the data frame. The "paged"
method creates a paginated HTML table (note that this method is only valid
for formats that produce HTML). In addition to the named methods you can
also pass an arbitrary function to be used for printing data frames. You
can disable the \code{df_print} behavior entirely by setting the option
\code{rmarkdown.df_print} to \code{FALSE}. See
\href{https://bookdown.org/yihui/rmarkdown/html-document.html#data-frame-printing}{Data
frame printing section} in bookdown book for examples.}

\item{highlight}{Syntax highlighting style passed to Pandoc.

 Supported built-in styles include "default", "tango", "pygments", "kate",
 "monochrome", "espresso", "zenburn", "haddock", and "breezedark".

  Two custom styles are also included, "arrow", an accessible color scheme,
  and "rstudio", which mimics the default IDE theme. Alternatively, supply a
  path to a \samp{.theme} file to use
  \href{https://pandoc.org/MANUAL.html#syntax-highlighting}{a custom Pandoc
  style}. Note that custom theme requires Pandoc 2.0+.

  Pass \code{NULL} to prevent syntax highlighting.}

\item{reference_docx}{Use the specified file as a style reference in
producing a docx file. For best results, the reference docx should be a
modified version of a docx file produced using pandoc. Pass "default"
to use the rmarkdown default styles.}

\item{keep_md}{Keep the markdown file generated by knitting.}

\item{md_extensions}{Markdown extensions to be added or removed from the
default definition of R Markdown. See the \code{\link[rmarkdown]{rmarkdown_format}} for
additional details.}

\item{pandoc_args}{Additional command line options to pass to pandoc}

\item{cover_page}{Cover page document file name.}

\item{cover_title}{Title to be used in the cover page.}

\item{cover_subtitle}{Subtitle to be used in the cover page.}

\item{cover_date}{Date to be used in the cover page.}
}
\value{
R Markdown output format to pass to \code{\link{render}}
}
\description{
Format for converting from R Markdown to a PHS report in MS Word document format.
This is an extension of the \code{word_document} format that adds post-processing
to include the front cover and table of contents for the report.
}
\details{
See the \href{https://bookdown.org/yihui/rmarkdown/word-document.html}{online
documentation} for additional details on using the \code{word_document} format.

R Markdown documents can have optional metadata that is used to generate a
document header that includes the title, author, and date. For more details
see the documentation on R Markdown \link[=rmd_metadata]{metadata}.

R Markdown documents also support citations. You can find more information on
the markdown syntax for citations in the
\href{https://pandoc.org/MANUAL.html#citations}{Bibliographies
and Citations} article in the online documentation.
}
\examples{
\dontrun{
library(rmarkdown)
library(phstemplates)
render("input.Rmd", phs_report_docx())
}
}
