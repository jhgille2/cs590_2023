#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title
#' @param allele_freq_data
#' @param snp_quality_data
make_maf_df <- function(allele_freq_data, snp_quality_data) {

  allele_freq_data %>% 
    select(CHROM, POS, ALLELE_2_FREQ) %>% 
    left_join(snp_quality_data, by = c("CHROM", "POS"))

}
