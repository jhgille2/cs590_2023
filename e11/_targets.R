## Load your packages, e.g. library(targets).
source("./packages.R")

## Load your R files
lapply(list.files("./R", full.names = TRUE), source)

## tar_plan supports drake-style targets and also tar_target()
tar_plan(

# The maize annotations file
tar_file(maize_annotations,
         here::here("data", "ZmB73_5a.59_WGS.gff3")),

# histone/methylation modifications files
tar_file(histone_bed_file,
         here::here("data",
                    "Epigenetic_Data",
                    "B73_Chr1_Histone_H3K4me3.bed")),

tar_file(methylation_bed_file,
         replace_methyl_chr_name()),

# RNA seq file
tar_file(rna_seq_file,
         here::here("data",
                    "Epigenetic_Data",
                    "B73_RNAseq_Data_WGS.csv")),

# Sort the annotations file to keep only genes
tar_file(gene_annotations,
         filter_annotations_file(maize_annotations)),

# Sort the annotations file
tar_file(sorted_annotations,
         sort_annotations(gene_annotations)),

# Map the histone and methylation files to the gene annotations
tar_file(histones_mapped,
         map_to_bed(sorted_annotations,
                    bed_file = histone_bed_file,
                    col      = 4,
                    outtype  = "sum",
                    outfile  = here::here("B73_Mapped_Histones.tsv"))),

tar_file(methylation_CG_mapped,
         map_to_bed(sorted_annotations,
                    bed_file = methylation_bed_file,
                    col      = 4,
                    outtype  = "mean",
                    outfile  = here::here("B73_Mapped_Methyl_CG.tsv"))),

tar_file(methylation_CHG_mapped,
         map_to_bed(sorted_annotations,
                    bed_file = methylation_bed_file,
                    col      = 5,
                    outtype  = "mean",
                    outfile  = here::here("B73_Mapped_Methyl_CHG.tsv"))),

tar_file(methylation_CHH_mapped,
         map_to_bed(sorted_annotations,
                    bed_file = methylation_bed_file,
                    col      = 6,
                    outtype  = "mean",
                    outfile  = here::here("B73_Mapped_Methyl_CHH.tsv"))),

# COmbine all the methylation files into a list
tar_target(all_methylation_files,
           list("CG"  = methylation_CG_mapped,
                "CHG" = methylation_CHG_mapped,
                "CHH" = methylation_CHH_mapped)),

# Read in the rna seq data
tar_target(rna_seq_data,
           read_csv(rna_seq_file)),


# SECTION: Analysis

# Get the column with the maximum expression value
# for each gene in the rna seq data
tar_target(cntsMax,
           get_max_counts(rna_seq_data)),

# Make a plot of the counts
tar_file(cntsPlot,
           make_count_plot(cntsMax)),

# Merge the methylation and histone data
tar_target(merged_epigenetic_data,
           merge_epigenetic_data(files = list("Methylation" = all_methylation_files, # nolint
                                              "Histone"     = histones_mapped))),    # nolint

# Filter the max counts vector, and epigenetic dataframes
# down to sets that actually have data
tar_target(filtered_epigenetic_data,
           split_epigenetic_data(cntsMax, merged_epigenetic_data)),

# Make boxplots of the expressed and non-expressed genes
tar_file(epigenetic_boxplots,
           make_epigenetic_boxplots(filtered_epigenetic_data)),

# Make a scatterplot of expressed CHG genes vs log2 of the rnaseq counts
tar_file(expression_scatterplot,
         make_expressed_scatterplot(filtered_epigenetic_data, cntsMax))

)
