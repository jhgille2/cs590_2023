make_expressed_scatterplot <- function(filtered_epigenetic_data, cntsMax){

    # Pull out the epiData and expressed gene names from the filtered
    # epigenetic data
    epiData <- filtered_epigenetic_data %>%
                    pluck("epiData")

    Expressed <- filtered_epigenetic_data %>%
                    pluck("expressed")

    # make a dataframe for plotting
    plotting_df <- tibble(MethCHG = epiData[Expressed, "MethCHG"],
                          log_counts = log2(cntsMax[Expressed]))

    # Make and save the scatterplot
    p <- ggplot(plotting_df, aes(x = MethCHG, y = log_counts)) +
        geom_point(col = rgb(0, 0, 1, 0.2), pch = 16) +
        theme_gdocs() +
        labs(y = "mRNA Expression level",
             x = "MethCHG") +
        scale_y_continuous(expand = c(0, 0))

    ggsave(filename = "expression_scatterplot.png",
           plot     = p,
           path     = here::here("plots"),
           device   = "png",
           width    = 10,
           height   = 10,
           units    = "in",
           dpi      = "retina")

    # Return the path to the plot
    outpath <- here::here("plots", "expression_scatterplot.png")

    return(outpath)
}