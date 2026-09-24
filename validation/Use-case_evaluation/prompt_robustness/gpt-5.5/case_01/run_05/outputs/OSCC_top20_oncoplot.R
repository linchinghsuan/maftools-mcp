# Auto-exported by Maftools-MCP export_r_script for validation.

library(maftools)

input_dir <- "/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/OSCC"
output_dir <- "/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/prompt_robustness/gpt-5.5/case_01/run_05/outputs"

annovar_files <- Sys.glob(file.path(input_dir, "*.hg19_multianno.txt"))
if (length(annovar_files) == 0) {
  stop("No ANNOVAR hg19_multianno.txt files found in ", input_dir)
}

merged_maf_path <- file.path(output_dir, "OSCC_merged_cohort.maf")
oncoplot_path <- file.path(output_dir, "OSCC_top20_oncoplot.png")

maf_list <- lapply(annovar_files, function(file) {
  annovarToMaf(
    annovar = file,
    Center = NA,
    refBuild = "hg19",
    tsbCol = NULL,
    table = "refGene",
    basename = NULL,
    sep = "\t",
    MAFobj = FALSE,
    sampleAnno = NULL,
    ens2hugo = TRUE
  )
})

merged_maf <- do.call(rbind, maf_list)
write.table(
  merged_maf,
  file = merged_maf_path,
  sep = "\t",
  quote = FALSE,
  row.names = FALSE
)

maf <- read.maf(maf = merged_maf_path)

png(filename = oncoplot_path, width = 2600, height = 2000, res = 300)
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
  SampleNamefontSize = 1,
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
