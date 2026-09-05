# Auto-exported by Maftools-MCP export_r_script for validation.
# This script was captured from the existing MCP tool implementation.
# MCP tool: load_tcga_gistic
# Underlying R/Maftools function: maftools::tcga_gistic_load
# Effective MCP parameters:
#   cancer_name = "ACC"
#   copy_number_level = "all"
#   output_dir = "maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_outputs/tcga_gistic"

library(TCGAgistic)

gistic_obj <- tcga_gistic_load(
    cohort = "ACC",
    source = "Firehose",
    cnLevel = "all",
    verbose = FALSE
)

saveRDS(gistic_obj, file = "maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_outputs/tcga_gistic/ACC_gistic_all.rds")
