# Auto-exported by Maftools-MCP export_r_script for validation.
# This script was captured from the existing MCP tool implementation.
# MCP tool: get_sample_summary
# Underlying R/Maftools function: maftools::getSampleSummary
# Effective MCP parameters:
#   maf_path = "maftools_validation_data/LLM_Stage2_validation/LLM_validation_input_file/BRCA.maf"
#   gistic_rds_path = null
#   output_dir = "maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs"

library(maftools)

maf_obj <- read.maf("maftools_validation_data/LLM_Stage2_validation/LLM_validation_input_file/BRCA.maf")
sample_summary <- getSampleSummary(maf_obj)

write.table(
    sample_summary,
    file="maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/sample_summary.tsv",
    sep="\t",
    quote=FALSE,
    row.names=FALSE
)
