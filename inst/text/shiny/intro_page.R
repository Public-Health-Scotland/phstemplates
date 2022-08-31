####################### Intro Page #######################

output$intro_page_ui <-  renderUI({

  div(
	     fluidRow(
            h3("This is a header"),
	           p("This is some text"), 
	           p(strong("This is some bold text"))
	      ) #fluidrow
   ) # div
}) # renderUI
