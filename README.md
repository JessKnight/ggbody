# ggbody

The ggbody package draws a heat-map of events on a human body silhouette.

This package is in early development and has a very limited number of body
locations.

### Installation

    remotes::install_github("TelethonKids/ggbody")

### Example

    #### load ggbody package ----
    
    library(ggplot2)
    library(ggbody)
    
    #### create heatmap ----
    
    data(body_pain)
    
    ggbody(body_pain, Pain) +
      scale_color_gradient(limits = c(1, 10), low="#FED141", high="#B52555")
    

![](figs/example.png)