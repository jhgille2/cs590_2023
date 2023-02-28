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
               here, 
               magrittr, 
               readr, 
               dplyr, 
               googledrive, 
               Biostrings, 
               animation, 
               purrr)
