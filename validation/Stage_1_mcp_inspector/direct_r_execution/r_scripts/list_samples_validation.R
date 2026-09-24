# Auto-exported by Maftools-MCP export_r_script for validation.
# This script was captured from the existing MCP tool implementation.
# MCP tool: list_samples
# Underlying R/Maftools function: Unable to determine from captured R script
# Effective MCP parameters:
#   maf_path = "maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_input_file/BRCA.maf"
#   output_file = "maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_outputs/list_samples__sample_list.txt"

maf <- maftools::read.maf("maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_input_file/BRCA.maf")
samples <- unique(maf@data$Tumor_Sample_Barcode)

write.table(
    samples,
    file = "maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_outputs/list_samples__sample_list.txt",
    quote = FALSE,
    row.names = FALSE,
    col.names = FALSE
)
