# Auto-exported by Maftools-MCP export_r_script for validation.
# This script was captured from the existing MCP tool implementation.
# MCP tool: plot_vaf
# Underlying R/Maftools function: maftools::plotVaf
# Effective MCP parameters:
#   maf_path = "maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_input_file/BRCA.maf"
#   vafCol = "t_vaf"
#   genes = null
#   top = 10
#   orderByMedian = true
#   keepGeneOrder = false
#   flip = false
#   fn = null
#   gene_fs = 0.8
#   axis_fs = 0.8
#   height = 5
#   width = 5
#   showN = true
#   color = null
#   vaf_cutoff = 0
#   output_dir = "maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_outputs"

library(maftools)

maf <- read.maf("maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_input_file/BRCA.maf")
maf_data <- maf@data

# ---- Compute VAF if missing ----
if (!("t_vaf" %in% colnames(maf_data))) {
    maf_data$t_alt_count <- suppressWarnings(as.numeric(maf_data$t_alt_count))
    maf_data$t_ref_count <- suppressWarnings(as.numeric(maf_data$t_ref_count))

    maf_data$t_vaf <- maf_data$t_alt_count /
                      (maf_data$t_alt_count + maf_data$t_ref_count)

    maf@data <- maf_data
}

# ---- Apply VAF cutoff ----
if (0 > 0) {
    maf_data <- maf@data
    maf_data <- maf_data[ maf_data$t_vaf > 0, ]
    maf@data <- maf_data
}

# ---- Plot ----
png("maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_outputs/vaf_plot.png", width = 1500, height = 1500, res = 300)

maftools::plotVaf(
    maf = maf,
    vafCol = "t_vaf",
    genes = NULL,
    top = 10,
    orderByMedian = TRUE,
    keepGeneOrder = FALSE,
    flip = FALSE,
    fn = NULL,
    gene_fs = 0.8,
    axis_fs = 0.8,
    height = 5,
    width = 5,
    showN = TRUE,
    color = NULL
)

dev.off()
