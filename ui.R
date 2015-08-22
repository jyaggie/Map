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


shinyUI(fluidPage(
    sidebarPanel( 
      selectInput('event', 'Event Type', selection1),
      selectInput('years', 'Decade', selection2),
      uiOutput("text1")
    ),    mainPanel(
      uiOutput("error"),
      leafletOutput("mymap"),
      uiOutput("num"),
      uiOutput("documentation")
    )
    
    
  ))
  
