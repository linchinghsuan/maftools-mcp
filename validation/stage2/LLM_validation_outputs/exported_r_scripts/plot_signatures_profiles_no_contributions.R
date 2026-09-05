# Auto-exported by Maftools-MCP export_r_script for validation.
# This script was captured from the existing MCP tool implementation.
# MCP tool: plot_signatures
# Underlying R/Maftools function: maftools::plotSignatures
# Effective MCP parameters:
#   extractSignatures_rds = "maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/extractSignatures.rds"
#   contributions = false
#   font_size = 1.2
#   show_title = true
#   sig_db = "legacy"
#   axis_lwd = 2
#   title_size = 0.9
#   show_barcodes = false
#   yaxisLim = 0.3
#   output_dir = "maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs"
#   img_width = 2600
#   img_height = 2000

library(maftools)

ext <- readRDS("maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/extractSignatures.rds")

png("maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/signature_profiles.png", width=2600, height=2000, res=300)
plotSignatures(
    nmfRes = ext,
    contributions = FALSE,
    font_size = 1.2,
    show_title = TRUE,
    sig_db = "legacy",
    axis_lwd = 2,
    title_size = 0.9,
    show_barcodes = FALSE,
    yaxisLim = 0.3
)
dev.off()
