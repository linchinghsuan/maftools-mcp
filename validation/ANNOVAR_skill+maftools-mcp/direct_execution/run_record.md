# Direct ANNOVAR + Maftools-MCP reference run

- Workflow: direct local ANNOVAR execution followed by Maftools-MCP MAF merge and top-20 oncoplot generation
- Input cohort: 50 VCF files from `/Users/linqingxuan/maftools-mcp/ANNOVAR_test/VCFs`
- Genome build / annotation: hg19 / refGene / gene-based (`g`)
- ANNOVAR command sequence: `convert2annovar.pl -includeinfo -allsample -withfreq -format vcf4` converted each VCF to `.avinput`; `table_annovar.pl` then ran with `-buildver hg19 -protocol refGene -operation g -remove -polish -nastring . -thread 4 -otherinfo`; its gene-based annotation step invoked `annotate_variation.pl` with `-exonsort -nofirstcodondel`.
- ANNOVAR installation: `/Users/linqingxuan/annovar/annovar`
- Reference database: local `humandb/hg19_refGene.txt` and `hg19_refGeneMrna.fa` (database file timestamp 2025-03-03)
- ANNOVAR result: 50/50 annotation files; 20,963 multianno rows from 20,963 input VCF records
- MAF: 4,939 records; 50 samples; 3,767 unique genes
- Oncoplot: top 20 genes; 2600 × 2000 px, generated using Maftools-MCP
- Top 20 genes (Maftools gene summary order): TP53, TTN, FAT1, PIK3CA, CDKN2A, NOTCH1, CASP8, FAT3, MGAM, XIRP2, ADGRV1, MUC16, PCLO, ATAD3B, DCHS2, DDX11, FSIP2, ST18, KMT2C, RYR1
- Reference validation: exact per-file annotation match for all 50 expected files and exact full-table MAF match (all columns and rows) in 25/25 model runs

## Outputs

- Per-sample annotations: `annovar_annotations/*.hg19_multianno.txt` and `*.hg19_multianno.vcf`
- Per-sample ANNOVAR logs: `logs/*.annovar.log`
- Variant count audit: `counts/annovar_variant_counts.tsv`
- MAF gene summary: `counts/gene_summary.tsv`
- MAF sample summary: `counts/sample_summary.tsv`
- MAF fields: `counts/maf_fields.tsv`
- Merged cohort MAF: `maftools_outputs/direct_execution_merged.maf`
- Top-20 oncoplot: `maftools_outputs/direct_execution_top20_oncoplot.png`

## Comparison scope

Each of the 25 completed model runs (five models × five runs) was compared against this direct reference. Each run had the 50 corresponding named ANNOVAR multianno files compared byte-for-byte. Merged MAF tables were compared after parsing as tab-delimited data and sorting rows, while retaining and checking every column. All 25 runs matched exactly. One Qwen run also contains an extra file from a separately recorded aborted attempt; the 50 expected sample files were the comparison set.
