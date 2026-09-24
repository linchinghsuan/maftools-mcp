# Auto-exported by Maftools-MCP export_r_script for validation.

library(maftools)

tcga_rds_path <- "/Users/linqingxuan/mcp_server/maftools_mcp/src/maftools_mcp/tcga_data/HNSC.rds"
oscc_maf_path <- "/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/prompt_robustness/claude-opus-4.7/case_02/run_05/outputs/OSCC.maf"
out_png <- "/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/prompt_robustness/gpt-5.5/case_02/run_05/outputs/lollipop_TP53.png"

m1 <- readRDS(tcga_rds_path)
m2 <- maftools::read.maf(oscc_maf_path)

plot_fun <- maftools::lollipopPlot2

top_variant_labels <- function(prot.snp.sumamry, labelPos = NULL,
                               collapsePosLabel = TRUE) {
    d <- data.table::copy(data.table::as.data.table(prot.snp.sumamry))
    if (nrow(d) == 0L) return(NULL)

    required <- c("conv", "pos2", "count", "count2")
    if (!all(required %in% names(d))) {
        stop("Installed maftools has an incompatible label data format.")
    }

    variants <- d[, .(n = sum(count), count2 = max(count2)),
                  by = .(conv, pos2)]
    winners <- variants[n == max(n)]
    data.table::setorder(winners, pos2, conv)

    # Keep tied protein changes separate, even when they share one position.
    winners[, .(count2 = max(count2),
                conv = paste0(conv, " (n=", n, ")", collapse = "\n")),
            by = pos2]
}

plot_env <- new.env(parent = environment(maftools::lollipopPlot2))
plot_env$label_pos <- top_variant_labels
environment(plot_fun) <- plot_env

png(out_png, width = 2600, height = 2000, res = 300)
tryCatch(
    plot_fun(
        m1 = m1,
        m2 = m2,
        gene = "TP53",
        AACol1 = NULL,
        AACol2 = NULL,
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
        axisTextSize = c(0.75, 0.75),
        pointSize = 1,
        roundedRect = TRUE,
        showDomainLabel = TRUE,
        domainBorderCol = "black",
        domainLabelSize = 0.7,
        legendTxtSize = 0.7,
        verbose = TRUE
    ),
    finally = dev.off()
)
