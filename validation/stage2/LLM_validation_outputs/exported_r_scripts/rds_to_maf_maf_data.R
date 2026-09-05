# Auto-exported by Maftools-MCP export_r_script for validation.
# This script was captured from the existing MCP tool implementation.
# MCP tool: rds_to_maf
# Underlying R/Maftools function: maftools::if
# Effective MCP parameters:
#   rds_path = "maftools_validation_data/LLM_Stage2_validation/LLM_validation_input_file/maf_data.rds"
#   output_dir = "maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs"
#   basename = "maf_data.direct_r"

maf_obj <- readRDS("maftools_validation_data/LLM_Stage2_validation/LLM_validation_input_file/maf_data.rds")

# Verify this is a MAF object
if (!inherits(maf_obj, "MAF")) {
    stop("Provided RDS is not a maftools::MAF object.")
}

# Export MAF table
write.table(
    maf_obj@data,
    file = "maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/maf_data.direct_r.maf",
    sep = "\t",
    quote = FALSE,
    row.names = FALSE
)
