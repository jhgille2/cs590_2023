#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title
#' @param chloroIndices
export_chloro_genes <- function(chloroIndices) {

  outpath <- here("export", "chloro.fasta")
  writeXStringSet(chloroIndices, outpath)
  
  return(outpath)

}
