# Auto-exported by Maftools-MCP export_r_script for validation.
# This script was captured from the existing MCP tool implementation.
# MCP tool: genes_to_barcodes
# Underlying R/Maftools function: maftools::genesToBarcodes
# Effective MCP parameters:
#   maf_path = "maftools_validation_data/LLM_Stage2_validation/LLM_validation_input_file/BRCA.maf"
#   genes = ["TP53"]
#   justNames = false
#   verbose = true
#   output_dir = "maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs"

library(maftools)

maf_obj <- read.maf("maftools_validation_data/LLM_Stage2_validation/LLM_validation_input_file/BRCA.maf")

result <- genesToBarcodes(
    maf = maf_obj,
    genes = c("TP53"),
    justNames = FALSE,
    verbose = TRUE
)

# Save native R object
saveRDS(result, file="maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/genes_to_barcodes.rds")

# Normalize to data.frame for TSV export
if (is.character(result)) {
    out_df <- data.frame(Tumor_Sample_Barcode = result)
} else {
    out_df <- as.data.frame(result)
}

write.table(
    out_df,
    file="maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/genes_to_barcodes.tsv",
    sep="\t",
    quote=FALSE,
    row.names=FALSE
)
