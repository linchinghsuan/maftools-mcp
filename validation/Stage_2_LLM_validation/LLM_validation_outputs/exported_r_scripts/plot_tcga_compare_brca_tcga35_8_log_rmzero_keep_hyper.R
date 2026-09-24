# Auto-exported by Maftools-MCP export_r_script for validation.
# This script was captured from the existing MCP tool implementation.
# MCP tool: plot_tcga_compare
# Underlying R/Maftools function: maftools::tcgaCompare
# Effective MCP parameters:
#   maf_path = "maftools_validation_data/LLM_Stage2_validation/LLM_validation_input_file/BRCA.maf"
#   capture_size = null
#   tcga_capture_size = 35.8
#   cohortName = null
#   tcga_cohorts = null
#   primarySite = false
#   col = ["gray70", "black"]
#   bg_col = ["#EDF8B1", "#2C7FB8"]
#   medianCol = "red"
#   decreasing = false
#   logscale = true
#   rm_hyper = false
#   rm_zero = true
#   cohortFontSize = 0.8
#   axisFontSize = 0.8
#   output_dir = "maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs"
#   img_width = 2600
#   img_height = 2000

library(maftools)

maf <- maftools::read.maf("maftools_validation_data/LLM_Stage2_validation/LLM_validation_input_file/BRCA.maf")

png("maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/tcga_compare.png", width=2600, height=2000, res=300)

maftools::tcgaCompare(
    maf = maf,
    capture_size = NULL,
    tcga_capture_size = 35.8,
    cohortName = NULL,
    tcga_cohorts = NULL,
    primarySite = FALSE,
    col = c("gray70","black"),
    bg_col = c("#EDF8B1","#2C7FB8"),
    medianCol = "red",
    decreasing = FALSE,
    logscale = TRUE,
    rm_hyper = FALSE,
    rm_zero = TRUE,
    cohortFontSize = 0.8,
    axisFontSize = 0.8
)

dev.off()
