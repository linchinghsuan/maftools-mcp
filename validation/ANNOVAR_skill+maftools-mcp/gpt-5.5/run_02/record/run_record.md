# Run Record — GPT-5.5, run_02

## Run context
- **Model:** GPT-5.5
- **Run:** run_02
- **Agent/client:** OpenCode v1.18.31
- **Access method:** OpenRouter
- **Input cohort:** 50 VCF files from `VCFs/` (20,963 input variant records).

## ANNOVAR annotation code and evidence
- **Reference build / annotation:** hg19 / refGene, gene-based operation (`g`) where supported by the retained records.
- **Annotation result:** Pass — 50/50 ANNOVAR annotations succeeded; 20,963 multianno rows
- **Command evidence:**
- [Open ANNOVAR batch code: `scripts/annotate_all.sh`](../scripts/annotate_all.sh)
- Exact invocation details are available in the linked script/log where present. If no command source is listed above, the original exact command was not retained and has not been guessed.

## Workflow and Maftools-MCP tool calls
- **Expected workflow:** VCF → ANNOVAR skill → annotated VCF → merge_annovar_to_maf → plot_oncoplot → export_r_script
- **Observed workflow/tool-call sequence:** VCF → ANNOVAR skill → annotated VCF → merge_annovar_to_maf → plot_oncoplot → summarize_maf → get_sample_summary → get_gene_summary → export_r_script
- **Workflow agreement:** Compatible

## Outputs and validation
- **Execution:** Successful
- **Failure type:** None
- **Annotation output:** Pass — 50/50 ANNOVAR annotations succeeded; 20,963 multianno rows
- **MAF output:** Pass — cohort MAF generated; 4,939 records; 50 samples
- **Oncoplot output:** Pass — top-20 oncoplot generated
- **Variant-level annotation agreement:** 20,963/20,963 (100%)
- **MAF-level agreement:** 4,939/4,939 (100%)
- **Total tokens:** 1436452
- **Estimated cost (USD):** 1.675898

## Source record
- Prior run-level evidence listed in the workbook: `run_record.md`

