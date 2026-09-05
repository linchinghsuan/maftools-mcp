# Auto-exported by Maftools-MCP export_r_script for validation.
# This script was captured from the existing MCP tool implementation.
# MCP tool: plot_apobec_diff
# Underlying R/Maftools function: maftools::plotApobecDiff
# Effective MCP parameters:
#   trinuc_matrix_rds = "maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/signature_enrichment_source__trinuc_matrix.rds"
#   maf_rds = "maftools_validation_data/LLM_Stage2_validation/LLM_validation_input_file/BRCA_clinical_enrichment_validation_subset.rds"
#   pVal = 0.05
#   title_size = 1
#   axis_lwd = 1
#   font_size = 1.2
#   output_dir = "maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs"
#   img_width = 2600
#   img_height = 2000

library(maftools)

maf_obj <- readRDS("maftools_validation_data/LLM_Stage2_validation/LLM_validation_input_file/BRCA_clinical_enrichment_validation_subset.rds")
tnm <- readRDS("maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/signature_enrichment_source__trinuc_matrix.rds")

png("maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/apobec_diff.png", width=2600, height=2000, res=300)

plotApobecDiff(
    tnm = tnm,
    maf = maf_obj,
    pVal = 0.05,
    title_size = 1,
    axis_lwd = 1,
    font_size = 1.2
)

dev.off()
