# Auto-exported by Maftools-MCP export_r_script for validation.

#!/usr/bin/env Rscript
# ============================================================
# TCGA-BRCA Overall Survival Analysis grouped by TP53 mutation
# ============================================================
# This script reproduces the maftools mafSurvGroup analysis
# for TCGA-BRCA samples grouped by TP53 mutation status.

suppressPackageStartupMessages({
  library(maftools)
})

# ----- Inputs -----
maf_rds_path <- "/Users/linqingxuan/mcp_server/maftools_mcp/src/maftools_mcp/tcga_data/BRCA.rds"
output_dir   <- "/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/prompt_robustness/claude-opus-4.7/case_03/run_05/outputs"
geneSet      <- c("TP53")
time_col     <- "CDR_OS.time"
status_col   <- "CDR_OS"

dir.create(output_dir, showWarnings = FALSE, recursive = TRUE)

# ----- Load MAF object -----
maf_obj <- readRDS(maf_rds_path)

# ----- Survival analysis by TP53 mutation status -----
out_png <- file.path(output_dir, "mafSurvGroup.png")
png(filename = out_png, width = 2000, height = 2000, res = 300)

mafSurvGroup(
  maf     = maf_obj,
  geneSet = geneSet,
  time    = time_col,
  Status  = status_col
)

dev.off()

cat("Survival plot saved to:", out_png, "\n")
