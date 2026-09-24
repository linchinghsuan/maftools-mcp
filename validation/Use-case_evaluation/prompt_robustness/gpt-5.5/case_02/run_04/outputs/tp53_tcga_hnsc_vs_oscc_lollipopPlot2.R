# Auto-exported by Maftools-MCP export_r_script for validation.

#!/usr/bin/env Rscript

suppressPackageStartupMessages({
  library(maftools)
})

output_dir <- "/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/prompt_robustness/gpt-5.5/case_02/run_04/outputs"
tcga_rds_path <- "/Users/linqingxuan/mcp_server/maftools_mcp/src/maftools_mcp/tcga_data/HNSC.rds"
oscc_maf_path <- "/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/prompt_robustness/gemini-3.1-pro-preview/case_02/run_04/OSCC.maf"

dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)

tcga_hnsc <- readRDS(tcga_rds_path)
oscc <- read.maf(maf = oscc_maf_path, verbose = FALSE)

top_variant_positions <- function(maf_obj, gene, aa_col) {
  dt <- maf_obj@data
  dt <- dt[dt$Hugo_Symbol == gene & !is.na(dt[[aa_col]]) & nzchar(dt[[aa_col]]), ]

  # Count exact protein-change strings independently so different variants at
  # the same amino-acid position are not pooled together.
  variant_counts <- sort(table(dt[[aa_col]]), decreasing = TRUE)
  top_variants <- names(variant_counts)[variant_counts == max(variant_counts)]
  top_counts <- as.integer(variant_counts[top_variants])

  positions <- as.integer(sub(".*?([0-9]+).*", "\\1", top_variants))
  labels <- paste0(top_variants, " (n=", top_counts, ")")

  data.frame(
    variant = top_variants,
    count = top_counts,
    position = positions,
    label = labels,
    stringsAsFactors = FALSE
  )
}

tcga_top <- top_variant_positions(tcga_hnsc, "TP53", "HGVSp_Short")
oscc_top <- top_variant_positions(oscc, "TP53", "aaChange")

write.table(
  tcga_top,
  file = file.path(output_dir, "TP53_TCGA_HNSC_top_protein_variants.tsv"),
  sep = "\t",
  quote = FALSE,
  row.names = FALSE
)
write.table(
  oscc_top,
  file = file.path(output_dir, "TP53_OSCC_top_protein_variants.tsv"),
  sep = "\t",
  quote = FALSE,
  row.names = FALSE
)

png(
  filename = file.path(output_dir, "lollipop_TP53.png"),
  width = 2600,
  height = 2000,
  res = 300
)

lollipopPlot2(
  m1 = tcga_hnsc,
  m2 = oscc,
  gene = "TP53",
  AACol1 = "HGVSp_Short",
  AACol2 = "aaChange",
  m1_label = tcga_top$position,
  m2_label = oscc_top$position,
  labPosAngle = 0,
  labPosSize = 0.55,
  alpha = 1,
  axisTextSize = c(0.65, 0.65),
  pointSize = 0.8,
  roundedRect = TRUE,
  showDomainLabel = TRUE,
  domainBorderCol = "black",
  domainLabelSize = 0.55,
  legendTxtSize = 0.6,
  verbose = TRUE
)

dev.off()
