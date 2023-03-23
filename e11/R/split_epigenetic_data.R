split_epigenetic_data <- function(cntsMax, merged_epigenetic_data){

    # Get expressed and non-expressed sets of genes
    nonExpressed <- names(cntsMax)[cntsMax < 2]
    Expressed    <- names(cntsMax)[cntsMax >= 2]


    # Get the genes that have epigenetic expression data
    genesWithData <- merged_epigenetic_data %>%
                        dplyr::filter(MethCG != ".") %>%
                        rownames() %>%
                        intersect(names(cntsMax))

    # Subset the cntMax vector and the epiData dataframe
    cntsMax      <- cntsMax[genesWithData]
    epiData      <- merged_epigenetic_data[genesWithData,]
    Expressed    <- intersect(Expressed, genesWithData)
    nonExpressed <- intersect(nonExpressed, genesWithData)

    # Convert all columns in the epiData dataframe to numerics,
    # and fix some outliers in the histone variable
    epiData %<>%
        dplyr::mutate(across(everything(), as.numeric)) %>%
        dplyr::mutate(HistH3K4me3 = ifelse(HistH3K4me3 > 500, 500, HistH3K4me3))

    # Combine cntMax and epidata in a list and return
    res <- list("cntMax"       = cntsMax,
                "epiData"      = epiData,
                "expressed"    = Expressed,
                "nonexpressed" = nonExpressed)

    return(res)
}