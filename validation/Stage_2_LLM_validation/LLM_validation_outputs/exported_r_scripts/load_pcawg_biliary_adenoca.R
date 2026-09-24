# Auto-exported by Maftools-MCP export_r_script for validation.
# This script was captured from the existing MCP tool implementation.
# MCP tool: load_pcawg_data
# Underlying R/Maftools function: PCAWGmutations::pcawg_load
# Effective MCP parameters:
#   cancer_name = "Biliary-AdenoCA"

suppressPackageStartupMessages(library(PCAWGmutations))
suppressPackageStartupMessages(library(maftools))

# use positional argument (no 'cohort=')
maf_obj <- PCAWGmutations::pcawg_load("Biliary-AdenoCA")

saveRDS(maf_obj, file = "maftools_validation_data/LLM_Stage2_validation/LLM_validation_input_file/pcawg_data/Biliary-AdenoCA.rds")

maf_tbl <- maf_obj@data
write.table(
  maf_tbl,
  file = "maftools_validation_data/LLM_Stage2_validation/LLM_validation_input_file/pcawg_data/Biliary-AdenoCA.maf",
  sep = "\t",
  quote = FALSE,
  row.names = FALSE
)
