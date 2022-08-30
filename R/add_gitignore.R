#' add_gitignore
#' @description Add PHS template .gitignore file to chosen directory.
#'
#' @param path String: path to add .gitignore file. If left blank, will prompt the user within R Studio
#' @param append Logical: if a .gitignore already exists, whether to append contents (TRUE) or overwrite (FALSE).
#' If left blank will prompt the user within R Studio.
#'
#' @return Adds .gitignore file to directory, or appends content to existing file.
#' @export
#' @examples
#' \dontrun{
#' add_gitignore()
#' }
add_gitignore <- function(path=rstudioapi::selectDirectory(caption="Select folder to add .gitignore"),
                          append=NULL) {

  if(is.null(path)){
    return(message(".gitignore file not added."))
  }

  # gitignore content to add
  gitignore <- readLines(system.file(package="phstemplates", "text", ".gitignore"))

  # collect into single text string
  gitignore <- paste(gitignore, collapse = "\n")

  # Search for existing gitignore in path
  if(file.exists(paste0(path, "/.gitignore"))){
    # If append not set by user, prompt for whether to append
    if(is.null(append)){
      append <- rstudioapi::showQuestion(title = "Append to existing .gitignore?",
                                         message = "You already have a .gitignore file. Should I append the PHS gitignore or overwrite?",
                                         "Append", "Overwrite")
    }
    # If user has still not set whether to append, don't add .gitignore
    if(is.null(append)){
      return(message(".gitignore file not added."))
    }
  } else {
    append <- FALSE
  }

  opencon <- ifelse(append, "a", "w")

  filecon <- file(paste0(path, "/.gitignore"), open=opencon)
  writeLines(gitignore, con = filecon)
  close(filecon)

}
