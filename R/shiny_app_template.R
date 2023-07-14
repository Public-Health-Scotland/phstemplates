shiny_app_template <- function(app_name="WRITE APP NAME HERE",
                               author = Sys.info()[['user']]) {

    author <- paste("# Original author(s):", author)
    orig_date <- paste('# Original date:', Sys.Date())
    run_on <- paste0('# Written/run on RStudio ' ,
                     rstudioapi::versionInfo()$mode, ' ',
                     rstudioapi::versionInfo()$version, ' and R ',
                     version$major, '.', version$minor)

    r_code <- c(
      '##########################################################',
      paste0('# ', app_name),
      author,
      orig_date,
      run_on,
      '# Description of content',
      '##########################################################',
      '',
      '',
      '# Get packages',
      'source("setup.R")',
      '',
      '# UI',
      'ui <- fluidPage(',
      'tagList(',
      '# Specify most recent fontawesome library - change version as needed',
      'tags$style("@import url(https://use.fontawesome.com/releases/v6.1.2/css/all.css);"),',
      'navbarPage(',
      '    id = "intabset", # id used for jumping between tabs',
      '    title = div(',
      '        tags$a(img(src = "phs-logo.png", height = 40),',
      '               href = "https://www.publichealthscotland.scot/",',
      '               target = "_blank"), # PHS logo links to PHS website',
      '    style = "position: relative; top: -5px;"),',
      paste0('    windowTitle = ', '"', app_name,  '"',  ",", '# Title for browser tab'),
      '    header = tags$head(includeCSS("www/styles.css"),  # CSS stylesheet',
      '    tags$link(rel = "shortcut icon", href = "favicon_phs.ico") # Icon for browser tab',
      '),'
    )

  r_code <- paste(r_code, collapse = '\n')

  return(r_code)
}
