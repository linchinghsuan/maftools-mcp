# Auto-exported by Maftools-MCP export_r_script for validation.
# This script was captured from the existing MCP tool implementation.
# MCP tool: list_genes
# Underlying R/Maftools function: Unable to determine from captured R script
# Effective MCP parameters:
#   maf_path = "maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_input_file/BRCA.maf"
#   output_file = "maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_outputs/list_genes__gene_list.txt"

maf <- maftools::read.maf("maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_input_file/BRCA.maf")
genes <- unique(maf@data$Hugo_Symbol)
write.table(genes, file="maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_outputs/list_genes__gene_list.txt", quote=FALSE,
            row.names=FALSE, col.names=FALSE)
