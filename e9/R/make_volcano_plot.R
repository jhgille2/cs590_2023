make_volcano_plot <- function(res){

outpath <- here::here("plots", "volcano.pdf")

pdf(outpath, width=5, height=5)
plot(res$log2FoldChange, -log10(res$pvalue), 
     col=ifelse(res$padj < 0.01, "red", "black"),
     pch=19,
     xlab="Log2 Fold Change (Inoculated/Control)",
     ylab="-log10 p-value (unadjusted)")
dev.off()


return(outpath)


}