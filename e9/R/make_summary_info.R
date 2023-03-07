make_summary_info <- function(res){

    # Order the results by adjusted p value
    resOrdered <- res[order(res$padj),]

    # Significant up and down-regulated gene counts
    sig_upregulated   <- sum(res$padj < 0.01 & res$log2FoldChange > 0, na.rm = TRUE)
    sig_downregulated <- sum(res$padj < 0.01 & res$log2FoldChange < 0, na.rm = TRUE)

    # Second most significant gene
    second_most_sig <- resOrdered[2, ]

    # COmbine everything into a list
    summary_list <- list("Number significantly upregulated" = sig_upregulated, 
                         "Number significantly downregulated" = sig_downregulated, 
                         "Second most significant p value" = second_most_sig)

    # Return the list
    return(summary_list)
}