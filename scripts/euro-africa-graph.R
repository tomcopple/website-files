# Ribbon graph for trade between EU and Africa, based on Eurostat data.
# This got crazy complicated so just saved as csv. 

library(tidyverse);library(coffeestats);library(plotly)
coffeeAfrica <- "~/Dropbox/Work/coffeestats/projects/coffeeAfrica"
blogColours <- c("#619fb5", "#ef8066", "#ffcb90", "#70c793", "#7882c0")


source("~/R/tomcopple.github.io/scripts/theme_blog.R")

euroAfGraph <- read_csv(file.path(coffeeAfrica, "euroAfGraph.csv"))
ggplot(euroAfGraph, aes(x = PERIOD)) +
    geom_line(aes(y = Y, group = SERIES, color = SERIES)) +
    geom_ribbon(aes(ymin = YMIN, ymax = YMAX, group = SERIES, fill = SERIES), show.legend = FALSE, alpha = 0.5) +
    scale_color_manual("", values = blogColours, labels = c("Exports", "Imports")) +
    scale_fill_manual("", values = blogColours) +
    theme_blog() +
    labs(title = "Value of coffee traded between EU and Africa", x = NULL, y = "Million €") +
    theme(legend.key = element_blank(),
          text = element_text(color = "#515151"))
