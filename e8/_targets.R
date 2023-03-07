## Load your packages, e.g. library(targets).
source("./packages.R")

## Load your R files
lapply(list.files("./R", full.names = TRUE), source)

## tar_plan supports drake-style targets and also tar_target()
tar_plan(
  
  
  ## Section: File paths
  ##################################################
  # Path to the allele frequency file
  tar_target(allele_freq_file, 
           here("data", "SNP_Counts.frq.count"), 
           format = "file"), 
  
  # SNP quality data file
  tar_target(snp_quality_file, 
           here("data", "SNP_Qual.lqual"), 
           format = "file"),
  
  # Gene model file
  tar_target(gene_model_file, 
             here("data", "Araport11_cds_20220914_representative_gene_model"), 
             format = "file"),
  
  # World ag data
  tar_target(agdata_file, 
             here("data", "WorldAgData.csv"), 
             format = "file"),
  
  ## Section: Read in data
  ##################################################
  
  # Read in the allele frequency file
  tar_target(allele_freq_data, 
             read_allele_freq(allele_freq_file)),
  
  # Read in the SNP quality data
  tar_target(snp_quality_data, 
             read_delim(snp_quality_file, 
                        delim = "\t")), 
  
  # Sequence data
  tar_target(seq_data, 
             readDNAStringSet(gene_model_file)),
  
  # World ag data
  tar_target(agData, 
             read_csv(agdata_file)),
  
  ## Section: Data wrangling
  ##################################################
  
  # Dataframe of maf vs quality
  tar_target(maf_data, 
             make_maf_df(allele_freq_data, snp_quality_data)), 
  
  # MAF plot
  tar_target(maf_plot, 
             make_maf_plot(maf_data)),
  
  # Matrix of seq names
  tar_target(seq_names_matrix, 
             make_seq_names_matrix(seq_data)), 
  
  
  # Get just the genes that are encoded in the 
  # chloroplast genome
  tar_target(chloroIndices, 
             get_chloroIndices(seq_data, seq_names_matrix)),
  
  # Write the chloroplast genes to a new fasta file
  tar_target(chloro_fasta_export, 
             export_chloro_genes(chloroIndices), 
             format = "file"),
  
  # Make a plot of the agData data
  tar_target(agData_plot, 
             make_agData_plot(agData), 
             format = "file")

)
