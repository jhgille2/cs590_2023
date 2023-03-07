# Install pacman if it does not already exist
if(!require(pacman)){
  install.packages("pacman")
}

# Use pacman to load/install packaged
pacman::p_load(conflicted,
               dotenv,
               targets,
               tarchetypes,
               dplyr,
               purrr,
               here,
               tools,
               tximport,
               DESeq2,
               htmltools)
