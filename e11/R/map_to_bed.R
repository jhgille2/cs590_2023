map_to_bed <- function(sorted_annotations, bed_file, outfile, col, outtype){

    cmd <- paste("bedtools map -a",
                 sorted_annotations,
                 "-b", bed_file,
                 "-c", col, "-o", outtype, "> ", outfile)

    system(cmd)

    return(outfile)
}