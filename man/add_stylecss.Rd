% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/add_stylecss.R
\name{add_stylecss}
\alias{add_stylecss}
\title{add_stylecss}
\usage{
add_stylecss(
  path = rstudioapi::selectDirectory(caption = "Select folder to add phs_style.css"),
  shinycss = FALSE,
  auto_open = TRUE
)
}
\arguments{
\item{path}{String: path to add phs_style.css file. If left blank, RStudio will prompt the user.}

\item{shinycss}{Logical: Whether to append shiny CSS code to the file (TRUE) or not (FALSE). If left blank, RStudio will prompt the user.}

\item{auto_open}{Logical: Automatically open the phs_style.css after it is compiled?}
}
\value{
NULL - Adds phs_style.css file to the directory.
}
\description{
Add PHS template phs_style.css file to chosen directory.
}
\examples{
\dontrun{
add_stylecss()
}
}
