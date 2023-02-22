#' .. content for \description{} (no empty lines) ..
#'
#' .. content for \details{} ..
#'
#' @title
#' @param nondist_vcf
export_vcf <- function(nondist_vcf) {

  outpath <- here("exports", "out_filtered.vcf.gz")
  
  write.vcf(nondist_vcf, 
            file = outpath)
  
  return(outpath)

}
