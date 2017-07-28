# Rough theme for blogpost graphs (ggplot)
blogColours <- c("#619fb5", "#ef8066", "#ffcb90", "#70c793", "#7882c0")
theme_blog <- function() {
    theme(
        text = element_text(
            family = 'Verdana',
            size = 10,
            color = '#515151'
        ),
        panel.background = element_blank(),
        panel.grid.major.y = element_line(
            color = '#EEEEEE',
            # linetype = 'dotted',
            size = 0.3
        ),
        panel.grid.major.x = element_blank(),
        panel.grid.minor.y = element_blank(),
        panel.grid.minor.x = element_blank(),
        axis.text.y = element_text(
            margin = margin(l = 6)
        ),
        axis.ticks = element_blank()
    )
}
scale_y_blog <- function() {
    library(scales)
    scale_y_continuous(labels = scales::comma,
                       breaks = scales::pretty_breaks())
}
