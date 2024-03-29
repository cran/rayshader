% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/generate_line_overlay.R
\name{generate_line_overlay}
\alias{generate_line_overlay}
\title{Generate Line Overlay}
\usage{
generate_line_overlay(
  geometry,
  extent,
  heightmap = NULL,
  width = NA,
  height = NA,
  resolution_multiply = 1,
  color = "black",
  linewidth = 1,
  lty = 1,
  data_column_width = NULL,
  offset = c(0, 0)
)
}
\arguments{
\item{geometry}{An `sf` object with LINESTRING geometry.}

\item{extent}{Either an object representing the spatial extent of the scene 
(either from the `raster`, `terra`, `sf`, or `sp` packages), 
a length-4 numeric vector specifying `c("xmin", "xmax","ymin","ymax")`, or the spatial object (from 
the previously aforementioned packages) which will be automatically converted to an extent object.}

\item{heightmap}{Default `NULL`. The original height map. Pass this in to extract the dimensions of the resulting 
overlay automatically.}

\item{width}{Default `NA`. Width of the resulting overlay. Default the same dimensions as height map.}

\item{height}{Default `NA`. Width of the resulting overlay. Default the same dimensions as height map.}

\item{resolution_multiply}{Default `1`. If passing in `heightmap` instead of width/height, amount to 
increase the resolution of the overlay, which should make lines/polygons/text finer. 
Should be combined with `add_overlay(rescale_original = TRUE)` to ensure those added details are captured
in the final map.}

\item{color}{Default `black`. Color of the lines.}

\item{linewidth}{Default `1`. Line width.}

\item{lty}{Default `1`. Line type. `1` is solid, `2` is dashed, `3` is dotted,`4` is dot-dash,
`5` is long dash, and `6` is dash-long-dash.}

\item{data_column_width}{Default `NULL`. The numeric column to map the width to. The maximum width will be the value
specified in `linewidth`.}

\item{offset}{Default `c(0,0)`. Horizontal and vertical offset to apply to the line, in units of `geometry`.}
}
\value{
Semi-transparent overlay with contours.
}
\description{
Calculates and returns an overlay of lines for the current height map.
}
\examples{
#Add the included `sf` object with roads to the montereybay dataset
if(run_documentation()) {
water_palette = colorRampPalette(c("darkblue", "dodgerblue", "lightblue"))(200)
bathy_hs = height_shade(montereybay, texture = water_palette)
montereybay \%>\% 
 height_shade() \%>\%
 add_overlay(generate_altitude_overlay(bathy_hs, montereybay, 0, 0))  \%>\%
 add_overlay(generate_line_overlay(monterey_roads_sf, 
                                   attr(montereybay,"extent"), heightmap = montereybay))  \%>\%
 add_shadow(ray_shade(montereybay,zscale=50),0.3) \%>\%
 plot_map()
}
if(run_documentation()) {
#Change the line width, color, and transparency
montereybay \%>\%
 height_shade() \%>\%
 add_overlay(generate_altitude_overlay(bathy_hs, montereybay, 0, 0))  \%>\%
 add_overlay(generate_line_overlay(monterey_roads_sf, linewidth=3, color="white",
                                   attr(montereybay,"extent"), heightmap = montereybay),
                                   alphalayer=0.8)  \%>\%
 add_shadow(ray_shade(montereybay,zscale=50),0.3) \%>\%
 plot_map()
}
if(run_documentation()) {
#Manually specify the width and height to improve visual quality of the lines
montereybay \%>\%
 height_shade() \%>\%
 add_overlay(generate_altitude_overlay(bathy_hs, montereybay, 0, 0))  \%>\%
 add_shadow(ray_shade(montereybay,zscale=50),0.3) \%>\%
 add_overlay(generate_line_overlay(monterey_roads_sf, linewidth=3, color="white",
                                   attr(montereybay,"extent"), width = 1080, height = 1080),
                                   alphalayer=0.8)  \%>\%
 plot_map()
}
}
