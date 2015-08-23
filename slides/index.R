---
title       : Chicago Weather Events
subtitle    : Exploration of Events by Decade
author      : Me
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---
## Slide 1

--- .class #id 

## Slide 2
```{r, echo=5}
library(ggplot2)
data(diamonds)
diamonds<-diamonds[sample(1:nrow(diamonds),2000),]
ggplot(diamonds, aes(carat, price))+geom_point(color="firebrick")
```

is this content?



