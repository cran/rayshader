% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/render_label.R
\name{render_label}
\alias{render_label}
\title{Render Label}
\usage{
render_label(
  heightmap,
  text,
  lat,
  long,
  altitude = NULL,
  extent = NULL,
  x = NULL,
  y = NULL,
  z = NULL,
  zscale = 1,
  relativez = TRUE,
  offset = 0,
  clear_previous = FALSE,
  textsize = 1,
  dashed = FALSE,
  dashlength = "auto",
  linewidth = 3,
  antialias = FALSE,
  alpha = 1,
  textalpha = 1,
  freetype = TRUE,
  adjustvec = NULL,
  family = "sans",
  fonttype = "standard",
  linecolor = "black",
  textcolor = "black"
)
}
\arguments{
\item{heightmap}{A two-dimensional matrix, where each entry in the matrix is the elevation at that point. All points are assumed to be evenly spaced.}

\item{text}{The label text.}

\item{lat}{A latitude for the text. Must provide an `raster::extent` object to argument `extent` for the map.}

\item{long}{A latitude for the text. Must provide an `raster::extent` object to argument `extent` for the map.}

\item{altitude}{Default `NULL`. Elevation of the label, in units of the elevation matrix (scaled by zscale). If none is passed, this will default to 10 percent above the maximum altitude in the heightmap.}

\item{extent}{Either an object representing the spatial extent of the scene 
(either from the `raster`, `terra`, `sf`, or `sp` packages), 
a length-4 numeric vector specifying `c("xmin", "xmax","ymin","ymax")`, or the spatial object (from 
the previously aforementioned packages) which will be automatically converted to an extent object.}

\item{x}{Default `NULL`. Directly specify the `x` index in the matrix to place the label.}

\item{y}{Default `NULL`. Directly specify the `y` index in the matrix to place the label.}

\item{z}{Default `NULL`. Elevation of the label, in units of the elevation matrix (scaled by zscale).}

\item{zscale}{Default `1`. The ratio between the x and y spacing (which are assumed to be equal) and the z axis. For example, if the elevation levels are in units}

\item{relativez}{Default `TRUE`. Whether `z` should be measured in relation to the underlying elevation at that point in the heightmap, or set absolutely (`FALSE`).}

\item{offset}{Elevation above the surface (at the label point) to start drawing the line.}

\item{clear_previous}{Default `FALSE`. If `TRUE`, it will clear all existing text and lines rendered with `render_label()`. If no
other arguments are passed to `render_label()`, this will just remove all existing lines.}

\item{textsize}{Default `1`. A numeric character expansion value.}

\item{dashed}{Default `FALSE`. If `TRUE`, the label line is dashed.}

\item{dashlength}{Default `auto`. Length, in units of the elevation matrix (scaled by `zscale`) of the dashes if `dashed = TRUE`.}

\item{linewidth}{Default `3`. The line width.}

\item{antialias}{Default `FALSE`. If `TRUE`, the line with be have anti-aliasing applied. NOTE: anti-aliasing can cause some unpredictable behavior with transparent surfaces.}

\item{alpha}{Default `1`. Transparency of the label line.}

\item{textalpha}{Default `1`. Transparency of the label text.}

\item{freetype}{Default `TRUE`. Set to `FALSE` if freetype is not installed (freetype enables anti-aliased fonts). NOTE: There are occasionally transparency issues when positioning Freetype fonts in front and behind a transparent surface.}

\item{adjustvec}{Default `c(0.5,-0.5)`. The horizontal and vertical offset for the text. If `freetype = FALSE` and on macOS/Linux, this is adjusted to `c(0.33,-0.5)` to keep the type centered.}

\item{family}{Default `"sans"`. Font family. Choices are `c("serif", "sans", "mono", "symbol")`.}

\item{fonttype}{Default `"standard"`. The font type. Choices are `c("standard", "bold", "italic", "bolditalic")`. NOTE: These require FreeType fonts, which may not be installed on your system. See the documentation for rgl::text3d() for more information.}

\item{linecolor}{Default `black`. Color of the line.}

\item{textcolor}{Default `black`. Color of the text.}
}
\description{
Adds a marker and label to the current 3D plot
}
\examples{
if(run_documentation()) {
montereybay \%>\%
 sphere_shade() \%>\%
 plot_3d(montereybay,zscale=50,water=TRUE, watercolor="#233aa1")
render_snapshot() 
}

santa_cruz = c(36.962957, -122.021033) 
#We want to add a label to Santa Cruz, so we use the x and y matrix coordinate (x=220 and y=330)
if(run_documentation()) {
render_label(montereybay,lat = santa_cruz[1], long = santa_cruz[2],
            extent = attr(montereybay, "extent"),
            altitude=12000, zscale=50, text = "Santa Cruz")
render_snapshot()
}

monterey = c(36.603053, -121.892933)
#We can also change the linetype to dashed by setting `dashed = TRUE` (additional options allow
#the user to control the dash length). You can clear the existing lines by setting 
#`clear_previous = TRUE`.
if(run_documentation()) {
render_label(montereybay, lat = monterey[1], long = monterey[2], altitude = 10000, 
            extent = attr(montereybay, "extent"),
            zscale = 50, text = "Monterey", textcolor = "white", linecolor="darkred",
            dashed = TRUE, clear_previous = TRUE)
render_snapshot()
}

canyon = c(36.621049, -122.333912)
#By default, z specifies the altitude above that point on the elevation matrix. We can also specify 
#an absolute height by setting `relativez=FALSE`.
if(run_documentation()) {
render_label(montereybay,lat=canyon[1], long = canyon[2], altitude = 2000,
            extent = attr(montereybay,"extent"),
            zscale=50,text = "Monterey Canyon", relativez=FALSE)
render_snapshot()
}

#We can also render labels in high quality with `render_highquality()`, specifying a custom
#line radius. By default, the labels point towards the camera, but you can fix their angle with
#argument `text_angle`.
if(run_documentation()) {
render_camera(theta=35, phi = 35, zoom = 0.80, fov=60)
render_label(montereybay, lat = monterey[1], long = monterey[2], altitude = 10000, 
            extent = attr(montereybay, "extent"),
            zscale = 50, text = "Monterey", textcolor = "white", linecolor="darkred",
            dashed = TRUE, clear_previous = TRUE)
               
render_label(montereybay,lat=canyon[1], long = canyon[2], altitude = 2000, zscale=50,
            extent = attr(montereybay,"extent"), textcolor = "white", linecolor="white",
            text = "Monterey Canyon", relativez=FALSE)
            
render_highquality(samples = 128,text_size = 24, line_radius = 2, text_offset = c(0, 20, 0),
                  lightdirection = 180, clamp_value = 10, min_variance = 0,
                  sample_method = "sobol_blue")
}
if(run_documentation()) {
#Fixed text angle
render_highquality(samples = 128,text_size = 24, line_radius = 2, text_offset = c(0, 20, 0),
                  lightdirection = 180, text_angle = 0, clamp_value=10, min_variance = 0,
                  sample_method = "sobol_blue")
}
#We can remove all existing labels by calling `render_label(clear_previous = TRUE)`
if(run_documentation()) {
render_label(clear_previous = TRUE) 
render_snapshot()
}
}
