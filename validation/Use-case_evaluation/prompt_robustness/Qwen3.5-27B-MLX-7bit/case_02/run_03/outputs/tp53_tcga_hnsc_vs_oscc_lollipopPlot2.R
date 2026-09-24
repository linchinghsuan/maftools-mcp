# Auto-exported by Maftools-MCP export_r_script for validation.

library(maftools)

tcga_rds_path <- "/Users/linqingxuan/mcp_server/maftools_mcp/src/maftools_mcp/tcga_data/HNSC.rds"
oscc_maf_path <- "/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/prompt_robustness/gemini-3.1-pro-preview/case_02/run_03/OSCC.maf"
out_png <- "/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/prompt_robustness/Qwen3.5-27B-MLX-7bit/case_02/run_03/outputs/lollipop_TP53.png"

m1 <- readRDS(tcga_rds_path)
m2 <- maftools::read.maf(oscc_maf_path)

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
environment(maftools::lollipopPlot2) <- plot_env

png(out_png, width = 2600, height = 2000, res = 300)
tryCatch(
  maftools::lollipopPlot2(
    m1 = m1,
    m2 = m2,
    gene = "TP53",
    AACol1 = "HGVSp_Short",
    AACol2 = "aaChange",
    m1_label = NULL,
    m2_label = NULL,
    label_top_variant = TRUE,
    refSeqID = NULL,
    proteinID = NULL,
    labPosAngle = 0,
    labPosSize = 0.6,
    colors = NULL,
    alpha = 1,
    axisTextSize = c(0.6, 0.6),
    pointSize = 0.8,
    roundedRect = TRUE,
    showDomainLabel = TRUE,
    domainBorderCol = "black",
    domainLabelSize = 0.6,
    legendTxtSize = 0.6,
    verbose = TRUE
  ),
  finally = dev.off()
)
