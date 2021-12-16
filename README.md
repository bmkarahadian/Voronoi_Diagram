# Voronoi_Diagram

This project originated from my volunteer work with the Fresno County Public Health Department. I was tasked with analyzing vaccination rates (for polio, measles, etc.) of the public schools within the county. I immediately realized that this type of diagram would be the perfect way to visualize these data, since it is a relatively safe assumption that the vast majority of students attend the school that is nearest to their home. I could color the various sectors by the nearest school's vaccination rate and get a good sense of the various enclaves within the county.

Unfortunately, I had never heard of a Voronoi diagram, nor did I learn about it while searching for existing solutions in R. I did not learn the term "Voronoi" until I had already built one from scratch...

So this project, "Voronoi MK2.r" in particular, contains code that builds a Voronoi diagram given a set of points and a boundary polygon. In my case, the points were all of the schools in Fresno County and the boundary polygon is Fresno County itself.

## Method Overview

This is a streamlined description of the algorithm:

For each point in the provided dataset:

n-1 lines of equidistance are generated that relate the point to the other n-1 points. "Equidistance" here means that every point along the line is equidistant from the point of interest and the one other point in the dataset. Mathematically, each line is that along which circles of the same radius r would intersect if their centers were the two points in question.

Drawing all n-1 lines of equidistance and the boundary polygon creates a bounded space around the point. The algorithm then finds one side of this bounded space, that which exists at an angle of 0 radians from the point. (The possibility of an intersection occurring at 0 radians is accounted for.) It then crawls counter-clockwise along this bounded space, recording the intersection points where it jumps to a new line, until it returns to the side of the bounded space at 0 radians. It then uses the recorded points as vertices to generate a polygon.

When all n polygons are drawn, we are left with a Voronoi diagram that fills the boundary space.


See the included .png file for a static finished product. And see https://bmkarahadian.shinyapps.io/fresno_vaccine_voronoi/ for the leaflet/shiny app I built to visualize the Fresno County data.
