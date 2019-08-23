#' Main workflow to create package data and tests for GG Body.
#' Paul Stevenson, 2019-08-22

#### import libraries ----

library(dplyr)
library(ggplot2)
library(ggpubr)
library(jpeg)
library(readr)
library(usethis)

#### import functions ----

source("R/ggbody.R")

#### create body_map.RData ----

location_map <- list()

location_map$male_frontback <- read_csv("data-raw/body_map.csv") # eventually replace this with a package dataset

#### import silhouette(s) ----

silhouette <- list()

silhouette$male_frontback <- readJPEG("data-raw/body.jpg")

#### create sample package data ----

(body_pain <- tibble(location = c("head", "knee_left", "buttock_left", "hand_right_front", "calf_right"),
               Pain = c(0.9, 0.8, 0.9, 0.5, 0.5)) %>%
    mutate(Pain = Pain * 10))

#### save package data ----

use_data(location_map, silhouette, internal = TRUE, overwrite = TRUE)
use_data(body_pain, overwrite = TRUE)

#### ggbody function example ----

ggbody(body_pain, Pain) +
  scale_color_gradient(limits = c(1, 10), low="#FED141", high="#B52555")
