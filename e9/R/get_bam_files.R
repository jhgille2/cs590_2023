get_bam_files <- function(dir = here("At_disease_RNAseq")){

    bam_files <- dir[which(tools::file_ext(dir) == "bam")]

    return(bam_files)
}