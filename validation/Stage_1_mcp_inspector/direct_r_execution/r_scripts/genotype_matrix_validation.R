# Auto-exported by Maftools-MCP export_r_script for validation.
# This script was captured from the existing MCP tool implementation.
# MCP tool: genotype_matrix
# Underlying R/Maftools function: maftools::genotypeMatrix
# Effective MCP parameters:
#   maf_path = "maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_input_file/BRCA.maf"
#   genes = ["TP53", "PIK3CA", "GATA3"]
#   tsb = null
#   includeSyn = false
#   vafCol = null
#   vafCutoff = null
#   output_dir = "maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_outputs"

library(maftools)

maf_obj <- read.maf("maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_input_file/BRCA.maf")

gmat <- genotypeMatrix(
    maf = maf_obj,
    genes = c("TP53","PIK3CA","GATA3"),
    tsb = NULL,
    includeSyn = FALSE,
    vafCol = NULL,
    vafCutoff = NULL
)

write.table(
    gmat,
    file="maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_outputs/genotype_matrix.tsv",
    sep="\t",
    quote=FALSE,
    row.names=TRUE,
    col.names=NA
)
