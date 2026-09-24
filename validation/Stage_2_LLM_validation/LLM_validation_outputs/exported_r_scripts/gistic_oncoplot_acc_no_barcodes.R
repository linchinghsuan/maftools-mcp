# Auto-exported by Maftools-MCP export_r_script for validation.
# This script was captured from the existing MCP tool implementation.
# MCP tool: gistic_oncoplot
# Underlying R/Maftools function: maftools::gisticOncoPlot
# Effective MCP parameters:
#   gistic_rds_path = "maftools_validation_data/LLM_Stage2_validation/LLM_validation_input_file/ACC_gistic.rds"
#   top = null
#   bands = null
#   showTumorSampleBarcodes = false
#   gene_mar = 5
#   barcode_mar = 6
#   sepwd_genes = 0.5
#   sepwd_samples = 0.25
#   clinicalData_txt = null
#   clinicalFeatures = null
#   sortByAnnotation = false
#   sampleOrder = null
#   annotationColor = null
#   bandsToIgnore = null
#   removeNonAltered = true
#   colors = null
#   SampleNamefontSize = 0.6
#   fontSize = 0.8
#   legendFontSize = 1.2
#   annotationFontSize = 1.2
#   borderCol = "white"
#   bgCol = "#CCCCCC"
#   img_width = 2600
#   img_height = 2000
#   output_dir = "maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs"

library(TCGAgistic)

gistic_obj <- readRDS("maftools_validation_data/LLM_Stage2_validation/LLM_validation_input_file/ACC_gistic.rds")
png("maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/gistic_oncoplot.png", width=2600, height=2000, res=300)
gisticOncoPlot(
    gistic = gistic_obj,
    top = NULL,
    bands = NULL,
    showTumorSampleBarcodes = FALSE,
    gene_mar = 5,
    barcode_mar = 6,
    sepwd_genes = 0.5,
    sepwd_samples = 0.25,
    clinicalData = NULL,
    clinicalFeatures = NULL,
    sortByAnnotation = FALSE,
    sampleOrder = NULL,
    annotationColor = NULL,
    bandsToIgnore = NULL,
    removeNonAltered = TRUE,
    colors = NULL,
    SampleNamefontSize = 0.6,
    fontSize = 0.8,
    legendFontSize = 1.2,
    annotationFontSize = 1.2,
    borderCol = "white",
    bgCol = "#CCCCCC"
)

dev.off()
