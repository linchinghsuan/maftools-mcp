# Auto-exported by Maftools-MCP export_r_script for validation.
# This script was captured from the existing MCP tool implementation.
# MCP tool: estimate_signatures
# Underlying R/Maftools function: maftools::estimateSignatures
# Effective MCP parameters:
#   trinuc_matrix_rds = "LLM_validation_outputs/trinuc_matrix.rds"
#   nMin = 2
#   nTry = 6
#   nrun = 10
#   pConstant = null
#   verbose = true
#   output_dir = "LLM_validation_outputs"

library(maftools)
library(NMF)

mat <- readRDS("LLM_validation_outputs/trinuc_matrix.rds")

est <- estimateSignatures(
    mat,
    nMin = 2,
    nTry = 6,
    nrun = 10,
    pConstant = NULL,
    verbose = TRUE,
    plotBestFitRes = FALSE
)

saveRDS(est, file="LLM_validation_outputs/estimateSignatures.direct_r.rds")
