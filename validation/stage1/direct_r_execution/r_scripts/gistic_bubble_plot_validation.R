# Auto-exported by Maftools-MCP export_r_script for validation.
# This script was captured from the existing MCP tool implementation.
# MCP tool: gistic_bubble_plot
# Underlying R/Maftools function: maftools::gisticBubblePlot
# Effective MCP parameters:
#   gistic_rds_path = "maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_input_file/ACC_gistic.rds"
#   color = null
#   markBands = null
#   fdrCutOff = 0.1
#   log_y = true
#   txtSize = 3
#   output_dir = "maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_outputs"
#   img_width = 2600
#   img_height = 2000

library(TCGAgistic)
library(maftools)
gistic_obj <- readRDS("maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_input_file/ACC_gistic.rds")

png("maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_outputs/gistic_bubble_plot.png", width=2600, height=2000, res=300)

gisticBubblePlot(
    gistic = gistic_obj,
    color = NULL,
    markBands = NULL,
    fdrCutOff = 0.1,
    log_y = TRUE,
    txtSize = 3
)

dev.off()
