#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title
#' @param onemap_vcf
make_linkage_map <- function(onemap_vcf) {

  # Get nondistorted markers
  onemap_segreg_test <- test_segregation(onemap_vcf)
  seg_marks <- select_segreg(onemap_segreg_test, numbers = TRUE)
  
  # Calculate two-point recombination freqs
  recomb_freq <- rf_2pts(onemap_vcf)
  non_dist_marks <- make_seq(recomb_freq, seg_marks)
  
  # Group markers into LGs
  LGs <- group(non_dist_marks)
  set_map_fun(type = "kosambi")
  
  # Make a seq object from LG1 (there's only 1 LG)
  LG_1 <- make_seq(LGs, 1)
  
  # Order the markers
  marker_map <- order_seq(LG_1)

  # Return the final order
  return(marker_mark)
}
