# Auto-exported by Maftools-MCP export_r_script for validation.
# This script was captured from the existing MCP tool implementation.
# MCP tool: plot_lollipop
# Underlying R/Maftools function: maftools::lollipopPlot
# Effective MCP parameters:
#   maf_path = "/Users/linqingxuan/mcp_server/maftools_mcp/src/maftools_mcp/tcga_data/BRCA.maf"
#   gene = "TP53"
#   output_dir = "/Users/linqingxuan/maftools_validation_data/use_case_test/validation_results/gpt-5.5/case_05_single_top_label/run_03/outputs"
#   img_width = 3600
#   img_height = 2600
#   AACol = "HGVSp_Short"
#   labelPos = [273]
#   labPosSize = 0.5
#   showMutationRate = true
#   showDomainLabel = true
#   cBioPortal = false
#   refSeqID = null
#   proteinID = null
#   roundedRect = true
#   repel = true
#   collapsePosLabel = true
#   showLegend = true
#   legendTxtSize = 0.35
#   labPosAngle = 45
#   domainLabelSize = 0.5
#   axisTextSize = null
#   printCount = true
#   colors = null
#   domainAlpha = 1
#   domainBorderCol = "black"
#   bgBorderCol = "black"
#   labelOnlyUniqueDoamins = true
#   defaultYaxis = false
#   titleSize = null
#   pointSize = 1.2

library(maftools)

maf <- maftools::read.maf("/Users/linqingxuan/mcp_server/maftools_mcp/src/maftools_mcp/tcga_data/BRCA.maf")

png("/Users/linqingxuan/maftools_validation_data/use_case_test/validation_results/gpt-5.5/case_05_single_top_label/run_03/outputs/lollipop_TP53.png", width=3600, height=2600, res=300)

maftools::lollipopPlot(
    maf = maf,
    gene = "TP53",
    AACol = "HGVSp_Short",
    labelPos = c(273),
    labPosSize = 0.5,
    showMutationRate = TRUE,
    showDomainLabel = TRUE,
    cBioPortal = FALSE,
    refSeqID = NULL,
    proteinID = NULL,
    roundedRect = TRUE,
    repel = TRUE,
    collapsePosLabel = TRUE,
    showLegend = TRUE,
    legendTxtSize = 0.35,
    labPosAngle = 45,
    domainLabelSize = 0.5,
    axisTextSize = NULL,
    printCount = TRUE,
    colors = NULL,
    domainAlpha = 1,
    domainBorderCol = "black",
    bgBorderCol = "black",
    labelOnlyUniqueDoamins = TRUE,
    defaultYaxis = FALSE,
    titleSize = NULL,
    pointSize = 1.2
)

dev.off()
