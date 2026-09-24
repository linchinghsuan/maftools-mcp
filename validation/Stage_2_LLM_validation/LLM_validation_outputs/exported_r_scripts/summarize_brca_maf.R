# Auto-exported by Maftools-MCP export_r_script for validation.
# This script was captured from the existing MCP tool implementation.
# MCP tool: summarize_maf
# Underlying R/Maftools function: maftools::getSampleSummary
# Effective MCP parameters:
#   maf_path = "maftools_validation_data/LLM_Stage2_validation/LLM_validation_input_file/BRCA.maf"

maf <- maftools::read.maf("maftools_validation_data/LLM_Stage2_validation/LLM_validation_input_file/BRCA.maf")
sink("summary.txt")
print(maftools::getSampleSummary(maf))
sink()
