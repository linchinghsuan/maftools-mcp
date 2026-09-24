# Run Record — Qwen3.5-27B-MLX-7bit, run_04

## Run context
- **Model:** Qwen3.5-27B-MLX-7bit
- **Run:** run_04
- **Agent/client:** OpenCode v1.18.31
- **Access method:** Local inference server
- **Input cohort:** 50 VCF files from `VCFs/` (20,963 input variant records).

## ANNOVAR annotation code and evidence
- **Reference build / annotation:** hg19 / refGene, gene-based operation (`g`) where supported by the retained records.
- **Annotation result:** Pass — 50/50 ANNOVAR annotations succeeded; 20,963 multianno rows
- **Command evidence:**
- The existing ANNOVAR outputs were reused for the downstream rerun. The original per-sample ANNOVAR command script was not retained in the available run files; no command has been reconstructed.
- Exact invocation details are available in the linked script/log where present. If no command source is listed above, the original exact command was not retained and has not been guessed.

## Workflow and Maftools-MCP tool calls
- **Expected workflow:** VCF → ANNOVAR skill → annotated VCF → merge_annovar_to_maf → plot_oncoplot → export_r_script
- **Observed workflow/tool-call sequence:** VCF → ANNOVAR skill → annotated VCF → merge_annovar_to_maf → plot_oncoplot → export_r_script
- **Workflow agreement:** Exact

## Outputs and validation
- **Execution:** Successful
- **Failure type:** None
- **Annotation output:** Pass — 50/50 ANNOVAR annotations succeeded; 20,963 multianno rows
- **MAF output:** Pass — cohort MAF generated; 4,939 records; 50 samples
- **Oncoplot output:** Pass — top-20 oncoplot generated
- **Variant-level annotation agreement:** 20,963/20,963 (100%)
- **MAF-level agreement:** 4,939/4,939 (100%)
- **Total tokens:** 165416
- **Estimated cost (USD):** 0
- **Telemetry note:** Token and cost values above belong to the previously recorded model run. The later direct downstream rerun did not invoke an LLM and generated no additional model tokens or API cost.

## Source record
- Prior run-level evidence listed in the workbook: `run_record.md`


## Subsequent direct downstream reprocessing
- Existing per-sample ANNOVAR outputs were reused; ANNOVAR was not rerun in this reprocessing.
- **Tool-call order:** `merge_annovar_to_maf` → `plot_oncoplot` → `export_r_script`.
- **Outputs:** `merged.maf` (4,939 records; 50 samples; 3,767 genes), `oncoplot.png` (top 20; 2600 × 2000 px), and `oncoplot.R`.
- **Reference check:** the MAF matched the direct-reference MAF byte-for-byte; the oncoplot matched the reference image pixel-for-pixel.
- **Model usage:** no LLM call was made for this reprocessing; no additional tokens or API cost were incurred.

