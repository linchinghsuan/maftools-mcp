# Auto-exported by Maftools-MCP export_r_script for validation.
# This script was captured from the existing MCP tool implementation.
# MCP tool: compare_maf_forestplot
# Underlying R/Maftools function: maftools::mafCompare
# Effective MCP parameters:
#   tcga_rds_path = null
#   user_maf_path = "maftools_validation_data/LLM_Stage2_validation/LLM_validation_input_file/cohort1.maf"
#   user_maf_path2 = "maftools_validation_data/LLM_Stage2_validation/LLM_validation_input_file/cohort2.maf"
#   output_dir = "maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs"
#   geneFontSize = 1.0
#   titleSize = 1.5
#   lineWidth = 1.5
#   minMut = 5
#   pVal = 0.1
#   img_width = 2600
#   img_height = 2000

library(maftools)

# Load cohorts
m1 <- maftools::read.maf('maftools_validation_data/LLM_Stage2_validation/LLM_validation_input_file/cohort1.maf'); m2 <- maftools::read.maf('maftools_validation_data/LLM_Stage2_validation/LLM_validation_input_file/cohort2.maf')

# Run mafCompare
cmp <- mafCompare(
    m1 = m1,
    m2 = m2,
    m1Name = "Cohort1",
    m2Name = "Cohort2",
    minMut = 5
)

# Create forest plot
png("maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/forestPlot.png", width=2600, height=2000, res=300)
forestPlot(
    mafCompareRes = cmp,
    pVal = 0.1,
    geneFontSize = 1.0,
    titleSize = 1.5,
    lineWidth = 1.5
)
dev.off()
