# Auto-exported by Maftools-MCP export_r_script for validation.

library(maftools)

# Load the merged MAF
merged_maf <- read.maf(maf = "/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/prompt_robustness/gemini-3.1-flash-lite/case_01/run_04/outputs/merged.maf")

# Define output path
output_dir <- "/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/prompt_robustness/gemini-3.1-flash-lite/case_01/run_04/outputs"
png_path <- file.path(output_dir, "oncoplot.png")

# Generate the oncoplot
png(png_path, width = 2600, height = 2000, res = 300)
oncoplot(
  maf = merged_maf,
  top = 20,
  fontSize = 0.8,
  SampleNamefontSize = 1,
  titleFontSize = 1.5,
  legendFontSize = 1.2
)
dev.off()
