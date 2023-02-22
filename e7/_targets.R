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
             list.files(here("data"), full.names = TRUE), 
             format = "file"), 
  
  # The output variant call file
  tar_file(vcf_file, 
           here("data", "out.vcf")), 
  
  # LG2 sequence file
  tar_file(sequence_file, 
           here("data", "LG2.fa")),
  
  
  ## Section: Read in data
  ##################################################
  
  # Read in the summary files
  tar_target(output_data, 
             read_output_data(output_files)), 
  
  tar_target(vcf_data, 
             read.vcfR(vcf_file)),
  
  # tar_target(lg2_data, 
  #            ape::read.dna(sequence_file, format = "fasta")),
  # 
  # tar_target(vcf_chrom, 
  #            vcfR::create.chromR(vcf = vcf_data, seq = lg2_data)),
  
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
  
  # make plots
  tar_target(summary_plots, 
             make_summary_plots(plot_ready_data)),
  
  ## Section: Output
  ##################################################
  tar_file(output_subsetted_vcf, 
           export_vcf(nondist_vcf))



)
