merge_epigenetic_data <- function(files){

    # Read in each of the methylation files, rename the X10 variable with the
    # type of methylation from the file and select just the measurement column
    all_methylation_data <- purrr::map2(files$Methylation, names(files$Methylation),# nolint
                                       function(x, y) read_tsv(x, col_names = FALSE) %>% # nolint
                                                   select(X10) %>%
                                                   rename(!!y := X10))

    # Read in the histone data
    histone_data <- read_tsv(files$Histone, col_names = FALSE)

    # Get the gene names from the histone data
    gene_names <- histone_data$X9 %>%
                    stringr::str_extract("Name=\\s*(.*?)\\s*;") %>%
                    stringr::str_remove("Name=") %>%
                    str_remove(";")

    # Select just the measurement variable from the histone data
    histone_data %<>%
        dplyr::select(X10) %>%
        dplyr::rename(HistH3K4me3 = X10)

    # Combine all the data to one dataframe
    epiData <- dplyr::bind_cols(all_methylation_data, histone_data)

    # Add "Meth" to the start of the methylation column names
    colnames(epiData)[1:3] <- paste0("Meth", colnames(epiData)[1:3])

    # Convert to a data frame and set the rownames to be the gene names
    epiData <- as.data.frame(epiData)
    rownames(epiData) <- gene_names

    # Return the dataframe
    return(epiData)
}