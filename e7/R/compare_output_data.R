#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title
#' @param output_data
#' @param filtered_output_data
compare_output_data <- function(output_data, filtered_output_data) {

  # Get just the allele freq dataframes
  nonfilt_allele_freq <- pluck(output_data, "allele_freq") %>% 
    mutate(filtered = "Not Filtered") %>% 
    select(filtered, ALLELE_1_FREQ, ALLELE_2_FREQ, ALLELE_3_FREQ)
  
  filt_allele_freq <- pluck(filtered_output_data, "allele_freq") %>% 
    mutate(filtered = "Filtered") %>% 
    select(filtered, ALLELE_1_FREQ, ALLELE_2_FREQ, ALLELE_3_FREQ)
  
  # Bind the two dataframes together, pivot for ggplot, and 
  # do some filtering/type setting
  all_allele_freq <- bind_rows(nonfilt_allele_freq, filt_allele_freq) %>% 
    pivot_longer(cols = c(ALLELE_1_FREQ, ALLELE_2_FREQ, ALLELE_3_FREQ)) %>% 
    dplyr::filter(!is.na(value)) %>% 
    mutate(value = as.numeric(value))
  
  # Make the plot and return the plot
  p <- ggplot(all_allele_freq, aes(x = value, fill = name)) + 
    facet_wrap(~filtered, ncol = 1) + 
    geom_histogram() + 
    theme_calc() + 
    theme(legend.title = element_blank()) + 
    xlab("Frequency") + 
    ylab("Count") + 
    theme(axis.text = element_text(size = 12, face = "bold"), 
          strip.text = element_text(size = 15, face = "bold"), 
          axis.title = element_text(size = 15))
  
  return(p)
}
