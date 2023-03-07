download_data <- function(){

    # Use gdown to download the data for the exercize, unpack the file
    # and then delete the first file that was downloaded
    system("gdown 16osm546AYWSbmtNwHHl5yCyCGRAtWox0")
    system("tar -xzf At_disease_RNAseq.tar.gz")
    system("rm At_disease_RNAseq.tar.gz")

    # Return paths to the files that were downloaded
    return(list.files("./At_disease_RNAseq",
                        recursive = TRUE, 
                        full.names = TRUE))

}