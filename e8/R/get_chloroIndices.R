#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title
#' @param seq_data
#' @param seq_names_matrix
get_chloroIndices <- function(seq_data, seq_names_matrix) {

  # Indices of chloroplast genes
  chloroIndices <- grep("ATC", seq_names_matrix[, 1])

  chloro_seqs <- seq_data[chloroIndices]
  
  return(chloro_seqs)
}
