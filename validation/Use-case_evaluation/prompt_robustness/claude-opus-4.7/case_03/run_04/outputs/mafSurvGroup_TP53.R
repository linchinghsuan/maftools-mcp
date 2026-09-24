# Auto-exported by Maftools-MCP export_r_script for validation.

# =============================================================
# TCGA-BRCA: Overall Survival Stratified by TP53 Mutation Status
# =============================================================
# This script reproduces the survival analysis performed via
# maftools-mcp's `plot_maf_survgroup` tool.
#
# Inputs:
#   - TCGA-BRCA MAF RDS object (loaded via TCGAmutations / maftools-mcp)
#
# Output:
#   - mafSurvGroup.png : Kaplan-Meier curve comparing TP53-mutant
#     vs TP53 wild-type BRCA samples with p-value and hazard ratio.
# =============================================================

# -------- Load required libraries --------
library(maftools)

# -------- Set paths --------
maf_rds_path <- "/Users/linqingxuan/mcp_server/maftools_mcp/src/maftools_mcp/tcga_data/BRCA.rds"
output_dir   <- "/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/prompt_robustness/claude-opus-4.7/case_03/run_04/outputs"

if (!dir.exists(output_dir)) {
  dir.create(output_dir, recursive = TRUE)
}

# -------- Load the TCGA-BRCA MAF object --------
maf <- readRDS(maf_rds_path)

# -------- Overall survival analysis stratified by TP53 mutation --------
# TCGA clinical data uses CDR_OS (event) and CDR_OS.time (time in days)
out_png <- file.path(output_dir, "mafSurvGroup.png")

png(filename = out_png, width = 2000, height = 2000, res = 300)
mafSurvGroup(
  maf       = maf,
  geneSet   = c("TP53"),
  time      = "CDR_OS.time",
  Status    = "CDR_OS"
)
dev.off()

cat("Survival plot saved to:", out_png, "\n")
