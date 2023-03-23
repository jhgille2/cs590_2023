replace_methyl_chr_name <- function(){

    cmd <- paste("sed -i 's/chr1/Chr1/g'",
                 here::here("data", "Epigenetic_Data", "B73_Chr1_MethylationWindows.bed")) # nolint

    system(cmd)

    return(here::here("data", "Epigenetic_Data", "B73_Chr1_MethylationWindows.bed")) # nolint
}