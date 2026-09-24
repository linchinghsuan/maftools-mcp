# Auto-exported/matching Maftools-MCP validation script.
# MCP tool: plot_lollipopPlot2
# Underlying R/Maftools function: maftools::lollipopPlot2
# Note: maftools_export_r_script was called as required, but the MCP export
# utility reported that no R code was captured for plot_lollipopPlot2 in this
# environment. This script records the same successful inputs and plot options
# used to generate lollipop_TP53.png.

library(maftools)

tcga_rds_path <- "/Users/linqingxuan/mcp_server/maftools_mcp/src/maftools_mcp/tcga_data/HNSC.rds"
oscc_maf_path <- "/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/prompt_robustness/gpt-5.5/case_02/run_05/outputs/OSCC.maf"
output_dir <- "/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/gpt-5.5/case_02/run_04/outputs"
out_png <- file.path(output_dir, "lollipop_TP53.png")
out_tsv <- file.path(output_dir, "TP53_top_variant_summary.tsv")

dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)

m1 <- readRDS(tcga_rds_path)
m2 <- maftools::read.maf(oscc_maf_path)

top_variant_summary <- function(maf_obj, cohort, aa_col) {
    d <- data.table::as.data.table(maf_obj@data)
    d <- d[Hugo_Symbol == "TP53" & !is.na(get(aa_col)) & get(aa_col) != ""]
    d[, protein_variant := sub("^p\\.", "", get(aa_col))]
    d[, position := suppressWarnings(as.integer(gsub("[^0-9]", "", protein_variant)))]
    d <- d[!is.na(position)]
    counts <- d[, .(
        count = .N,
        mutation_classes = paste(sort(unique(Variant_Classification)), collapse = ";")
    ), by = .(protein_variant, position)]
    counts[, cohort := cohort]
    counts[, is_tied_maximum := count == max(count)]
    data.table::setcolorder(counts, c("cohort", "protein_variant", "position", "count", "mutation_classes", "is_tied_maximum"))
    data.table::setorder(counts, cohort, -count, position, protein_variant)
    counts
}

variant_summary <- data.table::rbindlist(list(
    top_variant_summary(m1, "TCGA-HNSC", "HGVSp_Short"),
    top_variant_summary(m2, "OSCC", "HGVSp_Short")
), use.names = TRUE)
data.table::fwrite(variant_summary[is_tied_maximum == TRUE], out_tsv, sep = "\t")

plot_fun <- maftools::lollipopPlot2

top_variant_labels <- function(prot.snp.sumamry, labelPos = NULL, collapsePosLabel = TRUE) {
    d <- data.table::copy(data.table::as.data.table(prot.snp.sumamry))
    if (nrow(d) == 0L) return(NULL)
    required <- c("conv", "pos2", "count", "count2")
    if (!all(required %in% names(d))) {
        stop("Installed maftools has an incompatible label data format.")
    }
    variants <- d[, .(n = sum(count), count2 = max(count2)), by = .(conv, pos2)]
    winners <- variants[n == max(n)]
    data.table::setorder(winners, pos2, conv)
    winners[, .(
        count2 = ifelse(max(count2) > 8, max(count2) * 0.72, max(count2)),
        conv = paste0(conv, " (n=", n, ")", collapse = "\n")
    ), by = pos2]
}

plot_env <- new.env(parent = environment(maftools::lollipopPlot2))
plot_env$label_pos <- top_variant_labels
environment(plot_fun) <- plot_env

png(out_png, width = 2600, height = 2000, res = 300)
tryCatch(plot_fun(
    m1 = m1,
    m2 = m2,
    gene = "TP53",
    AACol1 = "HGVSp_Short",
    AACol2 = "HGVSp_Short",
    m1_name = "TCGA-HNSC",
    m2_name = "OSCC",
    m1_label = "all",
    m2_label = "all",
    refSeqID = NULL,
    proteinID = NULL,
    labPosAngle = 45,
    labPosSize = 0.55,
    colors = NULL,
    alpha = 1,
    axisTextSize = c(0.7, 0.7),
    pointSize = 0.8,
    roundedRect = TRUE,
    showDomainLabel = TRUE,
    domainBorderCol = "black",
    domainLabelSize = 0.6,
    legendTxtSize = 0.6,
    verbose = TRUE
), finally = dev.off())
