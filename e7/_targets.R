## Load your packages, e.g. library(targets).
source("./packages.R")

## Load your R files
lapply(list.files("./R", full.names = TRUE), source)

## tar_plan supports drake-style targets and also tar_target()
tar_plan(
  
  # Files output from exercize 7
  tar_target(output_files, 
             list.files(here("data"), full.names = TRUE), 
             format = "file"), 
  
  # Read in the files
  tar_target(output_data, 
             read_output_data(output_files)), 
  
  # Clean up the output data for plotting
  tar_target(plot_ready_data, 
             prep_plot_data(output_data)), 
  
  # make plots
  tar_target(summary_plots, 
             make_summary_plots(plot_ready_data))



)
