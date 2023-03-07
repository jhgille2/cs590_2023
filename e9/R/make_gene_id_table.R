make_gene_id_table <- function(results_paths){

    # Make a table to translate transcript IDs to gene IDs
    q <- read.delim(results_paths[1])

    tx2gene <- data.frame(TXNAME=q$Name,
                     GENEID=sub("(.*)\\.[0-9]+", "\\1", q$Name))

    return(tx2gene)
}