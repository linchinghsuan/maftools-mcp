# Auto-exported by Maftools-MCP export_r_script for validation.
# This script was captured from the existing MCP tool implementation.
# MCP tool: subset_maf
# Underlying R/Maftools function: maftools::subsetMaf
# Effective MCP parameters:
#   maf_path = "maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_input_file/BRCA.maf"
#   tsb = null
#   genes = ["TP53"]
#   query = null
#   clinQuery = null
#   ranges = null
#   mult = "first"
#   fields = null
#   mafObj = true
#   includeSyn = true
#   isTCGA = false
#   dropLevels = true
#   restrictTo = "all"
#   output_dir = "maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_outputs"

library(maftools)

maf_obj <- read.maf("maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_input_file/BRCA.maf")

sub_maf <- subsetMaf(
    maf = maf_obj,
    tsb = NULL,
    genes = c("TP53"),
    query = NULL,
    clinQuery = NULL,
    ranges = NULL,
    mult = "first",
    fields = NULL,
    mafObj = TRUE,
    includeSyn = TRUE,
    isTCGA = FALSE,
    dropLevels = TRUE,
    restrictTo = "all"
)

saveRDS(sub_maf, file="maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_outputs/subset_maf.rds")

if (is(sub_maf, "MAF")) {
    write.table(
        sub_maf@data,
        file="maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_outputs/subset_maf.tsv",
        sep="\t",
        quote=FALSE,
        row.names=FALSE
    )
} else {
    write.table(
        sub_maf,
        file="maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_outputs/subset_maf.tsv",
        sep="\t",
        quote=FALSE,
        row.names=FALSE
    )
}
