#' Attempt to pick up a default name for user
#'
#' Tries to find a name from Git details. Otherwise takes the username from the system information.
#'
#' @noRd
get_name <- function() {
  ifelse(!is.null(git2r::config()$global$user.name),
    git2r::config()$global$user.name, Sys.info()[["user"]]
  )
}
