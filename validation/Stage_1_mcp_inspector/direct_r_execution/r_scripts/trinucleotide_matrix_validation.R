# Auto-exported by Maftools-MCP export_r_script for validation.
# This script was captured from the existing MCP tool implementation.
# MCP tool: trinucleotide_matrix
# Underlying R/Maftools function: maftools::trinucleotideMatrix
# Effective MCP parameters:
#   maf_path = "maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_input_file/BRCA_subset_trinucleotide_.maf"
#   ref_genome = "BSgenome.Hsapiens.UCSC.hg19"
#   prefix = "chr"
#   add = true
#   ignoreChr = null
#   useSyn = true
#   fn = null
#   output_dir = "maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_outputs"

library(maftools)
maf_obj <- read.maf("maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_input_file/BRCA_subset_trinucleotide_.maf")

mat <- trinucleotideMatrix(
    maf = maf_obj,
    ref_genome = "BSgenome.Hsapiens.UCSC.hg19",
    prefix = "chr",
    add = TRUE,
    ignoreChr = NULL,
    useSyn = TRUE,
    fn = NULL
)

saveRDS(mat, file="maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_outputs/trinuc_matrix.rds")
