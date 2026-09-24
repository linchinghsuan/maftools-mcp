library(maftools)

maf_path <- "/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/gpt-5.5/case_01/run_04/outputs/merged.maf"
output_dir <- "/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/gpt-5.5/case_01/run_04/outputs"
out_name <- "oncoplot.png"

maf <- read.maf(maf = maf_path)

png(
  filename = file.path(output_dir, out_name),
  width = 2600,
  height = 2000,
  res = 300
)

oncoplot(
  maf = maf,
  top = 20,
  altered = FALSE,
  drawRowBar = TRUE,
  drawColBar = TRUE,
  logColBar = FALSE,
  includeColBarCN = TRUE,
  draw_titv = FALSE,
  showTumorSampleBarcodes = FALSE,
  barcode_mar = 4,
  barcodeSrt = 90,
  gene_mar = 5,
  anno_height = 1,
  legend_height = 4,
  sortByAnnotation = FALSE,
  groupAnnotationBySize = TRUE,
  sortByMutation = FALSE,
  keepGeneOrder = FALSE,
  GeneOrderSort = TRUE,
  additionalFeaturePch = 20,
  additionalFeatureCol = "gray70",
  additionalFeatureCex = 0.9,
  removeNonMutated = TRUE,
  fill = TRUE,
  bgCol = "#CCCCCC",
  borderCol = "white",
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
  showTitle = TRUE
)

dev.off()
