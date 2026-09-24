# Auto-exported by Maftools-MCP export_r_script for validation.
# This script was captured from the existing MCP tool implementation.
# MCP tool: math_score
# Underlying R/Maftools function: maftools::math.score
# Effective MCP parameters:
#   maf_path = "maftools_validation_data/LLM_Stage2_validation/LLM_validation_input_file/BRCA.maf"
#   vafCol = null
#   sampleName = null
#   vafCutOff = 0.075
#   output_dir = "maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs"

library(maftools)

maf <- read.maf("maftools_validation_data/LLM_Stage2_validation/LLM_validation_input_file/BRCA.maf")
maf_data <- maf@data

# ---- Auto compute VAF column if missing ----
if (!is.null(NULL) && !(NULL %in% colnames(maf_data))) {

    maf_data$t_alt_count <- suppressWarnings(as.numeric(maf_data$t_alt_count))
    maf_data$t_ref_count <- suppressWarnings(as.numeric(maf_data$t_ref_count))

    maf_data$t_vaf <- maf_data$t_alt_count /
                      (maf_data$t_alt_count + maf_data$t_ref_count)

    maf@data <- maf_data

    message("VAF column not found. Auto-generated t_vaf using counts.")
}

# ---- run MATH score ----
math_res <- math.score(
    maf = maf,
    vafCol = NULL,
    sampleName = NULL,
    vafCutOff = 0.075
)

# normalize to data.frame
if (is.data.frame(math_res)) {
    out_df <- math_res
} else {
    out_df <- as.data.frame(math_res)
}

write.table(
    out_df,
    file="maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/math_score.tsv",
    sep="\t",
    quote=FALSE,
    row.names=FALSE
)
