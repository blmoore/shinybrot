
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(navbarPage("Mandelbrot", id="nav", collapsible=T,
  tabPanel("View",
    div(class = "outer",
      tags$head(
        includeCSS("www/styles.css")
      ),
      
      plotOutput("mandelbrot", height = "800px", width = "1000px",
        brush = brushOpts(id = "zoom_brush", resetOnNew = TRUE, delay = 600)),
      
      absolutePanel(
        id = "controls", class = "panel panel-default", fixed = TRUE,
        draggable = TRUE, top = 100, left = 20, right = "auto", bottom = "auto",
        width = 400, height = "auto",
        
        # panel content
        h2("Controls"),
        
        sliderInput("iter",
          "Iterations:",
          min = 100,
          max = 1000,
          value = 300,
          step = 50,
          width = "98%"),
        
        sliderInput("res",
          "Resolution:",
          min = 100,
          max = 2000,
          value = 500,
          step = 100,
          width = "98%"),
        
        radioButtons("palette",
          "Colours:",
          choices = c("Vaccine", "Spectral", "Greyscale", "Heat", "Ice"),
          width = "98%",
          inline = TRUE)
        
      )
    )
  )
))
