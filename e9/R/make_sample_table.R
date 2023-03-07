make_sample_table <- function(){

    sample_table <- tibble::tibble(sampleID = c(paste0("c", 1:3), paste0("t", 1:3)), 
                           condition = ifelse(substr(sampleID, 1, 1) == "c", "control", "innoculated")) %>% 
                           as.data.frame()

    return(sample_table)
}