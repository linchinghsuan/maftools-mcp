# Auto-exported by Maftools-MCP export_r_script for validation.
# MCP tool: plot_maf_survgroup
# Effective MCP parameters:
# maf_rds_path = /Users/linqingxuan/mcp_server/maftools_mcp/src/maftools_mcp/tcga_data/BRCA.rds
# geneSet = ["TP53"]
# time_col = CDR_OS.time
# status_col = CDR_OS
# img_width = 2600
# img_height = 2000

library(maftools)
maf <- readRDS("/Users/linqingxuan/mcp_server/maftools_mcp/src/maftools_mcp/tcga_data/BRCA.rds")
png("mafSurvGroup.png", width=2600, height=2000, res=300)
mafSurvGroup(maf=maf, geneSet=c("TP53"), time="CDR_OS.time", Status="CDR_OS")
dev.off()
