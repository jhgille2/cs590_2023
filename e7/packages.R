# Install pacman if it does not already exist
if(!require(pacman)){
  install.packages("pacman")
}

# Use pacman to load/install packaged
pacman::p_load(conflicted, 
               dotenv, 
               targets, 
               tarchetypes, 
               tidyverse, 
               purrr, 
               ggplot2, 
               ggthemes,
               here, 
               tools, 
               magrittr, 
               cowplot, 
               patchwork, 
               vcfR, 
               ape, 
               ASMap,
               qtl, 
               onemap)
