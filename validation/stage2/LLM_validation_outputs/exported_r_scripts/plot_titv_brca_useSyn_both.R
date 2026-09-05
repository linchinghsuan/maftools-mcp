# Auto-exported by Maftools-MCP export_r_script for validation.
# This script was captured from the existing MCP tool implementation.
# MCP tool: plot_titv
# Underlying R/Maftools function: maftools::titv
# Effective MCP parameters:
#   maf_path = "maftools_validation_data/LLM_Stage2_validation/LLM_validation_input_file/BRCA.maf"
#   useSyn = true
#   plotType = "both"
#   sampleOrder = null
#   color = null
#   showBarcodes = false
#   textSize = 0.8
#   baseFontSize = 1.0
#   axisTextSize = null
#   plotNotch = false
#   img_width = 2600
#   img_height = 2000
#   output_dir = "maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs"

library(maftools)

maf <- read.maf("maftools_validation_data/LLM_Stage2_validation/LLM_validation_input_file/BRCA.maf")

# calculate TiTv matrix
titv_res <- maftools::titv(
    maf = maf,
    plot = FALSE,
    useSyn = TRUE
)

png("maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/titv_plot.png", width=2600, height=2000, res=300)
maftools::plotTiTv(
    res = titv_res,
    plotType = "both",
    sampleOrder = NULL,
    color = NULL,
    showBarcodes = FALSE,
    textSize = 0.8,
    baseFontSize = 1.0,
    axisTextSize = NULL,
    plotNotch = FALSE
)
dev.off()
