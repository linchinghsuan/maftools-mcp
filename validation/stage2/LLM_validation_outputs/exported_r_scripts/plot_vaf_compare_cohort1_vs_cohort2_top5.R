# Auto-exported by Maftools-MCP export_r_script for validation.
# This script was captured from the existing MCP tool implementation.
# MCP tool: plot_vaf_compare
# Underlying R/Maftools function: maftools::vafCompare
# Effective MCP parameters:
#   maf1_path = "maftools_validation_data/LLM_Stage2_validation/LLM_validation_input_file/cohort1.maf"
#   maf2_path = "maftools_validation_data/LLM_Stage2_validation/LLM_validation_input_file/cohort2.maf"
#   output_dir = "maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs"
#   genes = null
#   top = 5
#   vafCol1 = null
#   vafCol2 = null
#   m1Name = "M1"
#   m2Name = "M2"
#   cols = null
#   sigvals = true
#   nrows = null
#   ncols = null
#   img_width = 2600
#   img_height = 1800

library(maftools)

m1 <- maftools::read.maf("maftools_validation_data/LLM_Stage2_validation/LLM_validation_input_file/cohort1.maf")
m2 <- maftools::read.maf("maftools_validation_data/LLM_Stage2_validation/LLM_validation_input_file/cohort2.maf")

png("maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/vaf_compare.png", width=2600, height=1800, res=300)

vafCompare(
    m1 = m1,
    m2 = m2,
    genes = NULL,
    top = 5,
    vafCol1 = NULL,
    vafCol2 = NULL,
    m1Name = "M1",
    m2Name = "M2",
    cols = NULL,
    sigvals = TRUE,
    nrows = NULL,
    ncols = NULL
)

dev.off()
