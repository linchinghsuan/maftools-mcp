# TP53 Overall-Survival Group Comparison for TCGA-BRCA
# Reproduces the maftools-mcp `plot_maf_survgroup` workflow.

suppressPackageStartupMessages({
  library(maftools)
})

# ---- Inputs ----------------------------------------------------------------
maf_rds_path <- "/Users/linqingxuan/mcp_server/maftools_mcp/src/maftools_mcp/tcga_data/BRCA.rds"
output_dir   <- "/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/opencode_claude-opus-4.7/case_03/run_02/outputs"
geneSet      <- c("TP53")
time_col     <- "CDR_OS.time"
status_col   <- "CDR_OS"

dir.create(output_dir, showWarnings = FALSE, recursive = TRUE)

# ---- Load MAF --------------------------------------------------------------
maf <- readRDS(maf_rds_path)

# ---- Survival Group Comparison --------------------------------------------
out_png <- file.path(output_dir, "mafSurvGroup.png")
png(out_png, width = 2000, height = 2000, res = 300)

mafSurvGroup(
  maf      = maf,
  geneSet  = geneSet,
  time     = time_col,
  Status   = status_col
)

dev.off()

message("Survival plot saved to: ", out_png)
