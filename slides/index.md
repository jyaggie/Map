---
title       : Chicago Weather Events
subtitle    : Exploration of Events by Decade
author      :
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : impressjs
  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---
## Purpose



* Visualization of where events were reported
* Easy to use selection of relevant events
* Build an application that an be extended to other datasets.
* Provide basic information about the relevant data 


--- .class1 #id1 bg:yellow


## Numerically Speaking....

The percent of a specific event type by decade is summarized in the following table --



```
##               Decade
## Event           1950s  1960s  1970s  1980s  1990s  2000s  2010s    Sum
##   FLOOD          0.00   0.00   0.00   0.00   0.00   5.14   2.05   7.19
##   THUNDERSTORM   1.71   7.02   5.74   6.93   6.51  41.52  19.01  88.44
##   TORNADO        0.68   0.94   1.20   0.43   0.17   0.68   0.26   4.37
##   Sum            2.40   7.96   6.93   7.36   6.68  47.35  21.32 100.00
```
However this gives not information about the location of the event.

--- .class #id 

## The Application

* Allows the user to choose the specific events and decades relevant to them.
* View the percent of the total events represented
* View on a map the location of these events.

--- .class #id 

## Summary

The app allows users to select and view relevant data and statistics about weather in Chicagoland.

