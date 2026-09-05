# Auto-exported by Maftools-MCP export_r_script for validation.
# This script was captured from the existing MCP tool implementation.
# MCP tool: signature_enrichment
# Underlying R/Maftools function: maftools::signatureEnrichment
# Effective MCP parameters:
#   maf_rds = "maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_input_file/BRCA_clinical_enrichment_validation_subset.rds"
#   sig_res_rds = "maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_input_file/signature_enrichment_source__extractSignatures.rds"
#   minMut = 5
#   useCNV = false
#   output_dir = "maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_outputs"

library(maftools)

maf_obj <- readRDS("maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_input_file/BRCA_clinical_enrichment_validation_subset.rds")
sig_res <- readRDS("maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_input_file/signature_enrichment_source__extractSignatures.rds")

png("maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_outputs/signature_enrichment.png", width = 1800, height = 1400, res = 300)

signatureEnrichment(
    maf = maf_obj,
    sig_res = sig_res,
    minMut = 5,
    useCNV = FALSE
)

dev.off()
