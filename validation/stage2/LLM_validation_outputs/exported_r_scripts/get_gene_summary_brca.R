# Auto-exported by Maftools-MCP export_r_script for validation.
# This script was captured from the existing MCP tool implementation.
# MCP tool: get_gene_summary
# Underlying R/Maftools function: maftools::getGeneSummary
# Effective MCP parameters:
#   maf_path = "maftools_validation_data/LLM_Stage2_validation/LLM_validation_input_file/BRCA.maf"
#   gistic_rds_path = null
#   output_dir = "maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs"

library(maftools)

maf_obj <- read.maf("maftools_validation_data/LLM_Stage2_validation/LLM_validation_input_file/BRCA.maf")

gene_summary <- getGeneSummary(maf_obj)

write.table(
    gene_summary,
    file="maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/gene_summary.tsv",
    sep="\t",
    quote=FALSE,
    row.names=FALSE
)
