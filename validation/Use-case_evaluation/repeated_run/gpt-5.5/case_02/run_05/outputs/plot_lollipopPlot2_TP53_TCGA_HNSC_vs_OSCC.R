library(maftools)

tcga_rds_path <- "/Users/linqingxuan/mcp_server/maftools_mcp/src/maftools_mcp/tcga_data/HNSC.rds"
oscc_maf_path <- "/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/prompt_robustness/gpt-5.5/case_02/run_05/outputs/OSCC.maf"
output_dir <- "/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/gpt-5.5/case_02/run_05/outputs"
output_png <- file.path(output_dir, "lollipop_TP53.png")

tcga_hnsc <- readRDS(tcga_rds_path)
oscc <- read.maf(maf = oscc_maf_path, verbose = FALSE)

png(filename = output_png, width = 2600, height = 2000, res = 300)
lollipopPlot2(
  m1 = tcga_hnsc,
  m2 = oscc,
  gene = "TP53",
  AACol1 = "HGVSp_Short",
  AACol2 = "HGVSp_Short",
  labPosAngle = 45,
  labPosSize = 0.65,
  axisTextSize = c(0.65, 0.65),
  pointSize = 0.75,
  roundedRect = TRUE,
  showDomainLabel = TRUE,
  domainBorderCol = "black",
  domainLabelSize = 0.65,
  legendTxtSize = 0.65,
  label_top_variant = TRUE,
  verbose = TRUE
)
dev.off()
