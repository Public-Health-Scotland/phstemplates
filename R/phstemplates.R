#' \code{phstemplates} package
#'
#' Standard Templates for use in PHS.
#'
#' See the README on
#' \href{https://github.com/Public-Health-Scotland/phstemplates#readme}{GitHub}.
#'
#' @docType package
#' @name phstemplates
NULL

# Stops notes from appearing in R CMD check because of undefined global
# variable '.' and allows area_lookup dataset to be used inside match_area
# function
if(getRversion() >= "2.15.1") utils::globalVariables(c("RStudio.Version"))
