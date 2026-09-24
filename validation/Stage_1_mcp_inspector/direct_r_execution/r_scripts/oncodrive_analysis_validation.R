# Auto-exported by Maftools-MCP export_r_script for validation.
# This script was captured from the existing MCP tool implementation.
# MCP tool: oncodrive_analysis
# Underlying R/Maftools function: maftools::oncodrive
# Effective MCP parameters:
#   maf_path = "maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_input_file/BRCA.rds"
#   output_dir = "maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_outputs"
#   AACol = null
#   minMut = 5
#   pvalMethod = "zscore"
#   nBgGenes = 100
#   bgEstimate = true
#   ignoreGenes = null
#   fdrCutOff = 1
#   useFraction = false
#   colCode = null
#   bubbleSize = 1
#   labelSize = 1
#   img_width = 2600
#   img_height = 2000

suppressPackageStartupMessages(library(maftools))

invisible(capture.output({
  invisible(capture.output({
    options(warn = -1)

    maf <- readRDS("maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_input_file/BRCA.rds")

    if (!inherits(maf, "MAF")) {
      stop("Input file does not contain a valid MAF object")
    }

    res <- suppressWarnings(oncodrive(
      maf = maf,
      AACol = NULL,
      minMut = 5,
      pvalMethod = "zscore",
      nBgGenes = 100,
      bgEstimate = TRUE,
      ignoreGenes = NULL
    ))

    write.table(as.data.frame(res),
      file = "maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_outputs/oncodrive_result.tsv",
      sep = "\t",
      quote = FALSE,
      row.names = FALSE
    )

    saveRDS(res, file = "maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_outputs/oncodrive_result.rds")

    png("maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_outputs/oncodrive_plot.png", width = 2600, height = 2000, res = 300)

    suppressWarnings(plotOncodrive(
      res = res,
      fdrCutOff = 1,
      useFraction = FALSE,
      colCode = NULL,
      bubbleSize = 1,
      labelSize = 1
    ))

    dev.off()
  }, type = "message"))
}, type = "output"))
