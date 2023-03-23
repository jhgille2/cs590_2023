make_epigenetic_boxplots <- function(filtered_epigenetic_data){

    # Add the rownames as a column and then pivot to a long format, add a column 
    # to identify what genes are expressed and nonexpressed
    epigenetic_data_long <- filtered_epigenetic_data %>%
        purrr::pluck("epiData") %>% 
        tibble::rownames_to_column("gene_name") %>%
        tidyr::pivot_longer(cols = 2:ncol(.)) %>%
        mutate(name = factor(name),
               is_expressed = ifelse(gene_name %in% filtered_epigenetic_data$expressed, "Expressed", # nolint
                                        ifelse(gene_name %in% filtered_epigenetic_data$nonexpressed, "nonExpressed", NA)), # nolint
                is_expressed = factor(is_expressed))

    # Make the boxplot
    p <- ggplot(epigenetic_data_long, aes(x = value, fill = is_expressed, y = is_expressed)) +
        geom_boxplot() +
        theme_gdocs() +
        facet_wrap(~name, scales = "free") + 
        coord_flip()

    # Save the plot and then return the path to the plot
    ggsave(filename = "boxplots.png",
           plot     = p,
           device   = "png",
           path     = here::here("plots"),
           height   = 10,
           width    = 20,
           units    = "in")

    outpath <- here::here("plots", "boxplots.png")

    return(outpath)
}