# Auto-exported by Maftools-MCP export_r_script for validation.
# This script was captured from the existing MCP tool implementation.
# MCP tool: plot_cophenetic
# Underlying R/Maftools function: maftools::plotCophenetic
# Effective MCP parameters:
#   estimateSignatures_rds = "maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/estimateSignatures.rds"
#   output_dir = "maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs"
#   img_width = 2600
#   img_height = 2000

library(maftools)

est <- readRDS("maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/estimateSignatures.rds")

png("maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/cophenetic_plot.png", width=2600, height=2000, res=300)
plotCophenetic(res = est, bestFit = NULL)
dev.off()
