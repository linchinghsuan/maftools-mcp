# Auto-exported by Maftools-MCP export_r_script for validation.
# This script was captured from the existing MCP tool implementation.
# MCP tool: get_fields
# Underlying R/Maftools function: maftools::getFields
# Effective MCP parameters:
#   maf_path = "maftools_validation_data/LLM_Stage2_validation/LLM_validation_input_file/BRCA.maf"
#   output_dir = "maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs"

library(maftools)

maf_obj <- read.maf("maftools_validation_data/LLM_Stage2_validation/LLM_validation_input_file/BRCA.maf")

fields <- getFields(maf_obj)

write.table(
    data.frame(Field = fields),
    file="maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/maf_fields.tsv",
    sep="\t",
    quote=FALSE,
    row.names=FALSE,
    col.names=TRUE
)
