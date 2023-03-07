run_salmon <- function(transcript_file, bam_files){

    all_commands <- paste("salmon quant -t", transcript_file,
    "-l U -a", bam_files,
    "-o", paste0("./salmon_out/",  basename(tools::file_path_sans_ext(bam_files))))


    purrr::walk(all_commands, function(x) system(x))

    all_output <- list.files(here::here("salmon_out"),
                            recursive = TRUE,
                            full.names = TRUE)

    return(all_output)
}