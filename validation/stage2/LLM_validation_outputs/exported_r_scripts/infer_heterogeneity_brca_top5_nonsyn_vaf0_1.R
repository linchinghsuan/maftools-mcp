# Auto-exported by Maftools-MCP export_r_script for validation.
# This script was captured from the existing MCP tool implementation.
# MCP tool: infer_heterogeneity
# Underlying R/Maftools function: maftools::inferHeterogeneity
# Effective MCP parameters:
#   maf_path = "maftools_validation_data/LLM_Stage2_validation/LLM_validation_input_file/BRCA.maf"
#   tsb = null
#   top = 5
#   vafCol = null
#   segFile = null
#   ignChr = null
#   minVaf = 0
#   maxVaf = 1
#   useSyn = false
#   dirichlet = false
#   plot_tsb = null
#   genes = null
#   showCNvars = false
#   colors = null
#   output_dir = "maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs"
#   img_width = 2000
#   img_height = 1600

library(maftools)
library(mclust)

maf_obj <- read.maf("maftools_validation_data/LLM_Stage2_validation/LLM_validation_input_file/BRCA.maf")

hetero <- inferHeterogeneity(
    maf = maf_obj,
    tsb = NULL,
    top = 5,
    vafCol = NULL,
    segFile = NULL,
    ignChr = NULL,
    minVaf = 0,
    maxVaf = 1,
    useSyn = FALSE,
    dirichlet = FALSE
)

write.table(
    hetero$clusters,
    file = "maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/heterogeneity_table.tsv",
    sep = "\t",
    quote = FALSE,
    row.names = FALSE
)

png("maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/heterogeneity_clusters.png", width=2000, height=1600, res=300)

plotClusters(
    hetero,
    tsb = NULL,
    genes = NULL,
    showCNvars = FALSE,
    colors = NULL
)

dev.off()
