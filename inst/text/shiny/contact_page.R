####################### Contact Page #######################

output$contact_page_ui <- renderUI({
  div(
    fluidRow(
      p(
        "If you have any questions or feedback regarding this dashboard or any information contained within it, please email:"
      ),
      a("PHS.myteam@phs.scot", href = "mailto:PHS.myteam@phs.scot")
    ) #fluidrow
  ) # div
}) # renderUI
