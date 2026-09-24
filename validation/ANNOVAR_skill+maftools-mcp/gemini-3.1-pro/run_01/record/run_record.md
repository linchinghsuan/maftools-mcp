# Run Record — Gemini 3.1 Pro, run_01

## Run context
- **Model:** Gemini 3.1 Pro
- **Run:** run_01
- **Agent/client:** OpenCode v1.18.31
- **Access method:** OpenRouter
- **Input cohort:** 50 VCF files from `VCFs/` (20,963 input variant records).

## ANNOVAR annotation code and evidence
- **Reference build / annotation:** hg19 / refGene, gene-based operation (`g`) where supported by the retained records.
- **Annotation result:** Pass — 50/50 ANNOVAR annotations succeeded; 20,963 multianno rows
- **Command evidence:**
- [Open ANNOVAR batch code: `run_annovar.sh`](../run_annovar.sh)
- Exact invocation details are available in the linked script/log where present. If no command source is listed above, the original exact command was not retained and has not been guessed.

## Workflow and Maftools-MCP tool calls
- **Expected workflow:** VCF → ANNOVAR skill → annotated VCF → merge_annovar_to_maf → plot_oncoplot → export_r_script
- **Observed workflow/tool-call sequence:** VCF → ANNOVAR skill → annotated VCF → merge_annovar_to_maf → plot_oncoplot → summarize_maf → export_r_script
- **Workflow agreement:** Compatible

## Outputs and validation
- **Execution:** Successful
- **Failure type:** None
- **Annotation output:** Pass — 50/50 ANNOVAR annotations succeeded; 20,963 multianno rows
- **MAF output:** Pass — cohort MAF generated; 4,939 records; 50 samples
- **Oncoplot output:** Pass — top-20 oncoplot generated
- **Variant-level annotation agreement:** 20,963/20,963 (100%)
- **MAF-level agreement:** 4,939/4,939 (100%)
- **Total tokens:** 440183
- **Estimated cost (USD):** 0.3541266

## Source record
- Prior run-level evidence listed in the workbook: `run_record.md`
