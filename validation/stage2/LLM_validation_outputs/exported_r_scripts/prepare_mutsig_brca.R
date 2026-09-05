# Auto-exported by Maftools-MCP export_r_script for validation.
# This script was captured from the existing MCP tool implementation.
# MCP tool: prepare_mutsig
# Underlying R/Maftools function: maftools::prepareMutSig
# Effective MCP parameters:
#   maf_path = "maftools_validation_data/LLM_Stage2_validation/LLM_validation_input_file/BRCA.maf"
#   output_maf = "maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/BRCA.prepare_mutsig.direct_r.maf"

library(maftools)

maf <- read.maf("maftools_validation_data/LLM_Stage2_validation/LLM_validation_input_file/BRCA.maf")

msg <- capture.output(
    maf2 <- prepareMutSig(maf, fn = "maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/BRCA.prepare_mutsig.direct_r.maf")
)

list(
    message = paste(msg, collapse="\n"),
    out = "maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/BRCA.prepare_mutsig.direct_r.maf"
)
