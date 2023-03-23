make_count_plot <- function(cntsMax){

    plot_tbl <- tibble(log_counts = log2(cntsMax))

    p <- ggplot(plot_tbl, aes(x = log_counts)) +
            geom_histogram(color = "black", fill = "lightblue") +
            theme_gdocs() +
            labs(main = "Histogram of log2(cntsMax)",
                 x    = "log2(cntsMax)",
                 y    = "Frequency") +
            geom_vline(xintercept = 1, linetype = "dashed", color = "red")

    ggsave(filename = "log_counts_plot.png",
           plot = p,
           device = "png",
           path = here::here("plots"),
           height = 5,
           width = 10,
           units = "in",
           dpi = "retina")

    plot_path <- here::here("plots", "log_counts_plot.png")

    return(plot_path)
}