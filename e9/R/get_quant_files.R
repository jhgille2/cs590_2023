get_quant_files <- function(salmon_output){

    # Get paths to all the quant.sf files that were
    # output from salmon
    quant_paths <- grepl("quant.sf", salmon_output)

    return(salmon_output[quant_paths])
}