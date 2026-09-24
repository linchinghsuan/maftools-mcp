# Auto-exported by Maftools-MCP export_r_script for validation.
# This script was captured from the existing MCP tool implementation.
# MCP tool: extract_signatures
# Underlying R/Maftools function: maftools::extractSignatures
# Effective MCP parameters:
#   trinuc_matrix_rds = "maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_input_file/trinucleotide_matrix_trinuc_matrix.rds"
#   n = 6
#   parallel = 4
#   pConstant = null
#   output_dir = "maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_outputs"

library(maftools)
library(NMF)

mat <- readRDS("maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_input_file/trinucleotide_matrix_trinuc_matrix.rds")

ext <- extractSignatures(
    mat,
    n = 6,
    plotBestFitRes = FALSE,
    parallel = 4,
    pConstant = NULL
)

saveRDS(ext, file="maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_outputs/extractSignatures.rds")
saveRDS(ext$signatures, file="maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_outputs/signatures.rds")
saveRDS(ext$contributions, file="maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_outputs/contributions.rds")
