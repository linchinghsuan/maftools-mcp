# Auto-exported by Maftools-MCP export_r_script for validation.
# This script was captured from the existing MCP tool implementation.
# MCP tool: plot_maf_survgroup
# Underlying R/Maftools function: maftools::mafSurvGroup
# Effective MCP parameters:
#   maf_rds_path = "maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_input_file/BRCA.rds"
#   geneSet = ["TP53"]
#   time_col = "CDR_OS.time"
#   status_col = "CDR_OS"
#   output_dir = "maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_outputs"
#   img_width = 2600
#   img_height = 2000

library(maftools)

maf <- readRDS("maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_input_file/BRCA.rds")

png("maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_outputs/mafSurvGroup.png", width=2600, height=2000, res=300)

mafSurvGroup(
    maf = maf,
    geneSet = c("TP53"),
    time = "CDR_OS.time",
    Status = "CDR_OS"
)

dev.off()
