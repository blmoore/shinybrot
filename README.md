# shinybrot
[![docker automated](https://img.shields.io/docker/automated/blmoore/shinybrot.svg)](https://hub.docker.com/r/blmoore/shinybrot/)

Simple shiny app for exploring the Mandelbrot set. See [this blog post](https://benjaminlmoore.wordpress.com/2017/06/27/the-mandelbrot-set-in-r/) for some discussion and pretty pictures.

Views are calculated using the R package [`mandelbrot`](https://github.com/blmoore/mandelbrot) and drawn with `ggplot2`.

## Explore

View the app online: [blmr.shinyapps.io/shinybrot](https://blmr.shinyapps.io/shinybrot/)

Use the `direct link` to zoom to specific views + settings, e.g.:

* ['Seahorse Valley'](https://blmr.shinyapps.io/shinybrot/?x=-0.78436438388539,-0.78436354957962&y=0.14199444381059,0.14199466062381&pal=5&res=700&iter=650)
* [Cardoid bulb](https://blmr.shinyapps.io/shinybrot/?x=-1.2937405038411,-1.2935898086106&y=0.085710440779261,0.085846441699619&pal=6&res=1000&iter=350)

## Run locally

Run within an R session with:

```r
shiny::runGitHub("blmoore/shinybrot")
```

### Docker

Alternatively, run using the [docker automated build](https://hub.docker.com/r/blmoore/shinybrot/) from the Dockerfile in this repository:

```sh
docker run -dp 3838:3838 blmoore/shinybrot
```

Then view at [localhost:3838](http://localhost:3838).

## Bugs

* Zoom in far enough and you'll find grid lines!
