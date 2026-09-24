# Auto-exported by Maftools-MCP export_r_script for validation.
# This script was captured from the existing MCP tool implementation.
# MCP tool: plot_maf_survgroup
# Underlying R/Maftools function: maftools::mafSurvGroup
# Effective MCP parameters:
#   maf_rds_path = "/Users/linqingxuan/mcp_server/maftools_mcp/src/maftools_mcp/tcga_data/BRCA.rds"
#   geneSet = ["TP53"]
#   time_col = "CDR_OS.time"
#   status_col = "CDR_OS"
#   output_dir = "/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/prompt_robustness/gemini-3.1-flash-lite/case_03/run_01/outputs"
#   img_width = 2600
#   img_height = 2000

library(maftools)

maf <- readRDS("/Users/linqingxuan/mcp_server/maftools_mcp/src/maftools_mcp/tcga_data/BRCA.rds")

png("/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/prompt_robustness/gemini-3.1-flash-lite/case_03/run_01/outputs/mafSurvGroup.png", width=2600, height=2000, res=300)

mafSurvGroup(
    maf = maf,
    geneSet = c("TP53"),
    time = "CDR_OS.time",
    Status = "CDR_OS"
)

dev.off()
