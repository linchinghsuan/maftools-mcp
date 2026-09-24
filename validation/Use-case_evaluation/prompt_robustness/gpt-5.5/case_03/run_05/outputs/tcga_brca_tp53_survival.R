# Auto-exported by Maftools-MCP export_r_script for validation.

library(maftools)

maf_rds_path <- "/Users/linqingxuan/mcp_server/maftools_mcp/src/maftools_mcp/tcga_data/BRCA.rds"
output_dir <- "/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/prompt_robustness/gpt-5.5/case_03/run_05/outputs"

dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)

brca <- readRDS(maf_rds_path)

png(
  filename = file.path(output_dir, "mafSurvGroup.png"),
  width = 2600,
  height = 2000,
  res = 300
)

mafSurvGroup(
  maf = brca,
  geneSet = c("TP53"),
  time = "CDR_OS.time",
  Status = "CDR_OS"
)

dev.off()
