
library(shiny)

shinyUI(
  
  fluidPage(
    
    tags$head(
      includeCSS("www/styles.css")
    ),
    
    
    fluidRow(
      column(
        width = 9,
        plotOutput("mandelbrot", height = "700px", width = "100%",
          brush = brushOpts(id = "zoom_brush", resetOnNew = TRUE, delay = 600))
      ),
      
      column(width = 3,
        titlePanel("Shinybrot"),
        wellPanel(
          
          p("A Mandelbrot set explorer written in R + shiny. ",
            "Under the hood it's using the ", 
            tags$a(href="https://github.com/blmoore/mandelbrot", "mandelbrot"),
            " R package and ggplot2."),
          
          tags$hr(),
          
          tags$label(
            class="control-label",
            "Link:"),
          uiOutput("qurl"),
          tags$br(),
          
          radioButtons("palette",
            "Colours:",
            choices = c("Vaccine", "Spectral", "Greyscale", "Heat", "Ice", "Lava"),
            width = "100%",
            selected = character(0),
            inline = TRUE),
          
          sliderInput("res",
            "Resolution:",
            min = 100,
            max = 2000,
            value = 500,
            step = 100),
          
          sliderInput("iter",
            "Iterations:",
            min = 100,
            max = 1000,
            value = 300,
            step = 50),
          
          tags$hr(),
          
          p(icon("github", class = NULL, lib = "font-awesome"),
            tags$a(href="https://github.com/blmoore/shinybrot",
              "blmoore/shinybrot"),
            tags$br(),
            icon("twitter", class = NULL, lib = "font-awesome"),
            tags$a(href="https://twitter.com/benjaminlmoore",
              "@benjaminlmoore")
          )
          
        )
      )
    )
    
  )
)
