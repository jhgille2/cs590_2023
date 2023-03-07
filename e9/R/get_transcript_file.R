get_transcript_file <- function(download_RNAseq){

    # Get the path to the target transcripts
    download_RNAseq[grepl("TAIR10", download_RNAseq)]

}