## Load your packages, e.g. library(targets).
source("./packages.R")

## Load your R files
lapply(list.files("./R", full.names = TRUE), source)

## tar_plan supports drake-style targets and also tar_target()
tar_plan(
  
  
  ## Section: File paths
  ##################################################
  
  # Files output from exercize 7
  tar_target(output_files, 
             list.files(here("data", "non_filtered", "summary_files"), full.names = TRUE), 
             format = "file"), 
  
  # Summary files for filtered vcf
  tar_target(filtered_output_files, 
             list.files(here("data", "filtered"), full.names = TRUE), 
             format = "file"),
  
  # The output variant call file
  tar_file(vcf_file, 
           here("data", "non_filtered", "out.vcf")), 
  
  # LG2 sequence file
  tar_file(sequence_file, 
           here("data", "non_filtered", "LG2.fa")),
  
  
  ## Section: Read in data
  ##################################################
  
  # Read in the summary files
  tar_target(output_data, 
             read_output_data(file_paths = output_files)), 
  
  # And the filtered summary files
  tar_target(filtered_output_data, 
             read_output_data(file_paths = filtered_output_files)),
  
  # Read in the vcf data
  tar_target(vcf_data, 
             read.vcfR(vcf_file)),

  
  # Read in the vcf file to a onemap  object
  tar_target(onemap_vcf, 
             onemap_read_vcfR(vcf     = vcf_file, 
                              parent1 = "female", 
                              parent2 = "male", 
                              cross   = "outcross")),

  
  ## Section: Analysis
  ##################################################
  
  # Keep only non-distorted markers
  tar_target(nonseg_marks, 
             get_nondist_markers(onemap_vcf)),
  
  # Subset the vcf and keep only the nondistorted markers
  tar_target(nondist_vcf, 
             subset_vcf(nonseg_marks, vcf_data)),
  
  # Clean up the output data for plotting
  tar_target(plot_ready_data, 
             prep_plot_data(output_data)), 
  
  tar_target(plot_ready_filtered, 
             prep_plot_data(filtered_output_data)),
  
  
  # Make plots
  tar_target(summary_plots, 
             make_summary_plots(plot_ready_data)),
  
  tar_target(filtered_summary_plots, 
             make_summary_plots(plot_ready_filtered)),
  
  tar_target(filter_comparison, 
             compare_output_data(output_data, filtered_output_data)),
  
  tar_target(all_plots_comparison, 
             compare_all_plots(summary_plots, filtered_summary_plots)),
  
  ## Section: Output
  ##################################################
  tar_file(output_subsetted_vcf, 
           export_vcf(nondist_vcf))

)
