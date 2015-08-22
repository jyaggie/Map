library(shiny)
library(leaflet)
library(lubridate)
weather<-read.table("chiweather.csv", header=TRUE, stringsAsFactors=FALSE, sep=",")
weather <- weather[weather$LONGITUDE!=0&weather$LONGITUDE<(8900),]
weather <-weather[weather$LATITUDE!=0,]
weather$LATITUDE <- weather$LATITUDE/100
weather$LONGITUDE <- weather$LONGITUDE/-100
datesplit<- strsplit(weather$BGN_DATE, " ")
yr<-list()
for(i in datesplit) {yr<-c(yr,year(mdy(gsub("/","-",i[1]))))}
weather$YEAR<-yr
weather$EVTYPE<-as.factor(weather$EVTYPE)

mappts <- sp::SpatialPointsDataFrame(cbind(weather$LONGITUDE,weather$LATITUDE),data.frame(type = weather$EVTYPE, year=as.numeric(weather$YEAR)))
pal <- colorFactor(c("red","yellow","blue"), domain=mappts$type)
selection1<- c("ALL EVENTS", levels(mappts$type))
selection2<-c("ALL YEARS", "1950s", "1960s", "1970s", "1980s","1990s", "2000s", "2010s")

shinyServer(function(input, output) {


  output$text1 <- renderText({ 
    paste("<div style='color:#000000;padding:10px;font-weight: bold;font-size: 125%;'> You have selected ", input$event, " for ", input$years, "</div>")
  })
  
  

  
  
  pts<-reactive({
    switch(input$event, 
           FLOOD={
             pt<-mappts[mappts$type=="FLOOD",]
           },
           THUNDERSTORM={
             pt<-mappts[mappts$type=="THUNDERSTORM",]
           },
           TORNADO={
             pt<-mappts[mappts$type=="TORNADO",]
           },
          {
          pt<-mappts
        })
    switch(input$years, 
           "1950s"={
             ptb<-pt[pt$year>=1950&pt$year<1960,]
           },
           "1960s"={
             ptb<-pt[pt$year>=1960&pt$year<1970,]
           },
           "1970s"={
             ptb<-pt[pt$year>=1970&pt$year<1980,]
           },
           "1980s"={
             ptb<-pt[pt$year>=1980&pt$year<1990,]
           },
           "1990s"={
             ptb<-pt[pt$year>=1990&pt$year<2000,]
           },
           "2000s"={
             ptb<-pt[pt$year>=2000&pt$year<2010,]
           },
           "2010s"={
             ptb<-pt[pt$year>=2010&pt$year<2020,]
           },
          {
            ptb<-pt
        })
    if(nrow(ptb)<1){
      ptb <- sp::SpatialPointsDataFrame(cbind(0,0),data.frame(type ="", year=""))
      
    }
    
    return(ptb)
    
  })  

  output$error <- renderText({ 
    if(pts()[1,2]$year=="") paste("<div style='color:#FF0000;padding:10px;font-weight: bold;font-size: 170%;'> You have selected</h1> a event & decade combination with no results</div>")
    else paste("")
  })  

  output$num <- renderText({ 
    
    if(pts()[1,2]$year=="") dnum<-0
    else dnum<-nrow(pts())
     paste("<div style='color:#000000;padding:10px;font-weight: bold;font-size: 150%;'> There are ", dnum, " events selected.</div><hr><hr><hr>")
 
  })
  

  output$mymap <- renderLeaflet({
    
    leaflet(pts()) %>%
      addTiles() %>%
      addCircles(color = ~pal(type))
    
  })
  
  
  output$documentation <- renderText({ 
    dtitle = "<h2>Documentation</h2>"
    dsub0 = "<h3>Goal</h3>"
    dtext0 = "<p>The purpose of this application is to visually and numerically display the information about weather events in the city of Chicago.</p>"
    dsub1 = "<h3>Data</h3>"
    
    dtext1 = "<p>The dataset used for this App is a subset of the NOAA dataset used for Reproducable Data.   The subset of the data presented here is weather events local to Cook County, IL.  However, the latitude and longitude information provided as part of this dataset is inexact.  In addition, the begin latitude and longitude were used for plotting points.  For these two reasons, much of the data does not map to be within Chicago proper. **     </p>"
    
    dsub2 = "<h3>Usage</h3>"
    dtext2="<p>Data can be diplayed based on two criteria: </p>
    <ol>
    <li>Event Type</li>
    <li>Decade of Occurance</li>
    </ol>
  <p> The Event Type has four possible values:</p>
    <ul>
    <li>ThunderStorm</li>
    <li>Flood</li>
    <li>Tornado</li>
    <li>All Events</li>
    </ul>
  <p>The choice of decase span from the 1950s to present.   Each time a value is chosen the map is updated to reflect the change.  Underneath the selection one can view the criteria for which the map is currently filtered.  <p>
<p>Events are colored as follows: </p>
    <ul>
    <li><div style='color:#FFFF00;padding:10px;font-weight: bold;'>ThunderStorm</div></li>
    <li><div style='color:#FF0000;padding:10px;font-weight: bold;'>Flood</div></li>
    <li><div style='color:#0000FF;padding:10px;font-weight: bold;'>Tornado</div></li>
    </ul>
    "
    
    
    anote = "**The author's motivation for this application was as proof of concept for another dataset in which location data is more appropriate.  "
    paste(dtitle, dsub0, dtext0,dsub1, dtext1, dsub2, dtext2, anote)
  })
  
  
})
