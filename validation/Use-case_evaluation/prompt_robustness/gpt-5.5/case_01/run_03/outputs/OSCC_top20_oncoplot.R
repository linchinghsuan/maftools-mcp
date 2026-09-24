# Auto-exported by Maftools-MCP export_r_script for validation.

#!/usr/bin/env Rscript

suppressPackageStartupMessages({
  library(maftools)
})

oscc_dir <- "/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/OSCC"
output_dir <- "/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/prompt_robustness/gpt-5.5/case_01/run_03/outputs"

annovar_files <- Sys.glob(file.path(oscc_dir, "*.hg19_multianno.txt"))
if (length(annovar_files) == 0) {
  stop("No hg19_multianno.txt files found in ", oscc_dir)
}

dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)

maf_tables <- lapply(annovar_files, function(file) {
  sample_name <- sub("\\.hg19_multianno\\.txt$", "", basename(file))
  annovarToMaf(
    annovar = file,
    Center = NA,
    refBuild = "hg19",
    tsbCol = NULL,
    table = "refGene",
    ens2hugo = TRUE,
    basename = NULL,
    sep = "\t"
  ) |>
    transform(Tumor_Sample_Barcode = sample_name)
})

cohort_maf_table <- do.call(rbind, maf_tables)
cohort_maf_path <- file.path(output_dir, "OSCC_cohort.maf")
write.table(
  cohort_maf_table,
  file = cohort_maf_path,
  sep = "\t",
  quote = FALSE,
  row.names = FALSE
)

cohort_maf <- read.maf(maf = cohort_maf_path, verbose = FALSE)

png(
  filename = file.path(output_dir, "OSCC_top20_oncoplot.png"),
  width = 2600,
  height = 2000,
  res = 300
)
oncoplot(
  maf = cohort_maf,
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
