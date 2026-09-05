# Auto-exported by Maftools-MCP export_r_script for validation.
# This script was captured from the existing MCP tool implementation.
# MCP tool: plot_cobarplot
# Underlying R/Maftools function: maftools::coBarplot
# Effective MCP parameters:
#   tcga_rds_path = null
#   user_maf_path = "maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_input_file/cohort1.maf"
#   user_maf_path2 = "maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_input_file/cohort2.maf"
#   output_dir = "maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_outputs"
#   genes = null
#   orderBy = null
#   m1Name = null
#   m2Name = null
#   colors = null
#   normalize = true
#   yLims = null
#   borderCol = "gray"
#   titleSize = 1
#   geneSize = 0.8
#   showPct = true
#   pctSize = 0.7
#   axisSize = 0.8
#   legendTxtSize = 1
#   img_width = 2600
#   img_height = 2000

library(maftools)

# Load m1 and m2 according to mode
m1 <- maftools::read.maf("maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_input_file/cohort1.maf")
m2 <- maftools::read.maf("maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_input_file/cohort2.maf")

png("maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_outputs/plot_cobarplot__coBarplot.png", width=2600, height=2000, res=300)

coBarplot(
    m1 = m1,
    m2 = m2,
    genes = NULL,
    orderBy = NULL,
    m1Name = "Cohort1",
    m2Name = "Cohort2",
    colors = NULL,
    normalize = TRUE,
    yLims = NULL,
    borderCol = "gray",
    titleSize = 1,
    geneSize = 0.8,
    showPct = TRUE,
    pctSize = 0.7,
    axisSize = 0.8,
    legendTxtSize = 1
)

dev.off()
