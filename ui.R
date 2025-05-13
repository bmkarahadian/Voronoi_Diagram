library(shiny)
library(leaflet)
library(tidyverse)
library(sf)

# Define UI for application that draws a histogram
shinyUI(fillPage(
    titlePanel(title = "Fresno County Public Schools"),
    leafletOutput("mymap", width = "100%", height = "95%"),
    absolutePanel(top = 65, right = 10,
        selectInput(
            "grade",
            "Grade",
            c("Kindergarten", "Seventh")
        ),
        selectInput(
            "year",
            "School Year",
            c("2016-2017", "2017-2018", "2018-2019", "2019-2020")
        ),
        checkboxInput("markers", "Show Schools", TRUE),
        checkboxInput("voronoi_lines", "Show Voronoi Lines", FALSE),
        checkboxInput("district_lines", "Show District Boundaries", FALSE)
    )
))
