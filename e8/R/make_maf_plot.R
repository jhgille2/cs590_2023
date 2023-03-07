#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title
#' @param maf_data
make_maf_plot <- function(maf_data) {

  maf_data %<>%
    mutate(ALLELE_2_FREQ = as.numeric(ALLELE_2_FREQ))
  
  ggplot(maf_data, aes(x = ALLELE_2_FREQ, y = QUAL)) + 
    geom_point(pch = 19, colour = "darkblue") + 
    theme_gdocs()

}
