get_max_counts <- function(rna_seq_data){

    rna_seq_data %<>%
        mutate(across(2:10, as.numeric))

    counts_matrix <- as.matrix(rna_seq_data[, 2:10])

    # Get the max value for each row
    max_values <- counts_matrix[cbind(c(1:nrow(counts_matrix)), max.col(counts_matrix))]
    names(max_values) <- as.character(unlist(rna_seq_data[, 1]))

    return(max_values)
}