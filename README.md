# shinybrot
Simple shiny app for exploring the Mandelbrot set. 

Views are calculated using the R package [`mandelbrot`](https://github.com/blmoore/mandelbrot) and 
drawn with `ggplot2`.

## Explore

View the app online: [blmr.shinyapps.io/shinybrot](https://blmr.shinyapps.io/shinybrot/)

Use the `direct link` to zoom to specific views + settings, e.g.:

* ['Seahorse Valley'](https://blmr.shinyapps.io/shinybrot/?x=-0.78436438388539,-0.78436354957962&y=0.14199444381059,0.14199466062381&pal=5&res=700&iter=650)
* [Cardoid bulb](https://blmr.shinyapps.io/shinybrot/?x=-1.2937405038411,-1.2935898086106&y=0.085710440779261,0.085846441699619&pal=6&res=1000&iter=350)

## Run locally

```r
shiny::runGitHub("blmoore/shinybrot")
```

## Bugs

* Zoom in far enough and you'll find grid lines!
