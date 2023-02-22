#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title
#' @param onemap_vcf
get_nondist_markers <- function(onemap_vcf) {

  onemap::test_segregation(onemap_vcf) %>% 
    select_segreg(.)

}
