library(maftools)

maf_path <- "/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/gpt-5.5/case_01/run_05/outputs/merged_vcf_cohort.maf"
output_dir <- "/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/gpt-5.5/case_01/run_05/outputs"
out_file <- file.path(output_dir, "oncoplot_top20.png")

maf <- read.maf(maf = maf_path, verbose = FALSE)

png(filename = out_file, width = 2600, height = 2000, res = 300)
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
