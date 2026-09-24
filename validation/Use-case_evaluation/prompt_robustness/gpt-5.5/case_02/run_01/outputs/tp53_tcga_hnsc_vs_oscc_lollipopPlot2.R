# Auto-exported by Maftools-MCP export_r_script for validation.

# MCP tool: plot_lollipopPlot2
# Purpose: combined TP53 lollipop plot comparing TCGA-HNSC and OSCC.maf.
# This script mirrors the successful maftools-mcp call, including the
# label_top_variant hook that labels all top-count protein-variant ties per
# cohort and counts different protein variants at the same position separately.

library(maftools)
library(data.table)

m1 <- readRDS("/Users/linqingxuan/mcp_server/maftools_mcp/src/maftools_mcp/tcga_data/HNSC.rds")
m2 <- maftools::read.maf("/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/prompt_robustness/gemini-3.1-pro-preview/case_02/run_01/OSCC.maf")

plot_fun <- maftools::lollipopPlot2

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

out_png <- "/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/prompt_robustness/gpt-5.5/case_02/run_01/outputs/lollipop_TP53.png"
png(out_png, width = 2600, height = 2000, res = 300)

tryCatch(plot_fun(
  m1 = m1,
  m2 = m2,
  gene = "TP53",
  AACol1 = "HGVSp_Short",
  AACol2 = "aaChange",
  m1_name = "TCGA",
  m2_name = "User",
  m1_label = "all",
  m2_label = "all",
  refSeqID = NULL,
  proteinID = NULL,
  labPosAngle = 0,
  labPosSize = 0.7,
  colors = NULL,
  alpha = 1,
  axisTextSize = c(0.7, 0.7),
  pointSize = 1,
  roundedRect = TRUE,
  showDomainLabel = TRUE,
  domainBorderCol = "black",
  domainLabelSize = 0.7,
  legendTxtSize = 0.7,
  verbose = TRUE
), finally = dev.off())
