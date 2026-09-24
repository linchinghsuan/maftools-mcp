# Auto-exported by Maftools-MCP export_r_script for validation.

library(maftools)

maf_path <- "/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/prompt_robustness/gpt-5.5/case_01/run_01/outputs/OSCC_cohort.maf"
output_png <- "/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/prompt_robustness/gpt-5.5/case_01/run_01/outputs/OSCC_top20_oncoplot.png"

maf <- read.maf(maf = maf_path)

png(filename = output_png, width = 2600, height = 2000, res = 300)
oncoplot(
  maf = maf,
  top = 20,
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
