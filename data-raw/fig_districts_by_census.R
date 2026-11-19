# Figure for the README: districts in each census, split into districts that
# already existed in 1981 and districts created afterwards.
# Uses the package's own `districts` data; writes man/figures/districts_by_census.png
# Run from the repository root: source("data-raw/fig_districts_by_census.R")

library(ggplot2)

load("data/districts.rda")

years <- c(1981, 1993, 2007, 2017, 2025)
counts <- do.call(rbind, lapply(years, function(y) {
  present <- districts[[paste0("census_", y)]] == 1
  in1981  <- districts$census_1981 == 1
  data.frame(
    census = factor(y, levels = years),
    group  = c("Existed in 1981", "Created after 1981"),
    n      = c(sum(present & in1981), sum(present & !in1981))
  )
}))
counts$group <- factor(counts$group,
                       levels = c("Created after 1981", "Existed in 1981"))
totals <- aggregate(n ~ census, data = counts, FUN = sum)

col_existing <- "#2a78d6"
col_new      <- "#eb6834"
surface      <- "#fcfcfb"
ink          <- "#0b0b0b"
ink2         <- "#52514e"

p <- ggplot(counts, aes(census, n, fill = group)) +
  geom_col(width = 0.6, colour = surface, linewidth = 0.6) +
  geom_text(data = totals, aes(census, n, label = format(n, big.mark = ",")),
            inherit.aes = FALSE, vjust = -0.6, size = 4, colour = ink,
            fontface = "bold") +
  geom_text(data = subset(counts, group == "Created after 1981" & n > 0),
            aes(census, 1680 + n / 2, label = paste0("+", n)),
            inherit.aes = FALSE, size = 3.4, colour = ink2,
            hjust = 0, nudge_x = 0.34) +
  scale_fill_manual(values = c("Existed in 1981" = col_existing,
                               "Created after 1981" = col_new),
                    breaks = c("Existed in 1981", "Created after 1981")) +
  scale_y_continuous(limits = c(0, 2050), breaks = seq(0, 2000, 500),
                     labels = function(x) format(x, big.mark = ","),
                     expand = c(0, 0)) +
  labs(title = "Districts of Peru in each population census",
       subtitle = "Districts of the 2025 frame present at each census date",
       x = NULL, y = "Districts", fill = NULL,
       caption = "Source: historicubigeo (districts). Counts match INEI's published totals.") +
  theme_minimal(base_size = 12) +
  theme(plot.background  = element_rect(fill = surface, colour = NA),
        panel.grid.major.x = element_blank(),
        panel.grid.minor   = element_blank(),
        panel.grid.major.y = element_line(colour = "#e6e5e0", linewidth = 0.3),
        axis.text  = element_text(colour = ink2),
        axis.title = element_text(colour = ink2),
        plot.title = element_text(colour = ink, face = "bold"),
        plot.subtitle = element_text(colour = ink2),
        plot.caption  = element_text(colour = ink2, size = 8, hjust = 0),
        plot.caption.position = "plot",
        plot.title.position   = "plot",
        legend.position = "top", legend.justification = "left",
        legend.text = element_text(colour = ink2),
        plot.margin = margin(12, 16, 10, 12))

ggsave("man/figures/districts_by_census.png", p,
       width = 7, height = 4.2, dpi = 200, bg = surface)
