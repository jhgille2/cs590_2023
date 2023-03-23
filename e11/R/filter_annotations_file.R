filter_annotations_file <- function(maize_annotations){
    cmd <- paste("awk '$3 ~ /gene/ { print $0 }'",
                 maize_annotations,
                 "> ZmB73_WGS_GenesOnly.gff3")

    system(cmd)

    return(here::here("ZmB73_WGS_GenesOnly.gff3"))
}