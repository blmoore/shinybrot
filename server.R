
library(ggplot2)
library(shiny)

# devtools::install_github("blmoore/mandelbrot")
library(mandelbrot) 

# pre-generated palettes, select these by index
palettes <- list(
  Vaccine = c(
    colorRampPalette(c("#e7f0fa", "#c9e2f6", "#95cbee",
      "#0099dc", "#4ab04a", "#ffd73e"))(10),
    colorRampPalette(c("#eec73a", "#e29421", "#e29421", 
      "#f05336","#ce472e"), bias=2)(90), 
    "black"),
  Spectral = mandelbrot_palette(RColorBrewer::brewer.pal(11, "Spectral")),
  Greyscale = mandelbrot_palette(grey.colors(50)),
  Heat =  mandelbrot_palette(rev(RColorBrewer::brewer.pal(11, "RdYlBu"))),
  Ice = mandelbrot_palette(RColorBrewer::brewer.pal(9, "Blues"), in_set = "white"),
  Lava = c(
    grey.colors(12, start = .3, end = 1),
    colorRampPalette(RColorBrewer::brewer.pal(9, "YlOrRd"), bias=2)(90), 
    "black")
)

shinyServer(function(input, output, session) {
  
  limits <- reactiveValues(xlim = c(-2, 2), ylim = c(-2, 2))
  
  # only input$palette modifies cols
  cols <- reactiveValues(cols = palettes$Vaccine)
  
  # palette initial setup + feedback
  observe({
    
    if (!is.null(input$palette)) {
      cols$cols <- palettes[[input$palette]]
    } else {
      updateRadioButtons(session, "palette",
        selected = names(palettes)[1]
      )
    }
    
  })
  
  # parse URI to view settings
  observe({
    
    query <- parseQueryString(session$clientData$url_search)
    
    if ('x' %in% names(query) & 'y' %in% names(query)) {
      limits$xlim <- as.numeric(unlist(strsplit(query$x, ",")))
      limits$ylim <- as.numeric(unlist(strsplit(query$y, ",")))
    }
    
    if ('pal' %in% names(query)) {
      updateRadioButtons(session, "palette",
        selected = names(palettes)[as.numeric(query$pal)]
      )
    }
      
  })
  
  # generate specific URI for this view
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
    
    if (!is.null(input$palette)) {
      if (input$palette != "Vaccine") {
        uri <- paste0(uri, '&pal=', which(names(palettes) == input$palette))
      }
    }
    
    tags$a(href = uri,
      "Direct link to this view")

  })
  
  # draw set with current config
  output$mandelbrot <- renderPlot({

    df <- mandelbrot0(
      iterations = input$iter,
      resolution = input$res,
      xlim = limits$xlim,
      ylim = limits$ylim
    )

    ggplot(df, aes(x = x, y = y, fill = value)) +
        geom_raster(interpolate = TRUE) + theme_void() +
        scale_fill_gradientn(colours = cols$cols, guide = "none") +
        coord_equal() + scale_y_continuous(expand = c(0,0)) +
        scale_x_continuous(expand = c(0,0))
    
  })
  
  # zooming implementation
  observe({
    brush <- input$zoom_brush
    
    if (!is.null(brush)) {
      print(brush$xmin)
      limits$xlim <- c(brush$xmin, brush$xmax)
      limits$ylim <- c(brush$ymin, brush$ymax)
    }
    
  })
  
})
