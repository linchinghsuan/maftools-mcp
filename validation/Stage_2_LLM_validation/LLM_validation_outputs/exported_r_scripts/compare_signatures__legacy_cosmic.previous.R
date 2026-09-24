# Auto-exported by Maftools-MCP export_r_script for validation.
# This script was captured from the existing MCP tool implementation.
# MCP tool: compare_signatures
# Underlying R/Maftools function: maftools::compareSignatures
# Effective MCP parameters:
#   extractSignatures_rds = "LLM_validation_outputs/extract_signatures__extractSignatures.rds"
#   sig_db = "legacy"
#   verbose = true
#   output_dir = "LLM_validation_outputs"

library(maftools)

ext <- readRDS("LLM_validation_outputs/extract_signatures__extractSignatures.rds")

comp <- compareSignatures(
    nmfRes = ext,
    sig_db = "legacy",
    verbose = TRUE
)

saveRDS(comp, file="maftools_validation_data/LLM_Stage2_validation/LLM_validation_input_file/LLM_validation_outputs/compareSignatures.rds")
write.table(comp$similarity, file="maftools_validation_data/LLM_Stage2_validation/LLM_validation_input_file/LLM_validation_outputs/similarity_matrix.txt", sep="\t", quote=FALSE)
