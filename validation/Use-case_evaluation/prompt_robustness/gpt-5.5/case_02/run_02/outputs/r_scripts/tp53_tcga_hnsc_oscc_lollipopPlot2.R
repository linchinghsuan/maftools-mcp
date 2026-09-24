# Auto-exported by Maftools-MCP export_r_script for validation.

library(maftools)

tcga_rds_path <- "/Users/linqingxuan/mcp_server/maftools_mcp/src/maftools_mcp/tcga_data/HNSC.rds"
oscc_maf_path <- "/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/prompt_robustness/gemini-3.1-pro-preview/case_02/run_02/OSCC.maf"
output_dir <- "/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/prompt_robustness/gpt-5.5/case_02/run_02/outputs"

dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)

tcga_hnsc <- readRDS(tcga_rds_path)
oscc <- read.maf(maf = oscc_maf_path)

plot_fun <- maftools::lollipopPlot2

# Match maftools-mcp label_top_variant=TRUE: independently label every
# tied most-frequent protein change and keep distinct variants separate.
top_variant_labels <- function(prot.snp.sumamry, labelPos = NULL,
                               collapsePosLabel = TRUE) {
  d <- data.table::copy(data.table::as.data.table(prot.snp.sumamry))
  if (nrow(d) == 0L) return(NULL)
  required <- c("conv", "pos2", "count", "count2")
  if (!all(required %in% names(d))) {
    stop("Installed maftools has an incompatible label data format.")
  }
  variants <- d[, .(n = sum(count), count2 = max(count2)), by = .(conv, pos2)]
  winners <- variants[n == max(n)]
  data.table::setorder(winners, pos2, conv)
  winners[, .(count2 = max(count2),
              conv = paste0(conv, " (n=", n, ")", collapse = "\n")),
          by = pos2]
}

plot_env <- new.env(parent = environment(maftools::lollipopPlot2))
plot_env$label_pos <- top_variant_labels
environment(plot_fun) <- plot_env

png(
  filename = file.path(output_dir, "lollipop_TP53.png"),
  width = 2600,
  height = 2000,
  res = 300
)

plot_fun(
  m1 = tcga_hnsc,
  m2 = oscc,
  gene = "TP53",
  AACol1 = "HGVSp_Short",
  AACol2 = "aaChange",
  m1_name = "TCGA",
  m2_name = "User",
  m1_label = "all",
  m2_label = "all",
  labPosAngle = 0,
  labPosSize = 0.55,
  colors = NULL,
  alpha = 1,
  axisTextSize = c(0.55, 0.55),
  pointSize = 0.8,
  roundedRect = TRUE,
  showDomainLabel = TRUE,
  domainBorderCol = "black",
  domainLabelSize = 0.55,
  legendTxtSize = 0.55,
  verbose = TRUE
)

dev.off()
