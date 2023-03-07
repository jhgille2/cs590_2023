run_salmon <- function(transcript_file, bam_files){

    # Make the current command
    current_command <- paste("salmon quant -t", transcript_file,
    "-l U -a", bam_files,
    "-o", paste0("./salmon_out/",  basename(tools::file_path_sans_ext(bam_files))))

    # Run the current command
    system(current_command)

    # List all the output files from the command that just ran
    all_output <- list.files(here::here("salmon_out", basename(tools::file_path_sans_ext(bam_files))),
                            recursive = TRUE,
                            full.names = TRUE)

    # Return the paths to all of the output files
    return(all_output)
}