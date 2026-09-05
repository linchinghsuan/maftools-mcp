# Auto-exported by Maftools-MCP export_r_script for validation.
# This script was captured from the existing MCP tool implementation.
# MCP tool: plot_rainfall
# Underlying R/Maftools function: maftools::rainfallPlot
# Effective MCP parameters:
#   maf_path = "maftools_validation_data/LLM_Stage2_validation/LLM_validation_input_file/BRCA.maf"
#   sample = "TCGA-3C-AAAU-01A-11D-A41F-09"
#   output_dir = "maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs"
#   img_width = 2600
#   img_height = 2000
#   detectChangePoints = false
#   color = null
#   savePlot = true
#   width = 6
#   height = 3
#   fontSize = 1.2
#   pointSize = 0.4

library(maftools)

maf <- maftools::read.maf("maftools_validation_data/LLM_Stage2_validation/LLM_validation_input_file/BRCA.maf")

png("maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/rainfall_TCGA-3C-AAAU-01A-11D-A41F-09.png", width=2600, height=2000, res=300)

maftools::rainfallPlot(
    maf = maf,
    tsb = "TCGA-3C-AAAU-01A-11D-A41F-09",
    detectChangePoints = FALSE,
    color = NULL,
    savePlot = TRUE,
    width = 6,
    height = 3,
    fontSize = 1.2,
    pointSize = 0.4
)

dev.off()
