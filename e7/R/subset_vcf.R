#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title
#' @param nonseg_marks
#' @param vcf_data
subset_vcf <- function(nonseg_marks, vcf_data) {

  # Subset the vcf_data so that only the segregating, biallelic markers are kept
  vcf_data[match(nonseg_marks, rownames(extract.gt(vcf_data))), ]

}
