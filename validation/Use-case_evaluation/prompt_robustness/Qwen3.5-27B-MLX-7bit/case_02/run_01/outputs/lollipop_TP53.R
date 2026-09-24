# Auto-exported by Maftools-MCP export_r_script for validation.

#!/usr/bin/env Rscript

library(Maftools)

tcga_rds_path <- "/Users/linqingxuan/mcp_server/maftools_mcp/src/maftools_mcp/tcga_data/HNSC.rds"
user_maf_path <- "/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/prompt_robustness/Qwen3.5-27B-MLX-7bit/case_02/run_01/outputs/OSCC.maf"
output_dir <- "/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/prompt_robustness/Qwen3.5-27B-MLX-7bit/case_02/run_01/outputs"

ma1 <- read.maf(tcga_rds_path)
ma2 <- read.maf(user_maf_path)

ma1_filtered <- subsetMaf(ma1, gene = "TP53")
ma2_filtered <- subsetMaf(ma2, gene = "TP53")

getTopVariant <- function(ma, gene) {
  maf_data <- getMaf(ma)
  gene_muts <- maf_data[maf_data$Hugo_Symbol == gene, ]
  if (nrow(gene_muts) == 0) return(list(positions = integer(0), count = 0))
  
  aa_col <- "AAChange"
  if (!aa_col %in% colnames(gene_muts)) {
    for (col in colnames(gene_muts)) {
      if (grepl("AA", col, ignore.case = TRUE)) {
        aa_col <- col
        break
      }
    }
  }
  
  if (!aa_col %in% colnames(gene_muts)) return(list(positions = integer(0), count = 0))
  
  aa_changes <- gene_muts[[aa_col]]
  valid_idx <- !is.na(aa_changes) & nchar(aa_changes) > 0
  if (!any(valid_idx)) return(list(positions = integer(0), count = 0))
  
  valid_changes <- aa_changes[valid_idx]
  positions <- as.integer(gsub(".*[A-Za-z](\\d+)[A-Za-z].*", "\\1", valid_changes))
  valid_positions <- !is.na(positions) & positions > 0
  if (!any(valid_positions)) return(list(positions = integer(0), count = 0))
  
  pos_changes <- data.frame(
    position = positions[valid_positions],
    change = valid_changes[valid_positions],
    stringsAsFactors = FALSE
  )
  
  change_counts <- table(pos_changes$change)
  max_count <- max(change_counts)
  top_changes <- names(change_counts[change_counts == max_count])
  top_positions <- unique(as.integer(gsub(".*[A-Za-z](\\d+)[A-Za-z].*", "\\1", top_changes)))
  
  list(positions = top_positions, count = as.integer(max_count))
}

top1 <- getTopVariant(ma1_filtered, "TP53")
top2 <- getTopVariant(ma2_filtered, "TP53")

pdf(file.path(output_dir, "lollipop_TP53.png"), width = 26, height = 20, res = 300)

par(mar = c(5, 8, 4, 2))

lollipopPlot2(
  ma1 = ma1_filtered,
  ma2 = ma2_filtered,
  gene = "TP53",
  m1_label = top1$positions,
  m2_label = top2$positions,
  labPosSize = 0.6,
  domainLabelSize = 0.6,
  legendTxtSize = 0.6,
  axisTextSize = c(0.6, 0.6),
  showDomainLabel = TRUE,
  showMutationRate = TRUE
)

dev.off()

cat("Lollipop plot saved to:", file.path(output_dir, "lollipop_TP53.png"), "\n")