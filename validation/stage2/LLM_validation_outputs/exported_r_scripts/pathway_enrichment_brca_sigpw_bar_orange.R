# Auto-exported by Maftools-MCP export_r_script for validation.
# This script was captured from the existing MCP tool implementation.
# MCP tool: pathway_enrichment
# Underlying R/Maftools function: maftools::pathways
# Effective MCP parameters:
#   maf_path = "maftools_validation_data/LLM_Stage2_validation/LLM_validation_input_file/BRCA.maf"
#   pathdb = "sigpw"
#   pathways = null
#   fontSize = 1
#   panelWidths = null
#   plotType = "bar"
#   col = "orange"
#   output_dir = "maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs"
#   img_width = 2600
#   img_height = 2000

library(maftools)

maf <- read.maf("maftools_validation_data/LLM_Stage2_validation/LLM_validation_input_file/BRCA.maf")

png("maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/pathways_plot.png", width=2600, height=2000, res=300)

pw <- pathways(
    maf = maf,
    pathdb = "sigpw",
    pathways = NULL,
    fontSize = 1,
    panelWidths = NULL,
    plotType = "bar",
    col = "orange"
)

dev.off()

write.table(
    pw,
    file = "maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/pathways_enrichment.tsv",
    sep = "\t",
    quote = FALSE,
    row.names = FALSE
)
