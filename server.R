
library(ggplot2)
library(shiny)

# devtools::install_github("blmoore/mandelbrot")
library(mandelbrot) 

vaccine_pal <- c(
  colorRampPalette(c("#e7f0fa", "#c9e2f6", "#95cbee",
    "#0099dc", "#4ab04a", "#ffd73e"))(10),
  colorRampPalette(c("#eec73a", "#e29421", "#e29421", 
    "#f05336","#ce472e"), bias=2)(90), 
  "black")

df <- mandelbrot0()

shinyServer(function(input, output, session) {
  
  limits <- reactiveValues(xlim = c(-2, 2), ylim = c(-2, 2))
  #transform <- reactiveValues(method = "none")
  cols <- reactiveValues(cols = vaccine_pal)
  
  observe({
    query <- parseQueryString(session$clientData$url_search)
    if ('x' %in% names(query) & 'y' %in% names(query)) {
      limits$xlim <- as.numeric(unlist(strsplit(query$x, ",")))
      limits$ylim <- as.numeric(unlist(strsplit(query$y, ",")))
    }
  })
  
  output$qurl <- renderUI({
    
    uri <- paste0(
      session$clientData$url_protocol, "//",
      session$clientData$url_hostname,
      session$clientData$url_pathname,
      "?x=",
      paste(limits$xlim, collapse = ","),
      "&y=", 
      paste(limits$ylim, collapse = ",")
    )
    
    tags$a(href = uri,
      "Direct link to this view")

  })
  
  output$mandelbrot <- renderPlot({
    
    if (!is.null(limits$xlim)) {
      df <- mandelbrot0(
        iterations = input$iter,
        resolution = input$res,
        xlim = limits$xlim,
        ylim = limits$ylim
      )
    } else {
      df <- mandelbrot0(
        iterations = input$iter,
        resolution = input$res
      )
    }
    
    # if (transform$method == "log") {
    #   df$value <- log(df$value)
    # } 
    # 
    # if (transform$method == "inv") {
    #   df$value <- 1/df$value
    # }
    
    ggplot(df, aes(x = x, y = y, fill = value)) +
      geom_raster(interpolate = TRUE) + theme_void() +
      scale_fill_gradientn(colours = cols$cols, guide = "none") +
      coord_equal() + scale_y_continuous(expand = c(0,0)) +
      scale_x_continuous(expand = c(0,0))
    
  })
  
  observe({
    brush <- input$zoom_brush
    
    if (!is.null(brush)) {
      limits$xlim <- c(brush$xmin, brush$xmax)
      limits$ylim <- c(brush$ymin, brush$ymax)
    }
    
  })
  
  # observe({
  #   transform$method <- input$trans
  # })
  
  observe({
    pal <- input$palette
    
    if (pal == "Spectral") {
      cols$cols <- mandelbrot_palette(RColorBrewer::brewer.pal(11, "Spectral"))
    } 
    
    if (pal == "Vaccine") {
      cols$cols <- vaccine_pal
    }
    
    if (pal == "Greyscale") {
      cols$cols <- mandelbrot_palette(grey.colors(50))
    }
    
    if (pal == "Heat") {
      cols$cols <- mandelbrot_palette(rev(RColorBrewer::brewer.pal(11, "RdYlBu")))
    }
    
    if (pal == "Ice") {
      cols$cols <- mandelbrot_palette(RColorBrewer::brewer.pal(9, "Blues"), in_set = "white")
    }
    
  })
  
})
