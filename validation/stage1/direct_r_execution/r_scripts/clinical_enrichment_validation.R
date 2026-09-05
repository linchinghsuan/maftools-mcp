# Auto-exported by Maftools-MCP export_r_script for validation.
# This script was captured from the existing MCP tool implementation.
# MCP tool: clinical_enrichment
# Underlying R/Maftools function: maftools::clinicalEnrichment
# Effective MCP parameters:
#   maf_path = "maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_input_file/BRCA_clinical_enrichment_validation_subset.rds"
#   clinicalFeature = "breast_carcinoma_estrogen_receptor_status"
#   clinicalData = null
#   annotationDat = null
#   minMut = 3
#   useCNV = true
#   pVal = 0.05
#   cols = null
#   annoFontSize = 0.8
#   geneFontSize = 0.8
#   legendFontSize = 0.8
#   showTitle = true
#   output_dir = "maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_outputs"

library(maftools)

maf_obj <- readRDS("maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_input_file/BRCA_clinical_enrichment_validation_subset.rds")

# ---- Attach clinical data if provided or missing ----
if (!is.null(NULL)) {
    clin <- NULL

    # Try to ensure Tumor_Sample_Barcode column exists
    if (!("Tumor_Sample_Barcode" %in% colnames(clin))) {
        colnames(clin)[1] <- "Tumor_Sample_Barcode"
    }

    maf_obj@clinical.data <- clin
}

if (is.null(maf_obj@clinical.data) || nrow(maf_obj@clinical.data) == 0) {
    stop("No clinical data found in maf_obj@clinical.data. Provide an .rds MAF with clinical data or pass clinicalData table.")
}

if (!("breast_carcinoma_estrogen_receptor_status" %in% colnames(maf_obj@clinical.data))) {
    stop(paste0("clinicalFeature not found in clinical.data: breast_carcinoma_estrogen_receptor_status. Available columns: ",
                paste(colnames(maf_obj@clinical.data), collapse=", ")))
}

enrich_res <- clinicalEnrichment(
    maf = maf_obj,
    clinicalFeature = "breast_carcinoma_estrogen_receptor_status",
    annotationDat = NULL,
    minMut = 3,
    useCNV = TRUE
)

write.table(
    enrich_res$groupwise_comparision,
    file = "maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_outputs/clinical_enrichment_results.txt",
    sep = "\t",
    quote = FALSE,
    row.names = FALSE
)

png("maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_outputs/clinical_enrichment_plot.png", width = 1800, height = 1400, res = 300)

plotEnrichmentResults(
    enrich_res = enrich_res,
    pVal = 0.05,
    cols = NULL,
    annoFontSize = 0.8,
    geneFontSize = 0.8,
    legendFontSize = 0.8,
    showTitle = TRUE
)

dev.off()
