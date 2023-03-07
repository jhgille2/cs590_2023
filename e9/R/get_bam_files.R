get_bam_files <- function(dir = here("At_disease_RNAseq")){

    # Get the paths to just the .bam files and return them
    bam_files <- dir[which(tools::file_ext(dir) == "bam")]

    return(bam_files)
}