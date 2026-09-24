# Run Record — GPT-5.5, run_03

## Run context
- **Model:** GPT-5.5
- **Run:** run_03
- **Agent/client:** OpenCode v1.18.31
- **Access method:** OpenRouter
- **Input cohort:** 50 VCF files from `VCFs/` (20,963 input variant records).

## ANNOVAR annotation code and evidence
- **Reference build / annotation:** hg19 / refGene, gene-based operation (`g`) where supported by the retained records.
- **Annotation result:** Pass — 50/50 ANNOVAR annotations succeeded; 20,963 multianno rows
- **Command evidence:**
- [Open ANNOVAR batch code: `scripts/run_annovar_annotation.sh`](../scripts/run_annovar_annotation.sh)
- Exact invocation details are available in the linked script/log where present. If no command source is listed above, the original exact command was not retained and has not been guessed.

## Workflow and Maftools-MCP tool calls
- **Expected workflow:** VCF → ANNOVAR skill → annotated VCF → merge_annovar_to_maf → plot_oncoplot → export_r_script
- **Observed workflow/tool-call sequence:** VCF → ANNOVAR skill → annotated VCF → merge_annovar_to_maf → export_r_script ×2 → plot_oncoplot → get_gene_summary → get_sample_summary → get_fields
- **Workflow agreement:** Deviated

## Outputs and validation
- **Execution:** Successful
- **Failure type:** None
- **Annotation output:** Pass — 50/50 ANNOVAR annotations succeeded; 20,963 multianno rows
- **MAF output:** Pass — cohort MAF generated; 4,939 records; 50 samples
- **Oncoplot output:** Pass — top-20 oncoplot generated
- **Variant-level annotation agreement:** 20,963/20,963 (100%)
- **MAF-level agreement:** 4,939/4,939 (100%)
- **Total tokens:** 828593
- **Estimated cost (USD):** 1.334871

## Source record
- Prior run-level evidence listed in the workbook: `records/run_record.md`

