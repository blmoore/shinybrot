
library(shiny)

shinyUI(
  
  fluidPage(
    titlePanel("R Mandelbrot set explorer"),
    
    tags$head(
      includeCSS("www/styles.css")
    ),
    
    plotOutput("mandelbrot", height = "700px", width = "100%",
      brush = brushOpts(id = "zoom_brush", resetOnNew = TRUE, delay = 600)),
    
    fluidRow(
      
      column(width = 3,
        wellPanel(
          sliderInput("iter",
            "Iterations:",
            min = 100,
            max = 1000,
            value = 300,
            step = 50,
            width = "100%")
        ))
      ,
      
      column(width = 6,  
        wellPanel(
          radioButtons("palette",
            "Colours:",
            choices = c("Vaccine", "Spectral", "Greyscale", "Heat", "Ice"),
            width = "100%",
            inline = TRUE)
          # radioButtons("trans",
          #   "Transform:",
          #   choices = list(None = "none", Log = "log", Inverse = "inv"),
          #   width = "100%",
          #   inline = TRUE)
        )
      ),
      
      column(width = 3,
        wellPanel(
          sliderInput("res",
            "Resolution:",
            min = 100,
            max = 2000,
            value = 500,
            step = 100,
            width = "100%")
        )
      )
      
    )
  )
)
