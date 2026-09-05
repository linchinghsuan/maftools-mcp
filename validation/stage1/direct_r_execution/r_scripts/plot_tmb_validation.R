# Auto-exported by Maftools-MCP export_r_script for validation.
# This script was captured from the existing MCP tool implementation.
# MCP tool: plot_tmb
# Underlying R/Maftools function: maftools::tmb
# Effective MCP parameters:
#   maf_path = "maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_input_file/BRCA.maf"
#   captureSize = 50
#   logScale = true
#   output_dir = "maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_outputs"
#   img_width = 2600
#   img_height = 2000

library(maftools)

maf <- read.maf("maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_input_file/BRCA.maf")

png("maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_outputs/tmb.png", width=2600, height=2000, res=300)

tmb(
    maf = maf,
    captureSize = 50,
    logScale = TRUE
)

dev.off()
