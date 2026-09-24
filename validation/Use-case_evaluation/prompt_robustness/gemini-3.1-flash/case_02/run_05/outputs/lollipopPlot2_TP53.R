# Auto-exported by Maftools-MCP export_r_script for validation.

library(maftools)

# Load data
hnsc_rds <- "/Users/linqingxuan/mcp_server/maftools_mcp/src/maftools_mcp/tcga_data/HNSC.rds"
oscc_maf <- "/Users/linqingxuan/mcp_server/maftools_mcp/OSCC.maf"

# Read MAF objects
tcga_maf <- readRDS(hnsc_rds)
user_maf <- read.maf(oscc_maf)

# Plot lollipopPlot2
lollipopPlot2(
  m1 = tcga_maf,
  m2 = user_maf,
  gene = "TP53",
  AACol1 = NULL,
  AACol2 = NULL,
  alpha = 1,
  axisTextSize = c(1, 1),
  colors = NULL,
  domainBorderCol = "black",
  domainLabelSize = 0.6,
  img_height = 2000,
  img_width = 2600,
  labPosAngle = 0,
  labPosSize = 0.6,
  label_top_variant = TRUE,
  legendTxtSize = 1.2,
  m1_label = NULL,
  m2_label = NULL,
  pointSize = 1.2,
  proteinID = NULL,
  refSeqID = NULL,
  roundedRect = TRUE,
  showDomainLabel = TRUE,
  verbose = TRUE
)
