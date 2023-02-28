#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title
#' @param allele_freq_file
read_allele_freq <- function(allele_freq_file) {

    freq_df <- read_delim(allele_freq_file, 
                          col_names = FALSE, 
                          skip = 1, delim = "\t")
    
    colnames(freq_df) <- c("CHROM", 
                           "POS", 
                           "N_ALLELES", 
                           "N_CHR", 
                           "ALLELE_1_FREQ", 
                           "ALLELE_2_FREQ")
    freq_df %<>% 
      separate(ALLELE_2_FREQ, 
               into = c("ALLELE_2_FREQ", "ALLELE_3_FREQ"), 
               sep = "\\\t") %>% 
      separate(ALLELE_3_FREQ, 
               into = c("ALLELE_3_FREQ", "ALLELE_4_FREQ"), 
               sep = "\\\t") %>%
      separate(ALLELE_1_FREQ,
               into = c("ALLELE_1_ALLELE", "ALLELE_1_FREQ"),
               sep = ":") %>%
      separate(ALLELE_2_FREQ,
               into = c("ALLELE_2_ALLELE", "ALLELE_2_FREQ"),
               sep = ":") %>% 
      separate(ALLELE_3_FREQ, 
               into = c("ALLELE_3_ALLELE", "ALLELE_3_FREQ"), 
               sep = ":") %>% 
      separate(ALLELE_4_FREQ, 
               into = c("ALLELE_4_ALLELE", "ALLELE_4_FREQ"), 
               sep = ":")
    
    return(freq_df)
}
