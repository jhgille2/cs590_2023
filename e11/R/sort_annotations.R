sort_annotations <- function(gene_annotations){
    cmd <- paste(here::here("code", "gff3sort", "gff3sort.pl"),
                 "--precise --chr_order natural",
                 gene_annotations,
                 "> ZmB73_WGS_GenesOnly_Sorted.gff3")

    system(cmd)

    return(here::here("ZmB73_WGS_GenesOnly_Sorted.gff3"))
}