# Workflow / Tool-call sequence — run_03

Chronological log of the agent's actual steps.

## Phase A — Skill + Environment discovery

1. `skill(annovar)` — loaded ANNOVAR skill.
2. `todowrite` — created 6-item plan.
3. `bash: ls /Users/linqingxuan/maftools-mcp/ANNOVAR_test/` — found VCFs, prior-model dirs.
4. `bash: ls VCFs; wc -l` — 50 VCFs (Sample_01..Sample_64, sparse numbering).
5. `bash: ls claude-opus-4.7/run_03/` — empty (confirmed fresh run).
6. `bash: locate annovar via ls ~ and which table_annovar.pl` — found `/Users/linqingxuan/annovar/annovar`.
7. `bash: ls /Users/linqingxuan/annovar/annovar/humandb/` — only hg19_refGene / hg38_ensGene / hg38_refGeneWithVer installed.
8. `bash: head -30 VCFs/Sample_01.vcf` — confirmed `assembly=hg19`, MuTect source.

Decision: `-buildver hg19 -protocol refGene -operation g -vcfinput`.

## Phase B — Annotation (all 50 VCFs)

9. `bash: mkdir -p run_03/{annovar_outputs,logs,maftools_outputs,r_scripts}`
10. `bash: /tmp/run_annovar_50.sh` — for each VCF ran

    ```
    perl table_annovar.pl <VCF> humandb/ \
      -buildver hg19 -out annovar_outputs/<sample> \
      -protocol refGene -operation g \
      -remove -polish -vcfinput -nastring .
    ```

    50 successes, 0 failures. Wrote `logs/annotation_summary.tsv`.
11. `bash: ls annovar_outputs | grep -c multianno.txt` → **50**.

## Phase C — Merge to cohort MAF

12. `maftools_merge_annovar_to_maf(annovar_files=["…/annovar_outputs/*.hg19_multianno.txt"], basename="cohort_merged", refBuild="hg19", table="refGene", output_dir="…/maftools_outputs")` → `cohort_merged.maf` (4 939 records).
13. `maftools_summarize_maf(maf_path=cohort_merged.maf)` — 50 samples enumerated, TMB per sample confirmed.

## Phase D — Oncoplot

14. `maftools_plot_oncoplot(maf_path=cohort_merged.maf, top=20, out_name="top20_oncoplot.png", titleText="Cohort Top-20 Oncoplot (n=50, hg19, ANNOVAR refGene)", output_dir=…/maftools_outputs)` → PNG produced.
15. `maftools_export_r_script(tool_name="plot_oncoplot", parameters=<same>, script_basename="top20_oncoplot")` → `r_scripts/top20_oncoplot.R`.

## Phase E — Validation counts & bookkeeping

16. `bash` — computed record count, sample count (50), gene count (3 767), variant-class breakdown.
17. `bash` — per-sample MAF-record counts → `logs/per_sample_maf_counts.tsv`.
18. `bash` — joined ANNOVAR vs MAF counts → `logs/validation_counts.tsv`.
19. `write RUN_RECORD.md` (this run's summary).
20. `write run_record.json` (machine-readable).
21. `write logs/workflow.md` (this file).

No downloads. No modifications to `humandb/`. No use of other models' outputs.
