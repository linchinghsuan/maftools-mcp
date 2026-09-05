# Auto-exported by Maftools-MCP export_r_script for validation.
# This script was captured from the existing MCP tool implementation.
# MCP tool: filter_maf
# Underlying R/Maftools function: maftools::filterMaf
# Effective MCP parameters:
#   maf_path = "maftools_validation_data/LLM_Stage2_validation/LLM_validation_input_file/BRCA.maf"
#   genes = true
#   tsb = null
#   isTCGA = false
#   output_dir = "maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs"

library(maftools)

maf_obj <- read.maf("maftools_validation_data/LLM_Stage2_validation/LLM_validation_input_file/BRCA.maf")

filtered <- filterMaf(
    maf = maf_obj,
    genes = TRUE,
    tsb = NULL,
    isTCGA = FALSE
)

saveRDS(filtered, file="maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/filtered_maf.rds")

write.table(
    filtered@data,
    file="maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/filtered_maf.tsv",
    sep="\t",
    quote=FALSE,
    row.names=FALSE
)
