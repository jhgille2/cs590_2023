#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title
#' @param output_data
prep_plot_data <- function(output_data) {
  
  # .imiss= missing by individual (missing_individual)
  # .lmiss= missing by site (missing_site)
  # .lqual= quality by site (quality_site)
  # .idepth= depth by individual (depth_individual)
  # .ldepth= depth by site (depth_site)
  # .frq= allele frequency (allele_freq)

  # A function that selects just columns for plotting from each
  # dataframe in the output_data list
  
  simplify_for_plotting <- function(output_data){
    
    # Add the name of the dataframe to each dataframe
    output_data %<>%
      map2(., names(.), function(x, y) mutate(x, df_name = y))
    
    
    reduce_columns <- function(output_df, df_name){
      
      # Get just the columns I want for plotting
      #
      # allele_freq: Allele frequencies
      # depth_individual: mean_depth
      # depth_site: sum_depth
      # missing_individual: N_Miss
      # missing_site: N_Miss
      # quality_site: QUAL
      
      if(df_name == "allele_freq"){
        output_df %<>%
          select(ALLELE_1_FREQ, ALLELE_2_FREQ, ALLELE_3_FREQ, df_name) %>% 
          pivot_longer(cols = c(ALLELE_1_FREQ, ALLELE_2_FREQ, ALLELE_3_FREQ)) %>% 
          mutate(value = as.numeric(value))
      }else if(df_name == "depth_individual"){
        output_df %<>%
          select(MEAN_DEPTH, df_name) %>% 
          rename(value = MEAN_DEPTH)
      }else if(df_name == "depth_site"){
        output_df %<>%
          select(SUM_DEPTH, df_name) %>% 
          rename(value = SUM_DEPTH)
      }else if(df_name == "missing_individual"){
        output_df %<>%
          select(N_MISS, df_name) %>% 
          rename(value = N_MISS)
      }else if(df_name == "missing_site"){
        output_df %<>%
          select(N_MISS, df_name) %>% 
          rename(value = N_MISS)
      }else{
        output_df %<>%
          select(QUAL, df_name) %>% 
          rename(value = QUAL)
      }
      
      return(output_df)
      
    }
    
    # Apply the cleaning function to the output data list and return
    output_data %<>%
      map2(., names(.), reduce_columns)
    
    return(output_data)
  }
  
  # Apply the cleaning function to the output data
  simplified_dfs <- simplify_for_plotting(output_data)
  
  # Cmbine all the data
  all_dfs <- simplified_dfs %>% 
    reduce(bind_rows)

  # Allele df
  allele_plotting_data <- simplified_dfs$allele_freq
  
  # All the other data besides the allele frequency df
  no_allele_freq <- simplified_dfs[-1] %>% 
    reduce(bind_rows) %>% 
    mutate(df_name = recode(df_name, 
                            depth_individual   = "Depth by individual", 
                            depth_site         = "Depth by site", 
                            missing_individual = "Number missing by individual", 
                            missing_site       = "Number missing by site", 
                            quality_site       = "Quality by site"))
  
  # Combine the cleaned datasets into a list and return the list
  res <- list("all_dfs"        = simplified_dfs, 
              "allele_freqs"   = allele_plotting_data, 
              "no_allele_freq" = no_allele_freq)
  
  return(res)
}
