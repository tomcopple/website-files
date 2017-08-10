# Replicate ITC polar chart?
# Requires itcData to be in the environment
# Need to pick a series, production?
library(RColorBrewer)
comData <- itcData %>% 
    filter(country != "World", !grepl("Other", country)) %>% 
    select(commodity, organisation, production) %>% 
    filter(commodity != "Oilpalm", commodity != "Forestry") %>% 
    na.omit() %>% 
    arrange(commodity) %>% 
    group_by(commodity) %>% 
    summarise(production = sum(production, na.rm = TRUE)) %>% 
    top_n(5) %>% 
    mutate(fraction = production / sum(production, na.rm = TRUE),
           ymax = cumsum(fraction),
           ymin = lag(ymax, default = 0))%>% 
    rowwise() %>% 
    mutate(ylab = mean(c(ymin, ymax)))
orgData <- itcData %>% 
    filter(country != "World", !grepl("Other", country)) %>% 
    select(commodity, organisation, production) %>% 
    filter(commodity %in% comData$commodity) %>%
    na.omit() %>% 
    arrange(commodity) %>% 
    mutate(organisation = paste(commodity, organisation, sep = "-")) %>% 
    group_by(commodity, organisation) %>% 
    summarise(production = sum(production, na.rm = TRUE)) %>% 
    ungroup() %>% 
    arrange(organisation) %>% 
    # group_by(organisation) %>% 
    mutate(fraction = production / sum(production, na.rm = TRUE),
           ymax = cumsum(fraction),
           ymin = lag(ymax, default = 0)) 
# polarColors <- c(blogColours, "#ffc384", "#6f7dc0")
orgDataScale = c(
    colorRampPalette(c("#90c4d5", "#3e8197"))(nrow(filter(orgData, commodity == comData$commodity[1]))),
    colorRampPalette(c("#ffa792", "#cf5b3f"))(nrow(filter(orgData, commodity == comData$commodity[2]))),
    colorRampPalette(c("#ffdcb6", "#d99d5b"))(nrow(filter(orgData, commodity == comData$commodity[3]))),
    colorRampPalette(c("#9fe0b9", "#49ac71"))(nrow(filter(orgData, commodity == comData$commodity[4]))),
    colorRampPalette(c("#7882c0", "#535ea4"))(nrow(filter(orgData, commodity == comData$commodity[5])))
)

ggplot() +
    geom_rect(data = comData,
              aes(group = commodity, fill = commodity, ymin = ymin, ymax = ymax, xmin = 2, xmax = 3), fill = blogColours) +
    geom_rect(data = orgData,
              aes(group = organisation, fill = organisation, ymin = ymin, ymax = ymax, xmin = 3, xmax = 4), fill = orgDataScale) +
    geom_label(data = comData, aes(label = commodity, x = 3.4, y = ylab),
               size = 8, color = "#515151") +
    coord_polar(theta = "y") +
    xlim(c(0, 4)) +
    theme(
        text = element_blank(),
        legend.position = "none",
        panel.grid = element_blank(),
        axis.text = element_blank(),
        axis.ticks = element_blank()
    )

ggsave(filename = file.path("~/Dropbox/Work/coffeestats/projects/itcSustainability", "coffeeSustainability2.png"))
