download_data <- function(){

    system("gdown 16osm546AYWSbmtNwHHl5yCyCGRAtWox0")
    system("tar -xzf At_disease_RNAseq.tar.gz")
    system("rm At_disease_RNAseq.tar.gz")

    return(list.files("./At_disease_RNAseq",
    recursive = TRUE, 
    full.names = TRUE))

}