# Install pacman if it does not already exist
if(!require(pacman)){
  install.packages("pacman")
}

# Use pacman to load/install packaged
pacman::p_load(conflicted, 
               dotenv, 
               targets, 
               tarchetypes, 
               here, 
               magrittr, 
               readr, 
               dplyr, 
               googledrive, 
               Biostrings, 
               animation, 
               purrr, 
               ggplot2, 
               gganimate, 
               ggthemes)


pacman::p_load_gh("milesmcbain/fnmate")
