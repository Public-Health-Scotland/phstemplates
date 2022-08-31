####################### Page 1 functions #######################


mtcars_plot <- function(dataset){
  
  dataset$name <- row.names(dataset)
  
  yaxis_plots[["title"]] <- "Displacement (cu.in.)"
  xaxis_plots[["title"]] <- "Gross horsepower"
  
  p <- dataset %>%
    plot_ly(
      x = ~hp,
      y = ~disp,
      color = ~factor(cyl),
      text = ~name,
      type = "scatter",
      mode = "markers",
      # PHS palette (paste removes names from named list)
      colors = paste(phsstyles::phs_palettes$main)
    ) %>%  
    layout(margin = list(b = 30, t = 10), # to avoid labels getting cut out
           legend = list(x = 100, y = 0.5, title=list(text='Number of cylinders')),
           yaxis = yaxis_plots, xaxis = xaxis_plots) %>% 
    # leaving only save plot button
    config(displaylogo = F, displayModeBar = TRUE, modeBarButtonsToRemove = bttn_remove )
  
  return(p)

}
