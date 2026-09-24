# Auto-exported by Maftools-MCP export_r_script for validation.

library(maftools)

# Load the BRCA MAF object
brca_maf <- readRDS("/Users/linqingxuan/mcp_server/maftools_mcp/src/maftools_mcp/tcga_data/BRCA.rds")

# Perform Survival Analysis
maftools::mafSurvGroup(
  maf = brca_maf,
  geneSet = "TP53",
  timeColumn = "CDR_OS.time",
  StatusColumn = "CDR_OS",
  col = c("#a50f15", "#08519c")
)
