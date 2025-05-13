library(shiny)
library(leaflet)
library(tidyverse)
library(sf)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    vax <- read_rds("https://www.dropbox.com/s/w9gme0lcnofaho6/vax.rds?dl=1")
    
    districts <- read_rds("https://www.dropbox.com/s/inaevw355cmgb9a/districts.rds?dl=1")

    output$mymap <- renderLeaflet({
        
        leaflet() %>% 
            addTiles() %>%
            setView(lng = -119.65, lat = 36.8, zoom = 9)

    })
    
    observe({
        
        yr <- str_extract(input$year, "[:digit:]{4}(?=-)")
        dat <- vax %>%
            filter(year == yr, grade == input$grade)
        
        strk <- input$voronoi_lines
        
        
        map <- 
            leafletProxy("mymap") %>%
            clearShapes() %>%
            clearMarkers() %>%
            clearControls() %>%
            addPolygons(data = dat$polys, fillColor = dat$color, fillOpacity = 0.75, stroke = strk) %>%
            addLegend("bottomright", 
                      # colors = c("#FEE0D2", "#FC9272", "#DE2D26"),
                      colors = c("green", "yellow", "orange", "red"),
                      # labels = c("Maximum", "> 90%", "≤ 90%"),
                      labels = c("Safest (≥ 95%)", "Moderately Vulnerable (≥ 90%)", 
                                 "More Vulnerable (≥ 80%)", "Most Vulnerable (< 80%)"),
                      title = "Status (Percent of Students Up-to-Date on Vaccinations)")
        
        if (input$markers) {
            map <- 
                map %>%
                addMarkers(data = dat$points,
                           popup = str_c(dat$school,
                                         str_c("District:", dat$pub_district, sep = " "),
                                         str_c("Enrollment:", dat$enrollment, sep = " "),
                                         str_c("Proportion Up-to-Date:", dat$var3, sep = " "),
                                         sep = "<br/>"))
        }
        
        if (input$district_lines) {
            map <-
                map %>%
                addPolylines(data = districts$data, color = "black", opacity = 0.2)
        }
        
        map
    })
})

