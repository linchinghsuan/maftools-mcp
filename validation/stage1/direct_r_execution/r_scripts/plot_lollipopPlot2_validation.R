# Auto-exported by Maftools-MCP export_r_script for validation.
# This script was captured from the existing MCP tool implementation.
# MCP tool: plot_lollipopPlot2
# Underlying R/Maftools function: maftools::lollipopPlot2
# Effective MCP parameters:
#   tcga_rds_path = null
#   user_maf_path = "maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_input_file/cohort1.maf"
#   user_maf_path2 = "maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_input_file/cohort2.maf"
#   gene = "TP53"
#   output_dir = "maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_outputs"
#   AACol1 = null
#   AACol2 = null
#   labPosAngle = 0
#   labPosSize = 1.2
#   refSeqID = null
#   proteinID = null
#   colors = null
#   alpha = 1
#   axisTextSize = null
#   pointSize = 1.2
#   roundedRect = true
#   showDomainLabel = true
#   domainBorderCol = "black"
#   domainLabelSize = 1.2
#   legendTxtSize = 1.2
#   verbose = true
#   img_width = 2600
#   img_height = 2000

library(maftools)




m1 <- maftools::read.maf("maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_input_file/cohort1.maf")
m2 <- maftools::read.maf("maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_input_file/cohort2.maf")

png("maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_outputs/lollipop_TP53.png", width=2600, height=2000, res=300)

maftools::lollipopPlot2(
    m1 = m1,
    m2 = m2,
    gene = "TP53",

    AACol1 = NULL,
    AACol2 = NULL,

    m1_name = "Cohort1",
    m2_name = "Cohort2",

    refSeqID = NULL,
    proteinID = NULL,

    labPosAngle = 0,
    labPosSize = 1.2,

    colors = NULL,
    alpha = 1,

    axisTextSize = NULL,
    pointSize = 1.2,

    roundedRect = TRUE,
    showDomainLabel = TRUE,

    domainBorderCol = "black",
    domainLabelSize = 1.2,

    legendTxtSize = 1.2,

    verbose = TRUE
)

dev.off()
