# Auto-exported by Maftools-MCP export_r_script for validation.

# Auto-exported by Maftools-MCP for TP53 survival analysis
# Tool: plot_maf_survgroup

# Load required packages
library(maftools)
library(survival)
library(survminer)

# Parameters
maf_rds_path <- "/Users/linqingxuan/mcp_server/maftools_mcp/src/maftools_mcp/tcga_data/BRCA.rds"
geneSet <- c("TP53")
time_col <- "CDR_OS.time"
status_col <- "CDR_OS"
output_dir <- "/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/prompt_robustness/Qwen3.5-27B-MLX-7bit/case_03/run_03/outputs"
img_width <- 2600
img_height <- 2000

# Load MAF object
maf <- readRDS(maf_rds_path)

# Perform survival analysis for TP53
# Group by mutant vs wild-type
out <- mafSurvGroup(maf, 
                    geneSet = geneSet,
                    time_col = time_col,
                    status_col = status_col)

# Set output directory
setwd(output_dir)

# Generate survival plot
png("mafSurvGroup.png", 
    width = img_width, 
    height = img_height, 
    res = 300)
plot(out)
dev.off()

cat("Survival analysis complete. Plot saved as mafSurvGroup.png\n")