# Auto-exported by Maftools-MCP export_r_script for validation.
# This script was captured from the existing MCP tool implementation.
# MCP tool: plot_summary
# Underlying R/Maftools function: maftools::plotmafSummary
# Effective MCP parameters:
#   maf_path = "maftools_validation_data/LLM_Stage2_validation/LLM_validation_input_file/BRCA.maf"
#   img_width = 2600
#   img_height = 2000
#   output_dir = "maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs"
#   fs = 1
#   top = 10

library(maftools)

maf <- maftools::read.maf("maftools_validation_data/LLM_Stage2_validation/LLM_validation_input_file/BRCA.maf")

png("maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/plot_summary.png", width=2600, height=2000, res=300)

plotmafSummary(
    maf = maf,
    fs = 1,
    top = 10
)

dev.off()
