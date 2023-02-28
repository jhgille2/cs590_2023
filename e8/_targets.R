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
  
  ## Section: Data wrangling
  ##################################################
  
  # Dataframe of maf vs quality
  tar_target(maf_data, 
             make_maf_df(allele_freq_data, snp_quality_data)), 
  
  # Matrix of seq names
  tar_target(seq_names_matrix, 
             make_seq_names_matrix(seq_data))

)
