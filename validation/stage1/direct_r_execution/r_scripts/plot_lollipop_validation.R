# Auto-exported by Maftools-MCP export_r_script for validation.
# This script was captured from the existing MCP tool implementation.
# MCP tool: plot_lollipop
# Underlying R/Maftools function: maftools::lollipopPlot
# Effective MCP parameters:
#   maf_path = "maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_input_file/BRCA.maf"
#   gene = "TP53"
#   output_dir = "maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_outputs"
#   img_width = 2600
#   img_height = 2000
#   AACol = null
#   labelPos = null
#   labPosSize = 0.9
#   showMutationRate = true
#   showDomainLabel = true
#   cBioPortal = false
#   refSeqID = null
#   proteinID = null
#   roundedRect = true
#   repel = false
#   collapsePosLabel = true
#   showLegend = true
#   legendTxtSize = 0.8
#   labPosAngle = 0
#   domainLabelSize = 0.8
#   axisTextSize = null
#   printCount = false
#   colors = null
#   domainAlpha = 1
#   domainBorderCol = "black"
#   bgBorderCol = "black"
#   labelOnlyUniqueDoamins = true
#   defaultYaxis = false
#   titleSize = null
#   pointSize = 1.5

library(maftools)

maf <- maftools::read.maf("maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_input_file/BRCA.maf")

png("maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_outputs/lollipop_TP53.png", width=2600, height=2000, res=300)

maftools::lollipopPlot(
    maf = maf,
    gene = "TP53",
    AACol = NULL,
    labelPos = NULL,
    labPosSize = 0.9,
    showMutationRate = TRUE,
    showDomainLabel = TRUE,
    cBioPortal = FALSE,
    refSeqID = NULL,
    proteinID = NULL,
    roundedRect = TRUE,
    repel = FALSE,
    collapsePosLabel = TRUE,
    showLegend = TRUE,
    legendTxtSize = 0.8,
    labPosAngle = 0,
    domainLabelSize = 0.8,
    axisTextSize = NULL,
    printCount = FALSE,
    colors = NULL,
    domainAlpha = 1,
    domainBorderCol = "black",
    bgBorderCol = "black",
    labelOnlyUniqueDoamins = TRUE,
    defaultYaxis = FALSE,
    titleSize = NULL,
    pointSize = 1.5
)

dev.off()
