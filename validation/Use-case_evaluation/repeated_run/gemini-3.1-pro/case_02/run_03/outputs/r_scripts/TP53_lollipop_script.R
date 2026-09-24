# Auto-exported by Maftools-MCP export_r_script for validation.
# This script was captured from the existing MCP tool implementation.
# MCP tool: plot_lollipopPlot2
# Underlying R/Maftools function: maftools::function
# Effective MCP parameters:
#   tcga_rds_path = "/Users/linqingxuan/mcp_server/maftools_mcp/src/maftools_mcp/tcga_data/HNSC.rds"
#   user_maf_path = "/Users/linqingxuan/mcp_server/maftools_mcp/OSCC.maf"
#   user_maf_path2 = null
#   gene = "TP53"
#   output_dir = "/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/opencode_gemini-3.1-pro-preview/case_02/run_03/outputs"
#   AACol1 = null
#   AACol2 = null
#   labPosAngle = 0
#   labPosSize = 0.8
#   refSeqID = null
#   proteinID = null
#   colors = null
#   alpha = 1
#   axisTextSize = null
#   pointSize = 1
#   roundedRect = true
#   showDomainLabel = true
#   domainBorderCol = "black"
#   domainLabelSize = 0.8
#   legendTxtSize = 0.8
#   verbose = true
#   img_width = 2600
#   img_height = 2000
#   m1_label = null
#   m2_label = null
#   label_top_variant = true

library(maftools)

m1 <- readRDS("/Users/linqingxuan/mcp_server/maftools_mcp/src/maftools_mcp/tcga_data/HNSC.rds")
m2 <- maftools::read.maf("/Users/linqingxuan/mcp_server/maftools_mcp/OSCC.maf")




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
    # Combine tied changes at the same coordinate into a multiline
    # label so they are all visible instead of drawn over each other.
    winners[, .(count2 = max(count2),
                conv = paste0(conv, " (n=", n, ")", collapse = "\n")),
            by = pos2]
}
plot_env <- new.env(parent = environment(maftools::lollipopPlot2))
plot_env$label_pos <- top_variant_labels
environment(plot_fun) <- plot_env


png("/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/opencode_gemini-3.1-pro-preview/case_02/run_03/outputs/lollipop_TP53.png", width=2600, height=2000, res=300)

tryCatch(plot_fun(
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
    labPosSize = 0.8,

    colors = NULL,
    alpha = 1,

    axisTextSize = NULL,
    pointSize = 1,

    roundedRect = TRUE,
    showDomainLabel = TRUE,

    domainBorderCol = "black",
    domainLabelSize = 0.8,

    legendTxtSize = 0.8,

    verbose = TRUE
), finally = dev.off())
