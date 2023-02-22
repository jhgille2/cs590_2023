#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title
#' @param summary_plots
#' @param filtered_summary_plots
compare_all_plots <- function(summary_plots, filtered_summary_plots) {

  # Patchwork with adjustments to annotate by filter vs non filter
  pwork <- filtered_summary_plots$all_plots / summary_plots$all_plots
  pwork[[1]] <- pwork[[1]] + plot_layout(tag_level = "new")
  pwork[[2]] <- pwork[[2]] + plot_layout(tag_level = "new")
  
  # Add annotations and return
  p <- pwork + plot_annotation(tag_levels = c("A", "1"), 
                                        title = "Comparison of filtered vs non-filtered allele distributions", 
                                        subtitle = "A = filtered, B = not filtered")
  
  return(p)
}
