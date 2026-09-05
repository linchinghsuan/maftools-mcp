# Auto-exported by Maftools-MCP export_r_script for validation.
# This script was captured from the existing MCP tool implementation.
# MCP tool: drug_interactions
# Underlying R/Maftools function: maftools::drugInteractions
# Effective MCP parameters:
#   maf_path = "maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_input_file/BRCA.maf"
#   top = 20
#   genes = null
#   plotType = "bar"
#   drugs = false
#   fontSize = 0.8
#   output_dir = "maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_outputs"
#   img_width = 2600
#   img_height = 2000

library(maftools)

maf_obj <- read.maf("maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_input_file/BRCA.maf")
png("maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_outputs/drug_interactions.png", width=2600, height=2000, res=300)
drugInteractions(
    maf = maf_obj,
    top = 20,
    genes = NULL,
    plotType = "bar",
    drugs = FALSE,
    fontSize = 0.8
)

dev.off()
