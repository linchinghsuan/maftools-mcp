# Auto-exported by Maftools-MCP export_r_script for validation.
# This script was captured from the existing MCP tool implementation.
# MCP tool: plot_cbs_segments
# Underlying R/Maftools function: maftools::plotCBSsegments
# Effective MCP parameters:
#   cbsFile = "maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_input_file/TCGA.AB.3009.hg19.seg.txt"
#   maf_path = null
#   tsb = "TCGA-AB-3009"
#   output_dir = "maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_outputs"
#   ylims = null
#   seg_size = 0.1
#   genes = null
#   ref_build = "hg19"
#   writeTable = false
#   removeXY = false
#   color = null
#   img_width = 2600
#   img_height = 1200

library(maftools)

maf <- NULL

png("maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_outputs/CBS_segments.png", width=2600, height=1200, res=300)

plotCBSsegments(
    cbsFile = "maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_input_file/TCGA.AB.3009.hg19.seg.txt",
    maf = maf,
    tsb = "TCGA-AB-3009",
    savePlot = FALSE,
    ylims = NULL,
    seg_size = 0.1,
    genes = NULL,
    ref.build = "hg19",
    writeTable = FALSE,
    removeXY = FALSE,
    color = NULL
)

dev.off()
