#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title
#' @param seq_data
make_seq_names_matrix <- function(seq_data) {

  tempSplits <- strsplit(names(seq_data),split="|",fixed=T)
  
  purrr::reduce(tempSplits, rbind)

}
