estimate_signatures_rds <- "LLM_validation_outputs/estimate_signatures__estimateSignatures.rds"
output_png <- "LLM_validation_outputs/cophenetic_correlation_elbow_plot.direct_r.png"

estimate_signatures <- readRDS(estimate_signatures_rds)

png(filename = output_png, width = 7, height = 7, units = "in", res = 300)
maftools::plotCophenetic(res = estimate_signatures)
dev.off()
