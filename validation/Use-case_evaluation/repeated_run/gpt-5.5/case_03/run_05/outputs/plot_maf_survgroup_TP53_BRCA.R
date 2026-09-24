library(maftools)

maf_rds_path <- "/Users/linqingxuan/mcp_server/maftools_mcp/src/maftools_mcp/tcga_data/BRCA.rds"
output_dir <- "/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/gpt-5.5/case_03/run_05/outputs"
output_png <- file.path(output_dir, "mafSurvGroup.png")

brca_maf <- readRDS(maf_rds_path)

png(filename = output_png, width = 2600, height = 2000, res = 300)
plotmafSurvGroup(
  maf = brca_maf,
  geneSet = c("TP53"),
  time = "CDR_OS.time",
  Status = "CDR_OS"
)
dev.off()
