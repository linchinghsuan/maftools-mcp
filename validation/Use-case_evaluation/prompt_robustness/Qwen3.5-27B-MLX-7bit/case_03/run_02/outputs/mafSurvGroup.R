# Auto-exported by Maftools-MCP export_r_script for validation.

# Auto-exported by Maftools-MCP
# MCP tool: plot_maf_survgroup
# Underlying R/Maftools function: maftools::mafSurvGroup

library(maftools)

# Load TCGA-BRCA MAF object
maf <- readRDS("/Users/linqingxuan/mcp_server/maftools_mcp/src/maftools_mcp/tcga_data/BRCA.rds")

# Generate survival plot for TP53 mutation status
png("/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/prompt_robustness/Qwen3.5-27B-MLX-7bit/case_03/run_02/outputs/mafSurvGroup.png", width=2600, height=2000, res=300)

mafSurvGroup(
    maf = maf,
    geneSet = c("TP53"),
    time = "CDR_OS.time",
    Status = "CDR_OS"
)

dev.off()