tar_load(output_data)


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
    
    # Get just the columns for plotting
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
  
    output_data %<>%
      map2(., names(.), reduce_columns)
  
    return(output_data)
}


simplified_dfs <- simplify_for_plotting(output_data)

# Cmbine all the data
all_dfs <- simplified_dfs %>% 
  reduce(bind_rows)

# Working on plotting functions for the different dfs
# Allele df
allele_plotting_data <- simplified_dfs$allele_freq


allele_freq_plot <- ggplot(allele_plotting_data, aes(x = value, fill = name)) + 
  geom_histogram() + 
  theme_calc() + 
  theme(legend.title = element_blank()) + 
  xlab("Frequency") + 
  ylab("Count") + 
  theme(axis.text = element_text(size = 12))

# .imiss= missing by individual (missing_individual)
# .lmiss= missing by site (missing_site)
# .lqual= quality by site (quality_site)
# .idepth= depth by individual (depth_individual)
# .ldepth= depth by site (depth_site)
# .frq= allele frequency (allele_freq)

# All the other data besides the allele frequency df
no_allele_freq <- simplified_dfs[-1] %>% 
  reduce(bind_rows) %>% 
  mutate(df_name = recode(df_name, 
                          depth_individual = "Depth by individual", 
                          depth_site = "Depth by site", 
                          missing_individual = "Number missing by individual", 
                          missing_site = "Number missing by site", 
                          quality_site = "Quality by site"))


other_stats_plots <- ggplot(no_allele_freq, aes(x = value)) + 
  geom_histogram() +
  facet_wrap(~df_name, scales = "free", ncol = 1) + 
  theme_calc() + 
  xlab("Value") + 
  ylab("Count") + 
  theme(strip.text = element_text(face = "bold", size = 12), 
        axis.text = element_text(size = 12))



