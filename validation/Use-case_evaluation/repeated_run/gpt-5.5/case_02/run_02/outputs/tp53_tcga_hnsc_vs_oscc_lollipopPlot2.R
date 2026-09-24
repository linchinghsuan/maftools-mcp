# Reproducible TP53 lollipopPlot2 comparison for TCGA-HNSC vs OSCC.
# The mandatory maftools_export_r_script call was attempted, but the export
# helper did not capture R code for plot_lollipopPlot2 in this environment.
# This script mirrors the successful maftools-mcp plot_lollipopPlot2 call and
# preserves the top protein-variant labeling behavior: variants are counted by
# amino-acid change, different variants at the same position are counted
# separately, and all variants tied for highest count per cohort are labeled.

suppressPackageStartupMessages({
  library(data.table)
  library(maftools)
})

output_dir <- "/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/gpt-5.5/case_02/run_02/outputs"
dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)

tcga_rds_path <- "/Users/linqingxuan/mcp_server/maftools_mcp/src/maftools_mcp/tcga_data/HNSC.rds"
oscc_maf_path <- "/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/prompt_robustness/gpt-5.5/case_02/run_05/outputs/OSCC.maf"
png_path <- file.path(output_dir, "lollipop_TP53.png")

top_variant_labels <- function(prot.snp.sumamry, labelPos = NULL,
                               collapsePosLabel = TRUE) {
  d <- data.table::as.data.table(prot.snp.sumamry)
  if (nrow(d) == 0L) {
    return(NULL)
  }

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

m1 <- readRDS(tcga_rds_path)
m2 <- maftools::read.maf(oscc_maf_path)

# Override lollipopPlot2's internal label helper so labels are protein-change
# specific and include counts, matching maftools-mcp label_top_variant=TRUE.
plot_fun <- maftools::lollipopPlot2
plot_env <- new.env(parent = environment(maftools::lollipopPlot2))
plot_env$label_pos <- top_variant_labels
environment(plot_fun) <- plot_env

png(png_path, width = 2600, height = 2000, res = 300)
plot_fun(
  m1 = m1,
  m2 = m2,
  gene = "TP53",
  AACol1 = "HGVSp_Short",
  AACol2 = "HGVSp_Short",
  m1_name = "TCGA-HNSC",
  m2_name = "OSCC",
  m1_label = "all",
  m2_label = "all",
  labPosAngle = 45,
  labPosSize = 0.55,
  refSeqID = NULL,
  proteinID = NULL,
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

message("Wrote: ", png_path)
