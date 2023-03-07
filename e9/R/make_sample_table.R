make_sample_table <- function(){

    # Make a sample that describes that treatment factors each
    # sample had
    sample_table <- tibble::tibble(sampleID = c(paste0("c", 1:3), paste0("t", 1:3)),                                # nolint: line_length_linter.
                                   condition = ifelse(substr(sampleID, 1, 1) == "c", "control", "innoculated")) %>% # nolint: line_length_linter.
                           as.data.frame()

    return(sample_table)
}