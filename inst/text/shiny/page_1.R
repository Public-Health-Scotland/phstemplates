####################### Page 1 #######################

output$page_1_ui <-  renderUI({

  div(
	     fluidRow(
            h3("This is a header"),
	           p("This is some text"),
	           p(strong("This is some bold text"))

	      ) #fluidrow
   ) # div
}) # renderUI


# Data table example
output$test_data_table <- DT::renderDataTable({
  make_table(datasets::mtcars, rows_to_display = 10)
})

# Plotly plot example
output$test_plot <- renderPlotly({
  mtcars_plot(datasets::mtcars)
})
