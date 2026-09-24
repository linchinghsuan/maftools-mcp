# Auto-exported by Maftools-MCP export_r_script for validation.
# This script was captured from the existing MCP tool implementation.
# MCP tool: plot_pfam_domains
# Underlying R/Maftools function: maftools::pfamDomains
# Effective MCP parameters:
#   maf_path = "maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_input_file/BRCA.maf"
#   AACol = "HGVSp_Short"
#   summarizeBy = "AAPos"
#   top = 5
#   domainsToLabel = null
#   baseName = null
#   varClass = "nonSyn"
#   img_width = 2600
#   img_height = 2000
#   width = 5
#   height = 5
#   labelSize = 1
#   output_dir = "maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_outputs"

library(maftools)
maf_obj <- read.maf("maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_input_file/BRCA.maf")
png("maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_outputs/pfam_domains.png", width=2600, height=2000, res=300)
pfamDomains(
    maf = maf_obj,
    AACol = "HGVSp_Short",
    summarizeBy = "AAPos",
    top = 5,
    domainsToLabel = NULL,
    baseName = NULL,
    varClass = "nonSyn",
    width = 5,
    height = 5,
    labelSize = 1
)

dev.off()
