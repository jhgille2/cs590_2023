#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title
#' @param plot_ready_data
make_summary_plots <- function(plot_ready_data) {
  
  
  # Make a plot for the allele frequency data
  allele_freq_plot <- ggplot(plot_ready_data$allele_freqs, aes(x = value, fill = name)) + 
    geom_histogram() + 
    theme_calc() + 
    theme(legend.title = element_blank()) + 
    xlab("Frequency") + 
    ylab("Count") + 
    theme(axis.text = element_text(size = 12)) + 
    coord_cartesian(xlim = c(0, 1))

  # Make a faceted plot for the other summary data
  other_stats_plots <- ggplot(plot_ready_data$no_allele_freq, aes(x = value)) + 
    geom_histogram() +
    facet_wrap(~df_name, scales = "free", ncol = 1) + 
    theme_calc() + 
    xlab("Value") + 
    ylab("Count") + 
    theme(strip.text = element_text(face = "bold", size = 12), 
          axis.text = element_text(size = 12))
  
  # Combine the two plots with patchwork
  both_plots <- allele_freq_plot + other_stats_plots
  
  # Return all the plots in a list
  res <- list("allele_freq"     = allele_freq_plot, 
              "faceted_summary" = other_stats_plots, 
              "all_plots"       = both_plots)
  
  return(res)
}
