## Load your packages, e.g. library(targets).
source("./packages.R")

## Load your R files
lapply(list.files("./R", full.names = TRUE), source)

## tar_plan supports drake-style targets and also tar_target()
tar_plan(

# Download the RNAseq data
tar_target(download_RNAseq,
           download_data(),
           format = "file"),

# Get just the bam files
tar_target(bam_files,
            get_bam_files(download_RNAseq),
            format = "file"),

# The transcript file
tar_target(transcript_file,
            get_transcript_file(download_RNAseq),
            format = "file"),

# RUn salmon for each bam file, output to salmon_out directory
tar_target(salmon_output,
            run_salmon(transcript_file, bam_files), 
            format = "file")


)
