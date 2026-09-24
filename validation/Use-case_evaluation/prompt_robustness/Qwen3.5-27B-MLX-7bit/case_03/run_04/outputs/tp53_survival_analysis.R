# Auto-exported by Maftools-MCP export_r_script for validation.

# TP53 Survival Analysis - TCGA-BRCA
# Stratify samples by TP53 mutation status and evaluate overall survival differences

library(maftools)

# Load TCGA-BRCA MAF data
maf <- readRDS("/Users/linqingxuan/mcp_server/maftools_mcp/src/maftools_mcp/tcga_data/BRCA.rds")

# Survival analysis for TP53-mutated vs wild-type samples
png("/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/prompt_robustness/Qwen3.5-27B-MLX-7bit/case_03/run_04/outputs/tp53_survival_plot.png", 
    width=2600, height=2000, res=300)

mafSurvGroup(
    maf = maf,
    geneSet = c("TP53"),
    time = "CDR_OS.time",
    Status = "CDR_OS"
)

dev.off()
