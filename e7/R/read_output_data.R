#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title
#' @param output_files
read_output_data <- function(file_paths) {
  
  # FUnction to read in the allele frequency file 
  read_allele_freq <- function(allele_freq_file){
    
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
      separate(ALLELE_1_FREQ,
               into = c("ALLELE_1_ALLELE", "ALLELE_1_FREQ"),
               sep = ":") %>%
      separate(ALLELE_2_FREQ,
               into = c("ALLELE_2_ALLELE", "ALLELE_2_FREQ"),
               sep = ":") %>% 
      separate(ALLELE_3_FREQ, 
               into = c("ALLELE_3_ALLELE", "ALLELE_3_FREQ"), 
               sep = ":")
    
    return(freq_df)
  }

  read_fn <- function(file){
    
    if(file_path_sans_ext(basename(file)) %in% c("allele_freq", "allele_freq_filtered")){
      res <- read_allele_freq(file)
    }else{
      res <- read_delim(file, delim = "\t")
    }
    
    return(res)
    
  }
  
  all_dfs <- purrr::map(file_paths, read_fn) %>% 
    set_names(file_path_sans_ext(basename(file_paths)))
  
  names(all_dfs) <- str_remove(names(all_dfs), "_filtered")
  
  return(all_dfs)
}
