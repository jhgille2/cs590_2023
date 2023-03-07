# Install pacman if it does not already exist
if(!require(pacman)){
  install.packages("pacman")
}

# Use pacman to load/install packages

# Workflow management
pacman::p_load(conflicted,
               dotenv,
               targets,
               tarchetypes,
               here)

# Data wrangling
pacman::p_load(dplyr,
               purrr,
               magrittr,
               tools,
               tibble,
               htmltools)

# Analysis
pacman::p_load(tximport,
               DESeq2)

