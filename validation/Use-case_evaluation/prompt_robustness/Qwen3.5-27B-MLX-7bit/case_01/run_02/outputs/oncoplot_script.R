# Auto-exported by Maftools-MCP export_r_script for validation.

library(maftools)

maf <- read.maf(maf="/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/prompt_robustness/Qwen3.5-27B-MLX-7bit/case_01/run_02/outputs/OSCC_merged.maf")

oncoplot(maf, top=20, out.file="/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/prompt_robustness/Qwen3.5-27B-MLX-7bit/case_01/run_02/outputs/oncoplot_top20.png")