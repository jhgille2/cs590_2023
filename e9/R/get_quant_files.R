get_quant_files <- function(salmon_output){

    quant_paths <- grepl("quant.sf", salmon_output)

    return(salmon_output[quant_paths])
}