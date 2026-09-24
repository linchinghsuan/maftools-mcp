# Auto-exported by Maftools-MCP export_r_script for validation.
# This script was captured from the existing MCP tool implementation.
# MCP tool: gistic_chrom_plot
# Underlying R/Maftools function: maftools::gisticChromPlot
# Effective MCP parameters:
#   gistic_rds_path = "maftools_validation_data/LLM_Stage2_validation/LLM_validation_input_file/ACC_gistic.rds"
#   fdrCutOff = 0.1
#   markBands = null
#   color = null
#   ref_build = "hg19"
#   cytobandOffset = 0.01
#   txtSize = 0.8
#   cytobandTxtSize = 0.6
#   maf_path = null
#   mutGenes = null
#   y_lims = null
#   mutGenesTxtSize = 0.6
#   img_width = 2600
#   img_height = 2000
#   output_dir = "maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs"

library(TCGAgistic)
library(maftools)

gistic_obj <- readRDS("maftools_validation_data/LLM_Stage2_validation/LLM_validation_input_file/ACC_gistic.rds")

png("maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/gistic_chrom_plot.png", width=2600, height=2000, res=300)

gisticChromPlot(
    gistic = gistic_obj,
    fdrCutOff = 0.1,
    markBands = NULL,
    color = NULL,
    ref.build = "hg19",
    cytobandOffset = 0.01,
    txtSize = 0.8,
    cytobandTxtSize = 0.6,
    maf = NULL,
    mutGenes = NULL,
    y_lims = NULL,
    mutGenesTxtSize = 0.6
)

dev.off()
