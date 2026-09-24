# Auto-exported by Maftools-MCP export_r_script for validation.
# This script was captured from the existing MCP tool implementation.
# MCP tool: get_clinical_data
# Underlying R/Maftools function: maftools::getClinicalData
# Effective MCP parameters:
#   maf_path = "maftools_validation_data/LLM_Stage2_validation/LLM_validation_input_file/BRCA.rds"
#   output_dir = "maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs"

library(maftools)

maf_obj <- readRDS("maftools_validation_data/LLM_Stage2_validation/LLM_validation_input_file/BRCA.rds")

clin <- getClinicalData(maf_obj)

write.table(
    clin,
    file="maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/clinical_data.tsv",
    sep="\t",
    quote=FALSE,
    row.names=FALSE
)
