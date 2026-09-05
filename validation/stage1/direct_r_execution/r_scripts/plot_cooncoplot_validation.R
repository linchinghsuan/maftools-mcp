# Auto-exported by Maftools-MCP export_r_script for validation.
# This script was captured from the existing MCP tool implementation.
# MCP tool: plot_cooncoplot
# Underlying R/Maftools function: maftools::coOncoplot
# Effective MCP parameters:
#   tcga_rds_path = null
#   user_maf_path = "maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_input_file/cohort1.maf"
#   user_maf_path2 = "maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_input_file/cohort2.maf"
#   output_dir = "maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_outputs"
#   genes = null
#   clinicalFeatures1 = null
#   clinicalFeatures2 = null
#   annotationColor1 = null
#   annotationColor2 = null
#   sortByAnnotation1 = false
#   sortByAnnotation2 = false
#   sampleOrder1 = null
#   sampleOrder2 = null
#   additionalFeature1 = null
#   additionalFeaturePch1 = 20
#   additionalFeatureCol1 = "white"
#   additionalFeatureCex1 = 0.9
#   additionalFeature2 = null
#   additionalFeaturePch2 = 20
#   additionalFeatureCol2 = "white"
#   additionalFeatureCex2 = 0.9
#   sepwd_genes1 = 0.5
#   sepwd_samples1 = 0.5
#   sepwd_genes2 = 0.5
#   sepwd_samples2 = 0.5
#   colors = null
#   removeNonMutated = true
#   anno_height = 2
#   legend_height = 4
#   geneNamefont = 0.8
#   showSampleNames = false
#   SampleNamefont = 0.5
#   barcode_mar = 1
#   outer_mar = 3
#   gene_mar = 1
#   legendFontSize = 1.2
#   titleFontSize = 1.5
#   keepGeneOrder = false
#   bgCol = "#CCCCCC"
#   borderCol = "white"
#   img_width = 2600
#   img_height = 2000

library(maftools)

# load datasets



m1 <- maftools::read.maf("maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_input_file/cohort1.maf")
m2 <- maftools::read.maf("maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_input_file/cohort2.maf")

png("maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_outputs/plot_cooncoplot__cooncoplot.png", width=2600, height=2000, res=300)

maftools::coOncoplot(
    m1 = m1,
    m2 = m2,
    genes = NULL,
    m1Name = "Cohort1",
    m2Name = "Cohort2",
    clinicalFeatures1 = NULL,
    clinicalFeatures2 = NULL,
    annotationColor1 = NULL,
    annotationColor2 = NULL,
    sortByAnnotation1 = FALSE,
    sortByAnnotation2 = FALSE,
    sampleOrder1 = NULL,
    sampleOrder2 = NULL,
    additionalFeature1 = NULL,
    additionalFeaturePch1 = 20,
    additionalFeatureCol1 = "white",
    additionalFeatureCex1 = 0.9,
    additionalFeature2 = NULL,
    additionalFeaturePch2 = 20,
    additionalFeatureCol2 = "white",
    additionalFeatureCex2 = 0.9,
    sepwd_genes1 = 0.5,
    sepwd_samples1 = 0.5,
    sepwd_genes2 = 0.5,
    sepwd_samples2 = 0.5,
    colors = NULL,
    removeNonMutated = TRUE,
    anno_height = 2,
    legend_height = 4,
    geneNamefont = 0.8,
    showSampleNames = FALSE,
    SampleNamefont = 0.5,
    barcode_mar = 1,
    outer_mar = 3,
    gene_mar = 1,
    legendFontSize = 1.2,
    titleFontSize = 1.5,
    keepGeneOrder = FALSE,
    bgCol = "#CCCCCC",
    borderCol = "white"
)

dev.off()
