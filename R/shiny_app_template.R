shiny_app_template <- function(file_to_get, app_name="WRITE APP NAME HERE",
                               author = Sys.info()[['user']]) {


  if (file_to_get == "app.R"){

    author <- paste("# Original author(s):", author)
    orig_date <- paste('# Original date:', Sys.Date())
    run_on <- paste0('# Written/run on RStudio ' , RStudio.Version()$mode, ' ',
                     RStudio.Version()$version, ' and R ',
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
      '),',
      '##############################################.',
      '# INTRO PAGE ----',
      '##############################################.',
      'tabPanel(title = "Introduction",',
      '    icon = icon_no_warning_fn("circle-info"),',
      '    value = "intro",',
      '',
      '    h1("Welcome to the dashboard"),',
      '    uiOutput("intro_page_ui")',
      '',
      '), # tabpanel',
      '##############################################.',
      '# PAGE 1 ----',
      '##############################################.',
      'tabPanel(title = "Page 1",',
      '    # Look at https://fontawesome.com/search?m=free for icons',
      '    icon = icon_no_warning_fn("stethoscope"),',
      '    value = "intro",',
      '',
      '    h1("Page 1 title"),',
      '    uiOutput("page_1_ui")',
      '',
      '    ) # tabpanel',
      '    ) # navbar',
      '  ) # taglist',
      ') # ui fluidpage',
      '',
      '# ----------------------------------------------',
      '# Server',
      '',
      'server <- function(input, output, session) {',
      '',
      '    # Get functions',
      '    source(file.path("functions/core_functions.R"), local = TRUE)$value',
      '    source(file.path("functions/intro_page_functions.R"), local = TRUE)$value',
      '    source(file.path("functions/page_1_functions.R"), local = TRUE)$value',
      '',
      '    # Get content for individual pages',
      '    source(file.path("pages/intro_page.R"), local = TRUE)$value',
      '    source(file.path("pages/page_1.R"), local = TRUE)$value',
      '',
      '}',
      '',
      '# Run the application',
      'shinyApp(ui=ui, server=server)',
      '',
      '### END OF SCRIPT ###'
    )

  } else if (file_to_get == "README.md"){

    r_code <- c(
      paste("#", app_name),
      "",
      "PHS shiny app template",
      "",
      "## Instructions for use",
      "",
      "* Run the app by opening app.R and clicking 'Run' in the top right hand corner",
      "* `setup.R` contains required packages and is where any data should be read in",
      "* `data` is a folder for storing data to be read in",
      "* `www` contains the app stylesheet and PHS icon images",
      "* `pages` should contain an R script for each tab in your app with the content of that tab. This needs to be linked back to the ui in app.R",
      "* `functions` contains R scripts with functions for the app",
      "",
      "## PHS shiny app examples",
      "",
      "* [COVID-19 dashboard](https://github.com/Public-Health-Scotland/COVID-19-Publication-Dashboard)",
      "* [COVID-19 wider impacts dashboard](https://github.com/Public-Health-Scotland/covid-wider-impacts/tree/master/shiny_app)",
      "* [ScotPHO profiles](https://github.com/Public-Health-Scotland/scotpho-profiles-tool)"
    )

  } else if (file_to_get == "setup.R"){

    r_code <- c(
      '####################### Setup #######################',
      '',
      '# Shiny packages',
      'library(shiny)',
      'library(shinycssloaders)',
      '',
      '# Data wrangling packages',
      'library(dplyr)',
      'library(magrittr)',
      '',
      '# Plotting packages',
      'library(plotly)',
      '',
      '# PHS styling packages',
      'library(phsstyles)',
      '',
      '# Load core functions',
      'source("functions/core_functions.R")',
      '',
      '# LOAD IN DATA HERE',
      '',
      ''
    )

  } else if (file_to_get == "core_functions.R"){

    r_code <- c(
      '####################### Core functions #######################',
      '',
      '# Add n linebreaks',
      'linebreaks <- function(n){HTML(strrep(br(), n))}',
      '',
      '# Remove warnings from icons ----',
      'icon_no_warning_fn = function(icon_name) {',
      '  icon(icon_name, verify_fa=FALSE)',
      '}'
    )

  } else if (file_to_get == "intro.R"){

    r_code <- c(
      '####################### Intro Page #######################',
      '',
      'output$intro_page_ui <-  renderUI({',
      '',
      '  div(',
      '	     fluidRow(',
      '            h3("This is a header"),',
      '	           p("This is some text"), ',
      '	           p(strong("This is some bold text"))',
      '	      ) #fluidrow',
      '   ) # div',
      '}) # renderUI'
    )

  } else if (file_to_get == "page_1.R"){

    r_code <- c(
      '####################### Page 1 #######################',
      '',
      'output$page_1_ui <-  renderUI({',
      '',
      '  div(',
      '	     fluidRow(',
      '            h3("This is a header"),',
      '	           p("This is some text"), ',
      '	           p(strong("This is some bold text"))',
      '	      ) #fluidrow',
      '   ) # div',
      '}) # renderUI'
    )

  } else {

    stop(paste("Invalid file", file_to_get, "requested from shiny_app_template.R"))

  }


  r_code <- paste(r_code, collapse = '\n')

  return(r_code)
}
