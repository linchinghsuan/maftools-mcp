# Auto-exported by Maftools-MCP export_r_script for validation.
# This script was captured from the existing MCP tool implementation.
# MCP tool: oncodrive
# Underlying R/Maftools function: maftools::oncodrive
# Effective MCP parameters:
#   maf_path = "maftools_validation_data/LLM_Stage2_validation/LLM_validation_input_file/BRCA.rds"
#   AACol = null
#   minMut = 5
#   pvalMethod = "zscore"
#   nBgGenes = 100
#   bgEstimate = true
#   ignoreGenes = null
#   output_dir = "maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs"

suppressPackageStartupMessages(library(maftools))

invisible(capture.output({
  invisible(capture.output({
    options(warn = -1)

    maf <- readRDS("maftools_validation_data/LLM_Stage2_validation/LLM_validation_input_file/BRCA.rds")

    if (!inherits(maf, "MAF")) {
      stop("Input file does not contain a valid MAF object")
    }

    od <- suppressWarnings(oncodrive(
      maf = maf,
      AACol = NULL,
      minMut = 5,
      pvalMethod = "zscore",
      nBgGenes = 100,
      bgEstimate = TRUE,
      ignoreGenes = NULL
    ))

    write.table(
      as.data.frame(od),
      file = "maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/oncodrive.tsv",
      sep = "\t",
      quote = FALSE,
      row.names = FALSE
    )
  }, type = "message"))
}, type = "output"))
