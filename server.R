
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(ggplot2)
library(shiny)
library(mandelbrot)

cols <- c(
  colorRampPalette(c("#e7f0fa", "#c9e2f6", "#95cbee",
    "#0099dc", "#4ab04a", "#ffd73e"))(10),
  colorRampPalette(c("#eec73a", "#e29421", "#e29421", 
    "#f05336","#ce472e"), bias=2)(90), 
  "black")

shinyServer(function(input, output) {

  limits <- reactiveValues(xlim = NULL, ylim = NULL)
  
  cols <- reactiveValues(cols = cols)
  
  output$mandelbrot <- renderPlot({
    
    if (!is.null(limits$xlim)) {
      df <- as.data.frame(
        mandelbrot(
          iterations = input$iter,
          resolution = input$res,
          xlim = limits$xlim,
          ylim = limits$ylim
        )
      )
    } else {
      df <- as.data.frame(
        mandelbrot(
          iterations = input$iter,
          resolution = input$res
        )
      )
    }
    
    ggplot(df, aes(x = x, y = y, fill = value)) +
      geom_raster(interpolate = TRUE) + theme_void() +
      scale_fill_gradientn(colours = cols$cols, guide = "none") +
      coord_equal()

  })
  
  observe({
    brush <- input$zoom_brush
    
    if (!is.null(brush)) {
      limits$xlim <- c(brush$xmin, brush$xmax)
      limits$ylim <- c(brush$ymin, brush$ymax)
    }
    
  })
  
  observe({
    pal <- input$palette
    
    if (pal == "Spectral") {
      cols$cols <- mandelbrot_palette(RColorBrewer::brewer.pal(11, "Spectral"))
    } 
    
    if (pal == "Vaccine") {
      cols$cols <- c(
        colorRampPalette(c("#e7f0fa", "#c9e2f6", "#95cbee",
          "#0099dc", "#4ab04a", "#ffd73e"))(10),
        colorRampPalette(c("#eec73a", "#e29421", "#e29421", 
          "#f05336","#ce472e"), bias=2)(90), 
        "black")
    }
    
    if (pal == "Greyscale") {
      cols$cols <- mandelbrot_palette(grey.colors(50))
    }
    
    if (pal == "Heat") {
      cols$cols <- mandelbrot_palette(heat.colors(50))
    }
    
    if (pal == "Ice") {
      cols$cols <- mandelbrot_palette(RColorBrewer::brewer.pal(9, "Blues"), in_set = "white")
    }

  })

})
