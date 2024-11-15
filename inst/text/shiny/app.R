##############################################.
# INTRO PAGE ----
##############################################.
tabPanel(title = "Introduction",
    icon = icon_no_warning_fn("circle-info"),
    value = "intro",

    h1("Welcome to the dashboard"),
    uiOutput("intro_page_ui")

), # tabpanel
##############################################.
# PAGE 1 ----
##############################################.
tabPanel(title = "Page 1",
    # Look at https://fontawesome.com/search?m=free for icons
    icon = icon_no_warning_fn("stethoscope"),
    value = "page1",

    h1("Page 1 title"),
    uiOutput("page_1_ui"),
    linebreaks(2),
    h2("An example plot using mtcars data"),
    plotlyOutput("test_plot"),
    linebreaks(2),
    h2("An example data table using mtcars data"),
    DT::dataTableOutput("test_data_table"),
    linebreaks(2)

    ), # tabpanel
##############################################.
# CONTACT PAGE ----
##############################################.
tabPanel(title = "Contact",
    icon = icon_no_warning_fn("envelope"),
    value = "contact",

    h1("Contact us"),
    uiOutput("contact_page_ui")

    ) # tabpanel
    ) # navbar
  ) # taglist
) # ui fluidpage

# ----------------------------------------------
# Server

server <- function(input, output, session) {

    # Get functions
    source(file.path("functions/core_functions.R"), local = TRUE)$value
    source(file.path("functions/intro_page_functions.R"), local = TRUE)$value
    source(file.path("functions/page_1_functions.R"), local = TRUE)$value

    # Get content for individual pages
    source(file.path("pages/intro_page.R"), local = TRUE)$value
    source(file.path("pages/page_1.R"), local = TRUE)$value
    source(file.path("pages/contact_page.R"), local = TRUE)$value

}

# Run the application
shinyApp(ui = ui, server = server)

### END OF SCRIPT ###
