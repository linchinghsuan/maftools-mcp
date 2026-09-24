# Auto-exported by Maftools-MCP export_r_script for validation.

# =====================================================================
# TCGA-BRCA: Survival analysis stratified by TP53 mutation status
# Generated to match maftools_plot_maf_survgroup MCP invocation
# =====================================================================

library(maftools)

# ---- Inputs ----------------------------------------------------------
maf_rds_path <- "/Users/linqingxuan/mcp_server/maftools_mcp/src/maftools_mcp/tcga_data/BRCA.rds"
output_dir   <- "/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/prompt_robustness/claude-opus-4.7/case_03/run_01/outputs"

geneSet    <- c("TP53")
time_col   <- "CDR_OS.time"
status_col <- "CDR_OS"

img_width  <- 2600
img_height <- 2000

dir.create(output_dir, showWarnings = FALSE, recursive = TRUE)

# ---- Load MAF object -------------------------------------------------
maf <- readRDS(maf_rds_path)

# ---- Survival analysis: mutated (Geneset) vs WT ----------------------
out_png <- file.path(output_dir, "mafSurvGroup.png")
png(filename = out_png, width = img_width, height = img_height, res = 300)

mafSurvGroup(
  maf     = maf,
  geneSet = geneSet,
  time    = time_col,
  Status  = status_col
)

dev.off()

message("Saved: ", out_png)
