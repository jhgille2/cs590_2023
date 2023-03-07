## Load your packages, e.g. library(targets).
source("./packages.R")

## Load your R files
lapply(list.files("./R", full.names = TRUE), source)

## tar_plan supports drake-style targets and also tar_target()
tar_plan(

# Download the RNAseq data
tar_files(download_RNAseq,
           download_data()),

# Get just the bam files
tar_files(bam_files,
         get_bam_files(download_RNAseq)),

# The transcript file
tar_files(transcript_file,
            get_transcript_file(download_RNAseq)),

# Run salmon for each bam file, output to salmon_out directory
tar_target(salmon_output,
            run_salmon(transcript_file, bam_files),
            pattern = map(bam_files),
            format = "file"),

# Get all "quant.sf" files that were output by salmon
tar_target(results_paths,
           get_quant_files(salmon_output),
           format = "file"),

# Prepare a data.frame that connects transcript IDs to gene IDs
tar_target(tx2gene,
            make_gene_id_table(results_paths)),

# Read in salmon reports
tar_target(txi,
            tximport(results_paths,
                     type = "salmon",
                     tx2gene = tx2gene)),

# Sample info data frame
tar_target(sample_info,
           make_sample_table()),

# Test for differentially expressed genes
tar_target(dds,
           DESeqDataSetFromTximport(txi = txi,
                                    colData = sample_info,
                                    design = formula("~condition")) %>%
            DESeq()),

# Extract results from the tests
tar_target(res,
            results(dds)),

# Make a volcano plot of the results
tar_target(volcano_plot,
            make_volcano_plot(res)),

# Summary info for the exercize
tar_target(summary_info,
            make_summary_info(res))


)
