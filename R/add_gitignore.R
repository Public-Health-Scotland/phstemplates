add_gitignore <- function() {

  project_directory <- rstudioapi::selectDirectory(caption="Select folder to add .gitignore")

  if(is.null(project_directory)){
    return(message(".gitignore file not added. Please set correct directory and try again."))
  }

    # gitignore content to add
    gitignore <- c(
      ".Rproj.user",
      ".Rhistory",
      ".RData",
      ".Ruserdata",
      "",
      "# 'data' folder #",
      "data/",
      "",
      "# Common text files that may contain data #",
      "*.[cC][sS][vV]",
      "*.[tT][xX][tT]",
      "",
      "# Excel files #",
      "*.[xX][lL][sS]*",
      "",
      "# SPSS formats #",
      "*.[sS][aA][vV]",
      "*.[zZ][sS][aA][vV]",
      "",
      "# R data files #",
      "*.[rR][dD][aA][tT][aA]",
      "*.[rR][dD][sS]",
      "",
      "# MacOS folder attributes files #",
      ".DS_Store"
    )

    # collect into single text string
    gitignore <- paste(gitignore, collapse = "\n")

    # Search for existing gitignore in path
    if(file.exists(paste0(project_directory, ".gitignore"))){
      append <- rstudioapi::showQuestion(title = "Append to existing .gitignore?",
                                      message = "You already have a .gitignore file. Should I append the PHS gitignore or overwrite?",
                                      "Append", "Overwrite")
      if(is.null(append)){
        return(message(".gitignore file not added. Please set correct directory and try again."))
      }
    }

    opencon <- ifelse(append, "a", "w")

    filecon <- file(paste0(project_directory, "/.gitignore"), open=opencon)
    writeLines(gitignore, con = filecon)
    close(filecon)

}
