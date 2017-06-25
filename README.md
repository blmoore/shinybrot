# shinybrot
Simple shiny app for exploring the Mandelbrot set. 

Views are calculated using the R package [`mandelbrot`](https://github.com/blmoore/mandelbrot) and 
drawn with `ggplot2`.

## Run locally

```r
shiny::runGitHub("blmoore/shinybrot")
```

## Bugs

* Zoom in far enough and you'll find grid lines!
