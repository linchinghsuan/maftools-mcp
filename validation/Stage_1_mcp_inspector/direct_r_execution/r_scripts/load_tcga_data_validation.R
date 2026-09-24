# Auto-exported by Maftools-MCP export_r_script for validation.
# This script was captured from the existing MCP tool implementation.
# MCP tool: load_tcga_data
# Underlying R/Maftools function: TCGAmutations::tcga_load
# Effective MCP parameters:
#   cancer_name = "COAD"

suppressPackageStartupMessages(library(TCGAmutations))
suppressPackageStartupMessages(library(maftools))

maf_obj <- TCGAmutations::tcga_load(study = "COAD")

# 1) save RDS (keeps full MAF object: slots, annotations, etc.)
saveRDS(maf_obj, file = "maftools_validation_data/LLM_Stage2_validation/LLM_validation_input_file/COAD.rds")

# 2) save as .maf (write the underlying MAF data table)
maf_tbl <- maf_obj@data

write.table(
  maf_tbl,
  file = "maftools_validation_data/LLM_Stage2_validation/LLM_validation_input_file/COAD.maf",
  sep = "\t",
  quote = FALSE,
  row.names = FALSE
)
