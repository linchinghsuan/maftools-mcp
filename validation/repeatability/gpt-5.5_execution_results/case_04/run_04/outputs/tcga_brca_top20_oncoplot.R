# Auto-exported by Maftools-MCP export_r_script for validation.
# This script was captured from the existing MCP tool implementation.
# MCP tool: plot_oncoplot
# Underlying R/Maftools function: maftools::oncoplot
# Effective MCP parameters:
#   maf_path = "maftools_validation_data/use_case_test/validation_results/gpt-5.5/case_04/run_04/outputs/tcga_brca_standardized.rds"
#   output_dir = "maftools_validation_data/use_case_test/validation_results/gpt-5.5/case_04/run_04/outputs"
#   top = 20
#   minMut = null
#   genes = ["PIK3CA", "TP53", "TTN", "CDH1", "GATA3", "MUC16", "KMT2C", "MAP3K1", "FLG", "RYR2", "HMCN1", "SYNE1", "USH2A", "PTEN", "SPTA1", "NEB", "ZFHX4", "NCOR1", "DMD", "OBSCN"]
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
#   clinicalFeatures = ["Tumor_Stage", "Gender"]
#   annotationColor = null
#   annotationDat = null
#   pathways = null
#   selectedPathways = null
#   draw_titv = true
#   showTumorSampleBarcodes = false
#   barcode_mar = 4
#   barcodeSrt = 90
#   gene_mar = 5
#   anno_height = 1
#   legend_height = 4
#   sortByAnnotation = true
#   groupAnnotationBySize = true
#   annotationOrder = ["Stage I", "Stage IA", "Stage IB", "Stage II", "Stage IIA", "Stage IIB", "Stage III", "Stage IIIA", "Stage IIIB", "Stage IIIC", "Stage IV", "Stage X", "[Not Available]"]
#   sortByMutation = true
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
#   img_width = 3600
#   img_height = 2600
#   img_res = 300
#   out_name = "tcga_brca_top20_oncoplot.png"

suppressPackageStartupMessages(library(maftools))

maf <- readRDS("maftools_validation_data/use_case_test/validation_results/gpt-5.5/case_04/run_04/outputs/tcga_brca_standardized.rds")

png("maftools_validation_data/use_case_test/validation_results/gpt-5.5/case_04/run_04/outputs/tcga_brca_top20_oncoplot.png", width=3600, height=2600, res=300)

oncoplot(
    maf = maf,
    top = 20,
    minMut = NULL,
    genes = c("PIK3CA","TP53","TTN","CDH1","GATA3","MUC16","KMT2C","MAP3K1","FLG","RYR2","HMCN1","SYNE1","USH2A","PTEN","SPTA1","NEB","ZFHX4","NCOR1","DMD","OBSCN"),
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
    clinicalFeatures = c("Tumor_Stage","Gender"),
    annotationColor = NULL,
    annotationDat = NULL,
    pathways = NULL,
    selectedPathways = NULL,
    draw_titv = TRUE,
    showTumorSampleBarcodes = FALSE,
    barcode_mar = 4,
    barcodeSrt = 90,
    gene_mar = 5,
    anno_height = 1,
    legend_height = 4,
    sortByAnnotation = TRUE,
    groupAnnotationBySize = TRUE,
    annotationOrder = c("Stage I","Stage IA","Stage IB","Stage II","Stage IIA","Stage IIB","Stage III","Stage IIIA","Stage IIIB","Stage IIIC","Stage IV","Stage X","[Not Available]"),
    sortByMutation = TRUE,
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
