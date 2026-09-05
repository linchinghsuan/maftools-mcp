# Auto-exported by Maftools-MCP export_r_script for validation.
# This script was captured from the existing MCP tool implementation.
# MCP tool: compare_signatures
# Underlying R/Maftools function: maftools::compareSignatures
# Effective MCP parameters:
#   extractSignatures_rds = "maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_outputs/extract_signatures__extractSignatures.rds"
#   sig_db = "legacy"
#   verbose = true
#   output_dir = "maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_outputs"

library(maftools)

ext <- readRDS("maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_outputs/extract_signatures__extractSignatures.rds")

comp <- compareSignatures(
    nmfRes = ext,
    sig_db = "legacy",
    verbose = TRUE
)

saveRDS(comp, file="maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_outputs/compareSignatures.rds")
write.table(comp$similarity, file="maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_outputs/similarity_matrix.txt", sep="\t", quote=FALSE)
