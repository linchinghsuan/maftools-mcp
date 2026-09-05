# Auto-exported by Maftools-MCP export_r_script for validation.
# This script was captured from the existing MCP tool implementation.
# MCP tool: mutcount_matrix
# Underlying R/Maftools function: maftools::mutCountMatrix
# Effective MCP parameters:
#   maf_path = "maftools_validation_data/LLM_Stage2_validation/LLM_validation_input_file/BRCA.maf"
#   includeSyn = false
#   countOnly = null
#   removeNonMutated = true
#   output_dir = "maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs"

library(maftools)

maf <- read.maf("maftools_validation_data/LLM_Stage2_validation/LLM_validation_input_file/BRCA.maf")

mat <- mutCountMatrix(
    maf = maf,
    includeSyn = FALSE,
    countOnly = NULL,
    removeNonMutated = TRUE
)

write.table(
    mat,
    file = "maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/mutcount_matrix.tsv",
    sep = "\t",
    quote = FALSE,
    row.names = TRUE,
    col.names = NA
)
