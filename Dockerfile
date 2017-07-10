FROM rocker/shiny:latest
MAINTAINER Ben Moore "ben@blm.io"

COPY . /srv/shiny-server/.

RUN Rscript -e "install.packages( \
    c('shiny', \
      'mandelbrot', \
      'ggplot2'), clean=T, quiet=T)"

EXPOSE 3838

ENTRYPOINT ["/usr/bin/shiny-server.sh"]