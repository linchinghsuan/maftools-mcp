# Auto-exported by Maftools-MCP export_r_script for validation.

library(maftools)

# Load the merged MAF
maf <- read.maf(maf = "/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/prompt_robustness/gemini-3.1-flash-lite/case_01/run_01/outputs/OSCC_cohort.maf")

# Generate the Oncoplot
oncoplot(
  maf = maf,
  top = 20,
  outName = "/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/prompt_robustness/gemini-3.1-flash-lite/case_01/run_01/outputs/oncoplot_top20.png"
)
