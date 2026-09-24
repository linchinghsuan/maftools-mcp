# Auto-exported by Maftools-MCP export_r_script for validation.
# This script was captured from the existing MCP tool implementation.
# MCP tool: estimate_signatures
# Underlying R/Maftools function: maftools::estimateSignatures
# Effective MCP parameters:
#   trinuc_matrix_rds = "maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_input_file/trinucleotide_matrix_trinuc_matrix.rds"
#   nMin = 2
#   nTry = 6
#   nrun = 10
#   pConstant = null
#   verbose = true
#   output_dir = "maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_outputs"

library(maftools)
library(NMF)

mat <- readRDS("maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_input_file/trinucleotide_matrix_trinuc_matrix.rds")

est <- estimateSignatures(
    mat,
    nMin = 2,
    nTry = 6,
    nrun = 10,
    pConstant = NULL,
    verbose = TRUE,
    plotBestFitRes = FALSE
)

saveRDS(est, file="maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_outputs/estimateSignatures.rds")
