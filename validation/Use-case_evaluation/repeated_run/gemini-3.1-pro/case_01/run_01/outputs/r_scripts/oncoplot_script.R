# Auto-exported by Maftools-MCP export_r_script for validation.
# This script was captured from the existing MCP tool implementation.
# MCP tool: plot_oncoplot
# Underlying R/Maftools function: maftools::oncoplot
# Effective MCP parameters:
#   maf_path = "/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/opencode_gemini-3.1-pro-preview/case_01/run_01/outputs/OSCC_merged.maf"
#   output_dir = "/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/opencode_gemini-3.1-pro-preview/case_01/run_01/outputs"
#   top = 20
#   minMut = null
#   genes = null
#   altered = false
#   drawRowBar = true
#   drawColBar = true
#   leftBarData = null
#   leftBarLims = null
#   rightBarData = null
#   rightBarLims = null
#   topBarData = null
#   logColBar = false
#   includeColBarCN = true
#   clinicalFeatures = null
#   annotationColor = null
#   annotationDat = null
#   pathways = null
#   selectedPathways = null
#   draw_titv = false
#   showTumorSampleBarcodes = false
#   barcode_mar = 4
#   barcodeSrt = 90
#   gene_mar = 5
#   anno_height = 1
#   legend_height = 4
#   sortByAnnotation = false
#   groupAnnotationBySize = true
#   annotationOrder = null
#   sortByMutation = false
#   keepGeneOrder = false
#   GeneOrderSort = true
#   sampleOrder = null
#   additionalFeature = null
#   additionalFeaturePch = 20
#   additionalFeatureCol = "gray70"
#   additionalFeatureCex = 0.9
#   genesToIgnore = null
#   removeNonMutated = true
#   fill = true
#   cohortSize = null
#   colors = null
#   bgCol = "#CCCCCC"
#   borderCol = "white"
#   annoBorderCol = null
#   numericAnnoCol = null
#   drawBox = false
#   fontSize = 0.8
#   SampleNamefontSize = 1.0
#   titleFontSize = 1.5
#   legendFontSize = 1.2
#   annotationFontSize = 1.2
#   sepwd_genes = 0.5
#   sepwd_samples = 0.25
#   writeMatrix = false
#   colbar_pathway = false
#   showTitle = true
#   titleText = null
#   img_width = 2600
#   img_height = 2000
#   img_res = 300
#   out_name = "oncoplot.png"

suppressPackageStartupMessages(library(maftools))

maf <- maftools::read.maf("/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/opencode_gemini-3.1-pro-preview/case_01/run_01/outputs/OSCC_merged.maf")

png("/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/opencode_gemini-3.1-pro-preview/case_01/run_01/outputs/oncoplot.png", width=2600, height=2000, res=300)

oncoplot(
    maf = maf,
    top = 20,
    minMut = NULL,
    genes = NULL,
    altered = FALSE,
    drawRowBar = TRUE,
    drawColBar = TRUE,
    leftBarData = NULL,
    leftBarLims = NULL,
    rightBarData = NULL,
    rightBarLims = NULL,
    topBarData = NULL,
    logColBar = FALSE,
    includeColBarCN = TRUE,
    clinicalFeatures = NULL,
    annotationColor = NULL,
    annotationDat = NULL,
    pathways = NULL,
    selectedPathways = NULL,
    draw_titv = FALSE,
    showTumorSampleBarcodes = FALSE,
    barcode_mar = 4,
    barcodeSrt = 90,
    gene_mar = 5,
    anno_height = 1,
    legend_height = 4,
    sortByAnnotation = FALSE,
    groupAnnotationBySize = TRUE,
    annotationOrder = NULL,
    sortByMutation = FALSE,
    keepGeneOrder = FALSE,
    GeneOrderSort = TRUE,
    sampleOrder = NULL,
    additionalFeature = NULL,
    additionalFeaturePch = 20,
    additionalFeatureCol = "gray70",
    additionalFeatureCex = 0.9,
    genesToIgnore = NULL,
    removeNonMutated = TRUE,
    fill = TRUE,
    cohortSize = NULL,
    colors = NULL,
    bgCol = "#CCCCCC",
    borderCol = "white",
    annoBorderCol = NULL,
    numericAnnoCol = NULL,
    drawBox = FALSE,
    fontSize = 0.8,
    SampleNamefontSize = 1.0,
    titleFontSize = 1.5,
    legendFontSize = 1.2,
    annotationFontSize = 1.2,
    sepwd_genes = 0.5,
    sepwd_samples = 0.25,
    writeMatrix = FALSE,
    colbar_pathway = FALSE,
    showTitle = TRUE,
    titleText = NULL
)

dev.off()
