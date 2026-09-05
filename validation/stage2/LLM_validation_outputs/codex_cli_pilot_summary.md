# Codex CLI Stage 2 Pilot Summary

Analytical validation cases completed: 55
Analytical consistent: 55
Analytical inconsistent: 0
Informational/reference MCP content checks: 5
Informational/reference MCP content checks successful: 5
Validation note: Stage 2 LLM-driven validation was performed using Codex CLI with model gpt-5.5, reasoning effort medium, connected to the maftools-mcp server.

Note: human-readable paths below are relative to `LLM_Stage2_validation`. Raw JSONL logs are preserved as execution evidence and may contain local absolute paths because the MCP server resolved files from its own working directory.

## merge_annovar_to_maf
- LLM-selected tool: `merge_annovar_to_maf`
- MCP execution: `Success`
- Observed MCP output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/merged.mcp.maf`
- Exported R script: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/exported_r_scripts/merge_annovar_to_maf_merged.R`
- Direct R output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/merged.direct_r.maf`
- Consistency: `Consistent`
- LLM Execution log: `JSONL: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/merge_annovar_to_maf.jsonl; Final: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/merge_annovar_to_maf.final.txt`

## merge_maf_to_mafobj
- LLM-selected tool: `merge_maf_to_mafobj`
- MCP execution: `Success`
- Observed MCP output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/stage2_maf_merge.mcp.maf`
- Exported R script: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/exported_r_scripts/stage2_merge_maf_to_mafobj.R`
- Direct R output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/stage2_maf_merge.direct_r.maf`
- Consistency: `Consistent`
- LLM Execution log: `JSONL: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/merge_maf_to_mafobj.jsonl; Final: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/merge_maf_to_mafobj.final.txt`

## rds_to_maf
- LLM-selected tool: `rds_to_maf`
- MCP execution: `Success`
- Observed MCP output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/maf_data.mcp.maf`
- Exported R script: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/exported_r_scripts/rds_to_maf_maf_data.R`
- Direct R output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/maf_data.direct_r.maf`
- Consistency: `Consistent`
- LLM Execution log: `JSONL: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/rds_to_maf.jsonl; Final: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/rds_to_maf.final.txt`

## load_tcga_data
- LLM-selected tool: `load_tcga_data`
- MCP execution: `Success`
- Observed MCP output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/mcp_preserved_outputs/COAD.rds; maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/mcp_preserved_outputs/COAD.maf`
- Exported R script: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/exported_r_scripts/load_tcga_data_COAD.R`
- Direct R output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/direct_r_outputs/COAD.rds; maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/direct_r_outputs/COAD.maf`
- Consistency: `Consistent`
- LLM Execution log: `JSONL: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/load_tcga_data.retry.jsonl; Final: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/load_tcga_data.retry.final.txt`

## load_pcawg_data
- LLM-selected tool: `load_pcawg_data`
- MCP execution: `Success`
- Observed MCP output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/mcp_preserved_outputs/Biliary-AdenoCA.mcp.rds; maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/mcp_preserved_outputs/Biliary-AdenoCA.mcp.maf`
- Exported R script: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/exported_r_scripts/load_pcawg_biliary_adenoca.R`
- Direct R output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/direct_r_outputs/Biliary-AdenoCA.direct_r.rds; maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/direct_r_outputs/Biliary-AdenoCA.direct_r.maf; maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/direct_r_outputs/load_pcawg_biliary_adenoca.comparison.txt`
- Consistency: `Consistent`
- LLM Execution log: `JSONL: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/load_pcawg_data.jsonl; Final: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/load_pcawg_data.final.txt`

## load_tcga_gistic
- LLM-selected tool: `load_tcga_gistic`
- MCP execution: `Success`
- Observed MCP output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/tcga_gistic/ACC_gistic_all.mcp.rds`
- Exported R script: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/exported_r_scripts/load_tcga_gistic_ACC_all.R`
- Direct R output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/tcga_gistic/ACC_gistic_all.rds`
- Consistency: `Consistent`
- LLM Execution log: `JSONL: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/load_tcga_gistic.jsonl; Final: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/load_tcga_gistic.final.txt`

## list_genes
- LLM-selected tool: `list_genes`
- MCP execution: `Success`
- Observed MCP output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/list_genes__gene_list.txt`
- Exported R script: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/exported_r_scripts/list_genes.R`
- Direct R output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/list_genes__gene_list.txt`
- Consistency: `Consistent`
- LLM Execution log: `JSONL: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/list_genes.retry_fullaccess.jsonl; Final: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/list_genes.retry_fullaccess.final.txt`

## list_samples
- LLM-selected tool: `list_samples`
- MCP execution: `Success`
- Observed MCP output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/list_samples__sample_list.mcp.txt`
- Exported R script: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/exported_r_scripts/list_samples.R`
- Direct R output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/list_samples.direct_r.log`
- Consistency: `Consistent`
- LLM Execution log: `JSONL: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/list_samples.jsonl; Final: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/list_samples.final.txt`

## summarize_maf
- LLM-selected tool: `summarize_maf`
- MCP execution: `Success`
- Observed MCP output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/summary.txt`
- Exported R script: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/exported_r_scripts/summarize_brca_maf.R`
- Direct R output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/summarize_brca_maf.direct_r.txt`
- Consistency: `Consistent`
- LLM Execution log: `JSONL: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/summarize_maf.jsonl; Final: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/summarize_maf.final.txt`

## genotype_matrix
- LLM-selected tool: `genotype_matrix`
- MCP execution: `Success`
- Observed MCP output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/genotype_matrix.mcp.tsv`
- Exported R script: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/exported_r_scripts/genotype_matrix_brca_tp53_pik3ca_gata3.R`
- Direct R output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/genotype_matrix.direct_r.tsv; maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/genotype_matrix.direct_r.log`
- Consistency: `Consistent`
- LLM Execution log: `JSONL: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/genotype_matrix.jsonl; Final: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/genotype_matrix.final.txt`

## get_clinical_data
- LLM-selected tool: `get_clinical_data`
- MCP execution: `Success`
- Observed MCP output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/clinical_data.mcp.tsv`
- Exported R script: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/exported_r_scripts/get_clinical_data_brca.R`
- Direct R output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/clinical_data.direct_r.tsv; maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/get_clinical_data.direct_r.log`
- Consistency: `Consistent`
- LLM Execution log: `JSONL: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/get_clinical_data.jsonl; Final: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/get_clinical_data.final.txt`

## get_fields
- LLM-selected tool: `get_fields`
- MCP execution: `Success`
- Observed MCP output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/maf_fields.mcp.tsv`
- Exported R script: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/exported_r_scripts/get_fields_brca.R`
- Direct R output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/maf_fields.direct_r.tsv`
- Consistency: `Consistent`
- LLM Execution log: `JSONL: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/get_fields.jsonl; Final: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/get_fields.final.txt`

## get_gene_summary
- LLM-selected tool: `get_gene_summary`
- MCP execution: `Success`
- Observed MCP output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/gene_summary.mcp.tsv`
- Exported R script: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/exported_r_scripts/get_gene_summary_brca.R`
- Direct R output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/gene_summary.direct_r.tsv`
- Consistency: `Consistent`
- LLM Execution log: `JSONL: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/get_gene_summary.jsonl; Final: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/get_gene_summary.final.txt`

## get_sample_summary
- LLM-selected tool: `get_sample_summary`
- MCP execution: `Success`
- Observed MCP output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/sample_summary.mcp.tsv`
- Exported R script: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/exported_r_scripts/get_sample_summary_brca.R`
- Direct R output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/sample_summary.direct_r.tsv; maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/get_sample_summary.direct_r.log`
- Consistency: `Consistent`
- LLM Execution log: `JSONL: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/get_sample_summary.jsonl; Final: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/get_sample_summary.final.txt`

## mutcount_matrix
- LLM-selected tool: `mutcount_matrix`
- MCP execution: `Success`
- Observed MCP output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/mutcount_matrix.mcp.tsv`
- Exported R script: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/exported_r_scripts/mutcount_matrix_brca_no_syn_remove_nonmutated.R`
- Direct R output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/mutcount_matrix.direct_r.tsv`
- Consistency: `Consistent`
- LLM Execution log: `JSONL: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/mutcount_matrix.jsonl; Final: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/mutcount_matrix.final.txt`

## plot_summary
- LLM-selected tool: `plot_summary`
- MCP execution: `Success`
- Observed MCP output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/plot_summary.mcp.png`
- Exported R script: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/exported_r_scripts/plot_summary_brca_top10.R`
- Direct R output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/plot_summary.direct_r.log`
- Consistency: `Consistent`
- LLM Execution log: `JSONL: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/plot_summary.jsonl; Final: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/plot_summary.final.txt`

## plot_oncoplot
- LLM-selected tool: `plot_oncoplot`
- MCP execution: `Success`
- Observed MCP output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/oncoplot.mcp.png`
- Exported R script: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/exported_r_scripts/oncoplot.R`
- Direct R output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/oncoplot.png`
- Consistency: `Consistent`
- LLM Execution log: `JSONL: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/plot_oncoplot.jsonl; Final: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/plot_oncoplot.final.txt`

## plot_vaf
- LLM-selected tool: `plot_vaf`
- MCP execution: `Success`
- Observed MCP output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/vaf_plot.mcp.png`
- Exported R script: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/exported_r_scripts/plot_vaf_brca_top10_t_vaf.R`
- Direct R output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/vaf_plot.direct_r.png; maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/plot_vaf.direct_r.log`
- Consistency: `Consistent`
- LLM Execution log: `JSONL: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/plot_vaf.jsonl; Final: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/plot_vaf.final.txt`

## plot_tcga_compare
- LLM-selected tool: `plot_tcga_compare`
- MCP execution: `Success`
- Observed MCP output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/tcga_compare.mcp.preserved.png`
- Exported R script: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/exported_r_scripts/plot_tcga_compare_brca_tcga35_8_log_rmzero_keep_hyper.R`
- Direct R output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/tcga_compare.direct_r.png`
- Consistency: `Consistent`
- LLM Execution log: `JSONL: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/plot_tcga_compare.jsonl; Final: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/plot_tcga_compare.final.txt`

## plot_cooncoplot
- LLM-selected tool: `plot_cooncoplot`
- MCP execution: `Success`
- Observed MCP output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/cooncoplot.mcp.preserved.png`
- Exported R script: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/exported_r_scripts/plot_cooncoplot_cohort1_vs_cohort2_top10.R`
- Direct R output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/cooncoplot.direct_r.png`
- Consistency: `Consistent`
- LLM Execution log: `JSONL: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/plot_cooncoplot.jsonl; Final: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/plot_cooncoplot.final.txt`

## plot_cobarplot
- LLM-selected tool: `plot_cobarplot`
- MCP execution: `Success`
- Observed MCP output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/coBarplot.mcp.preserved.png`
- Exported R script: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/exported_r_scripts/plot_cobarplot_cohort1_vs_cohort2.R`
- Direct R output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/coBarplot.direct_r.png`
- Consistency: `Consistent`
- LLM Execution log: `JSONL: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/plot_cobarplot.jsonl; Final: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/plot_cobarplot.final.txt`

## plot_tmb
- LLM-selected tool: `plot_tmb`
- MCP execution: `Success`
- Observed MCP output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/tmb.mcp.png`
- Exported R script: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/exported_r_scripts/plot_tmb_brca_50mb_logscale.R`
- Direct R output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/tmb.direct_r.png`
- Consistency: `Consistent`
- LLM Execution log: `JSONL: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/plot_tmb.jsonl; Final: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/plot_tmb.final.txt`

## plot_vaf_compare
- LLM-selected tool: `plot_vaf_compare`
- MCP execution: `Success`
- Observed MCP output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/vaf_compare.mcp.preserved.png`
- Exported R script: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/exported_r_scripts/plot_vaf_compare_cohort1_vs_cohort2_top5.R`
- Direct R output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/vaf_compare.direct_r.png`
- Consistency: `Consistent`
- LLM Execution log: `JSONL: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/plot_vaf_compare.jsonl; Final: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/plot_vaf_compare.final.txt`

## plot_titv
- LLM-selected tool: `plot_titv`
- MCP execution: `Success`
- Observed MCP output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/titv_plot.mcp.png`
- Exported R script: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/exported_r_scripts/plot_titv_brca_useSyn_both.R`
- Direct R output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/titv_plot.direct_r.png`
- Consistency: `Consistent`
- LLM Execution log: `JSONL: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/plot_titv.jsonl; Final: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/plot_titv.final.txt`

## compare_maf_forestplot
- LLM-selected tool: `compare_maf_forestplot`
- MCP execution: `Success`
- Observed MCP output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/forestPlot.mcp.preserved.png`
- Exported R script: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/exported_r_scripts/compare_maf_forestplot_stage2_validation.R`
- Direct R output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/forestPlot.direct_r.png; maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/compare_maf_forestplot.direct_r.results.tsv`
- Consistency: `Consistent`
- LLM Execution log: `JSONL: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/compare_maf_forestplot.jsonl; Final: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/compare_maf_forestplot.final.txt`

## trinucleotide_matrix
- LLM-selected tool: `trinucleotide_matrix`
- MCP execution: `Success`
- Observed MCP output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/trinuc_matrix.mcp.rds`
- Exported R script: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/exported_r_scripts/trinucleotide_matrix_brca_hg19_add_chr.R`
- Direct R output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/trinuc_matrix.rds`
- Consistency: `Consistent`
- LLM Execution log: `JSONL: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/trinucleotide_matrix.jsonl; Final: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/trinucleotide_matrix.final.txt`

## estimate_signatures
- LLM-selected tool: `estimate_signatures`
- MCP execution: `Success`
- Observed MCP output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/estimateSignatures.mcp.nmfSummary.tsv`
- Exported R script: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/exported_r_scripts/estimate_signatures_rank2_6_nrun10.R`
- Direct R output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/estimateSignatures.direct_r.rds; maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/estimateSignatures.direct_r.nmfSummary.tsv`
- Consistency: `Consistent`
- LLM Execution log: `JSONL: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/estimate_signatures.jsonl; Final: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/estimate_signatures.final.txt`

## plot_cophenetic
- LLM-selected tool: `plot_cophenetic`
- MCP execution: `Success`
- Observed MCP output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/cophenetic_plot.mcp.preserved.png`
- Exported R script: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/exported_r_scripts/plot_cophenetic_estimateSignatures.R`
- Direct R output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/cophenetic_plot.direct_r.png; maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/plot_cophenetic.direct_r.log`
- Consistency: `Consistent`
- LLM Execution log: `JSONL: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/plot_cophenetic.jsonl; Final: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/plot_cophenetic.final.txt`

## extract_signatures
- LLM-selected tool: `extract_signatures`
- MCP execution: `Success`
- Observed MCP output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/extractSignatures.rds; maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/signatures.rds; maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/contributions.rds`
- Exported R script: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/exported_r_scripts/extract_signatures_n6_parallel4.R`
- Direct R output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/extractSignatures.direct_r.rds; maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/extractSignatures.direct_r.summary.txt`
- Consistency: `Consistent`
- LLM Execution log: `JSONL: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/extract_signatures.jsonl; Final: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/extract_signatures.final.txt`

## compare_signatures
- LLM-selected tool: `compare_signatures`
- MCP execution: `Success`
- Observed MCP output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/compareSignatures.mcp.preserved.rds; maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/similarity_matrix.cosine_similarities.mcp.tsv`
- Exported R script: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/exported_r_scripts/compare_signatures__legacy_cosmic_retry.R`
- Direct R output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/compareSignatures.direct_r.rds`
- Consistency: `Consistent`
- LLM Execution log: `JSONL: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/compare_signatures.jsonl; Final: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/compare_signatures.final.txt`

## plot_signatures
- LLM-selected tool: `plot_signatures`
- MCP execution: `Success`
- Observed MCP output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/signature_profiles.mcp.preserved.png`
- Exported R script: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/exported_r_scripts/plot_signatures_profiles_no_contributions_retry.R`
- Direct R output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/signature_profiles.direct_r.png; maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/plot_signatures_profiles_no_contributions_retry.direct_r.log`
- Consistency: `Consistent`
- LLM Execution log: `JSONL: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/plot_signatures.jsonl; Final: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/plot_signatures.final.txt`

## prepare_mutsig
- LLM-selected tool: `prepare_mutsig`
- MCP execution: `Success`
- Observed MCP output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/BRCA.prepare_mutsig.mcp.mutSig.maf`
- Exported R script: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/exported_r_scripts/prepare_mutsig_brca.R`
- Direct R output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/prepare_mutsig.comparison.txt`
- Consistency: `Consistent`
- LLM Execution log: `JSONL: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/prepare_mutsig.jsonl; Final: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/prepare_mutsig.final.txt`

## math_score
- LLM-selected tool: `math_score`
- MCP execution: `Success`
- Observed MCP output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/math_score.mcp.tsv`
- Exported R script: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/exported_r_scripts/math_score_brca_vafcutoff_0.075.R`
- Direct R output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/math_score.direct_r.tsv`
- Consistency: `Consistent`
- LLM Execution log: `JSONL: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/math_score.jsonl; Final: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/math_score.final.txt`

## drug_interactions
- LLM-selected tool: `drug_interactions`
- MCP execution: `Success`
- Observed MCP output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/drug_interactions.mcp.preserved.png`
- Exported R script: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/exported_r_scripts/drug_interactions_brca_top20_categories_bar_no_drugs.R`
- Direct R output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/drug_interactions.direct_r.png`
- Consistency: `Consistent`
- LLM Execution log: `JSONL: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/drug_interactions.jsonl; Final: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/drug_interactions.final.txt`

## infer_heterogeneity
- LLM-selected tool: `infer_heterogeneity`
- MCP execution: `Success`
- Observed MCP output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/heterogeneity_clusters.mcp.preserved.png`
- Exported R script: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/exported_r_scripts/infer_heterogeneity_brca_top5_nonsyn_vaf0_1.R`
- Direct R output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/heterogeneity_clusters.direct_r.png`
- Consistency: `Consistent`
- LLM Execution log: `JSONL: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/infer_heterogeneity.jsonl; Final: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/infer_heterogeneity.final.txt`

## plot_lollipop
- LLM-selected tool: `plot_lollipop`
- MCP execution: `Success`
- Observed MCP output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/lollipop_TP53.mcp.preserved.png`
- Exported R script: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/exported_r_scripts/plot_lollipop_brca_tp53.R`
- Direct R output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/lollipop_TP53.direct_r.png`
- Consistency: `Consistent`
- LLM Execution log: `JSONL: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/plot_lollipop.jsonl; Final: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/plot_lollipop.final.txt`

## plot_rainfall
- LLM-selected tool: `plot_rainfall`
- MCP execution: `Success`
- Observed MCP output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/rainfall_TCGA-3C-AAAU-01A-11D-A41F-09.mcp.preserved.png`
- Exported R script: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/exported_r_scripts/plot_rainfall_brca_tcga_3c_aaau_no_changepoints.R`
- Direct R output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/rainfall_TCGA-3C-AAAU-01A-11D-A41F-09.direct_r.png`
- Consistency: `Consistent`
- LLM Execution log: `JSONL: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/plot_rainfall.jsonl; Final: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/plot_rainfall.final.txt`

## plot_lollipopPlot2
- LLM-selected tool: `plot_lollipopPlot2`
- MCP execution: `Success`
- Observed MCP output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/lollipopPlot2_TP53.mcp.preserved.png`
- Exported R script: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/exported_r_scripts/plot_lollipopPlot2_cohort1_vs_cohort2_TP53.R`
- Direct R output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/lollipopPlot2_TP53.direct_r.png`
- Consistency: `Consistent`
- LLM Execution log: `JSONL: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/plot_lollipopPlot2.jsonl; Final: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/plot_lollipopPlot2.final.txt`

## plot_pfam_domains
- LLM-selected tool: `plot_pfam_domains`
- MCP execution: `Success`
- Observed MCP output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/pfam_domains.mcp.preserved.png`
- Exported R script: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/exported_r_scripts/plot_pfam_domains_stage2_validation.R`
- Direct R output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/plot_pfam_domains.comparison.txt`
- Consistency: `Consistent`
- LLM Execution log: `JSONL: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/plot_pfam_domains.jsonl; Final: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/plot_pfam_domains.final.txt`

## plot_apobec_diff
- LLM-selected tool: `plot_apobec_diff`
- MCP execution: `Success`
- Observed MCP output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/apobec_diff.mcp.preserved.png`
- Exported R script: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/exported_r_scripts/plot_apobec_diff_signature_enrichment_source_pval0_05.R`
- Direct R output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/apobec_diff.direct_r.png; maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/plot_apobec_diff_signature_enrichment_source_pval0_05.direct_r.log`
- Consistency: `Consistent`
- LLM Execution log: `JSONL: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/plot_apobec_diff.jsonl; Final: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/plot_apobec_diff.final.txt`

## clinical_enrichment
- LLM-selected tool: `clinical_enrichment`
- MCP execution: `Success`
- Observed MCP output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/clinical_enrichment_results.mcp.preserved.txt`
- Exported R script: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/exported_r_scripts/clinical_enrichment_brca_er_status_minmut5.R`
- Direct R output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/clinical_enrichment.comparison.txt`
- Consistency: `Consistent`
- LLM Execution log: `JSONL: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/clinical_enrichment.jsonl; Final: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/clinical_enrichment.final.txt`

## signature_enrichment
- LLM-selected tool: `signature_enrichment`
- MCP execution: `Success`
- Observed MCP output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/signature_enrichment.mcp.preserved.retry.png`
- Exported R script: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/exported_r_scripts/signature_enrichment_brca_er_status_retry.R`
- Direct R output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/signature_enrichment.direct_r.retry.png`
- Consistency: `Consistent`
- LLM Execution log: `JSONL: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/signature_enrichment.jsonl; Final: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/signature_enrichment.final.txt`

## plot_maf_survgroup
- LLM-selected tool: `plot_maf_survgroup`
- MCP execution: `Success`
- Observed MCP output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/mafSurvGroup_TP53_CDR_OS.mcp.preserved.png`
- Exported R script: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/exported_r_scripts/plot_maf_survgroup_brca_tp53_cdr_os.R`
- Direct R output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/mafSurvGroup_TP53_CDR_OS.direct_r.png`
- Consistency: `Consistent`
- LLM Execution log: `JSONL: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/plot_maf_survgroup.jsonl; Final: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/plot_maf_survgroup.final.txt`

## plot_maf_survgroup_custom
- LLM-selected tool: `plot_maf_survgroup_custom`
- MCP execution: `Success`
- Observed MCP output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/mafSurvGroup_CUSTOM.mcp.preserved.png`
- Exported R script: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/exported_r_scripts/plot_maf_survgroup_custom_TP53.R`
- Direct R output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/mafSurvGroup_CUSTOM.direct_r.png; maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/plot_maf_survgroup_custom_TP53.direct_r.log`
- Consistency: `Consistent`
- LLM Execution log: `JSONL: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/plot_maf_survgroup_custom.jsonl; Final: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/plot_maf_survgroup_custom.final.txt`

## filter_maf
- LLM-selected tool: `filter_maf`
- MCP execution: `Success`
- Observed MCP output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/filtered_maf.mcp.tsv`
- Exported R script: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/exported_r_scripts/filter_maf_brca_default_gene_filter.R`
- Direct R output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/filter_maf.comparison.txt`
- Consistency: `Consistent`
- LLM Execution log: `JSONL: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/filter_maf.jsonl; Final: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/filter_maf.final.txt`

## subset_maf
- LLM-selected tool: `subset_maf`
- MCP execution: `Success`
- Observed MCP output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/subset_maf.mcp.tsv`
- Exported R script: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/exported_r_scripts/subset_maf_brca_tp53.R`
- Direct R output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/subset_maf.comparison.txt`
- Consistency: `Consistent`
- LLM Execution log: `JSONL: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/subset_maf.jsonl; Final: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/subset_maf.final.txt`

## genes_to_barcodes
- LLM-selected tool: `genes_to_barcodes`
- MCP execution: `Success`
- Observed MCP output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/genes_to_barcodes.mcp.tsv`
- Exported R script: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/exported_r_scripts/genes_to_barcodes_brca_tp53_full_metadata.R`
- Direct R output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/genes_to_barcodes.direct_r.tsv`
- Consistency: `Consistent`
- LLM Execution log: `JSONL: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/genes_to_barcodes.jsonl; Final: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/genes_to_barcodes.final.txt`

## gistic_bubble_plot
- LLM-selected tool: `gistic_bubble_plot`
- MCP execution: `Success`
- Observed MCP output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/gistic_bubble_plot.mcp.preserved.png`
- Exported R script: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/exported_r_scripts/gistic_bubble_plot_acc_fdr0_1_logy.R`
- Direct R output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/gistic_bubble_plot.direct_r.png`
- Consistency: `Consistent`
- LLM Execution log: `JSONL: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/gistic_bubble_plot.jsonl; Final: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/gistic_bubble_plot.final.txt`

## gistic_chrom_plot
- LLM-selected tool: `gistic_chrom_plot`
- MCP execution: `Success`
- Observed MCP output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/gistic_chrom_plot.mcp.preserved.png`
- Exported R script: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/exported_r_scripts/gistic_chrom_plot_acc_fdr0.1_hg19.R`
- Direct R output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/gistic_chrom_plot.direct_r.png`
- Consistency: `Consistent`
- LLM Execution log: `JSONL: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/gistic_chrom_plot.jsonl; Final: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/gistic_chrom_plot.final.txt`

## gistic_oncoplot
- LLM-selected tool: `gistic_oncoplot`
- MCP execution: `Success`
- Observed MCP output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/gistic_oncoplot.mcp.preserved.png`
- Exported R script: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/exported_r_scripts/gistic_oncoplot_acc_no_barcodes.R`
- Direct R output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/gistic_oncoplot.direct_r.png`
- Consistency: `Consistent`
- LLM Execution log: `JSONL: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/gistic_oncoplot.jsonl; Final: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/gistic_oncoplot.final.txt`

## plot_cbs_segments
- LLM-selected tool: `plot_cbs_segments`
- MCP execution: `Success`
- Observed MCP output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/CBS_segments.mcp.preserved.png`
- Exported R script: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/exported_r_scripts/plot_cbs_segments_tcga_ab_3009_hg19.R`
- Direct R output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/CBS_segments.direct_r.png; maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/plot_cbs_segments.direct_r.log`
- Consistency: `Consistent`
- LLM Execution log: `JSONL: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/plot_cbs_segments.jsonl; Final: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/plot_cbs_segments.final.txt`

## oncodrive
- LLM-selected tool: `oncodrive`
- MCP execution: `Success`
- Observed MCP output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/oncodrive.mcp.tsv`
- Exported R script: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/exported_r_scripts/oncodrive_brca_minmut5_zscore_bg100.R`
- Direct R output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/oncodrive.direct_r.tsv; maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/oncodrive.direct_r.log`
- Consistency: `Consistent`
- LLM Execution log: `JSONL: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/oncodrive.jsonl; Final: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/oncodrive.final.txt`

## pathway_enrichment
- LLM-selected tool: `pathway_enrichment`
- MCP execution: `Success`
- Observed MCP output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/pathways_enrichment.mcp.tsv; maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/pathways_plot.mcp.preserved.png`
- Exported R script: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/exported_r_scripts/pathway_enrichment_brca_sigpw_bar_orange.R`
- Direct R output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/pathways_enrichment.direct_r.tsv; maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/pathways_plot.direct_r.png`
- Consistency: `Consistent`
- LLM Execution log: `JSONL: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/pathway_enrichment.jsonl; Final: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/pathway_enrichment.final.txt`

## oncodrive_analysis
- LLM-selected tool: `oncodrive_analysis`
- MCP execution: `Success`
- Observed MCP output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/oncodrive_result.tsv; maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/oncodrive_result.rds; maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/oncodrive_plot.png`
- Exported R script: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/exported_r_scripts/oncodrive_analysis_brca_minmut5_zscore_bg100_fdr1.R`
- Direct R output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/oncodrive_analysis.comparison.txt`
- Consistency: `Consistent`
- LLM Execution log: `JSONL: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/oncodrive_analysis.jsonl; Final: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/oncodrive_analysis.final.txt`

## export_r_script
- LLM-selected tool: `plot_oncoplot; export_r_script`
- MCP execution: `Success`
- Observed MCP output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/oncoplot_stage2_top20.mcp.preserved.png`
- Exported R script: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/exported_r_scripts/plot_oncoplot_stage2_top20.R`
- Direct R output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/oncoplot_stage2_top20.direct_r.png`
- Consistency: `Consistent`
- LLM Execution log: `JSONL: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/export_r_script.jsonl; Final: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/export_r_script.final.txt`

## describe_maftools_mcp
- LLM-selected tool: `describe_maftools_mcp`
- MCP execution: `Success`
- Observed MCP output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/describe_maftools_mcp.jsonl; maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/describe_maftools_mcp.final.txt`
- Exported R script: `Not applicable`
- Direct R output: `Not applicable`
- Consistency: `Validation not required; MCP content verified`
- LLM Execution log: `JSONL: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/describe_maftools_mcp.jsonl; Final: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/describe_maftools_mcp.final.txt`

## maftools_docs
- LLM-selected tool: `maftools_docs`
- MCP execution: `Success`
- Observed MCP output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/maftools_docs.jsonl; maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/maftools_docs.final.txt`
- Exported R script: `Not applicable`
- Direct R output: `Not applicable`
- Consistency: `Validation not required; MCP content verified`
- LLM Execution log: `JSONL: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/maftools_docs.jsonl; Final: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/maftools_docs.final.txt`

## tcga_available
- LLM-selected tool: `tcga_available`
- MCP execution: `Success`
- Observed MCP output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/tcga_available.jsonl; maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/tcga_available.final.txt`
- Exported R script: `Not applicable`
- Direct R output: `Not applicable`
- Consistency: `Validation not required; MCP content verified`
- LLM Execution log: `JSONL: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/tcga_available.jsonl; Final: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/tcga_available.final.txt`

## pcawg_available
- LLM-selected tool: `pcawg_available`
- MCP execution: `Success`
- Observed MCP output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/pcawg_available.jsonl; maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/pcawg_available.final.txt`
- Exported R script: `Not applicable`
- Direct R output: `Not applicable`
- Consistency: `Validation not required; MCP content verified`
- LLM Execution log: `JSONL: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/pcawg_available.jsonl; Final: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/pcawg_available.final.txt`

## tcga_available_gistic
- LLM-selected tool: `tcga_available_gistic`
- MCP execution: `Success`
- Observed MCP output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/tcga_available_gistic.jsonl; maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/tcga_available_gistic.final.txt`
- Exported R script: `Not applicable`
- Direct R output: `Not applicable`
- Consistency: `Validation not required; MCP content verified`
- LLM Execution log: `JSONL: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/tcga_available_gistic.jsonl; Final: maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/LLM_execution_logs/tcga_available_gistic.final.txt`
