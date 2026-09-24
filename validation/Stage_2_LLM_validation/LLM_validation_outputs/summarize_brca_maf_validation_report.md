# BRCA MAF Summary Validation

## MCP analysis

- Tool: `summarize_maf`
- Parameters:
  - `maf_path`: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_input_file/BRCA.maf`
- Status: succeeded using the validation input path resolved for MCP execution.
- Underlying exported R/Maftools function: `maftools::getSampleSummary`

## Observed MCP output

The MCP tool returned a sample-level mutation-class summary with 1,026 sample rows and columns:

`Tumor_Sample_Barcode`, `Frame_Shift_Del`, `Frame_Shift_Ins`, `In_Frame_Del`, `In_Frame_Ins`, `Missense_Mutation`, `Nonsense_Mutation`, `Nonstop_Mutation`, `Splice_Site`, `Translation_Start_Site`, `total`.

Leading sample rows observed:

| Tumor_Sample_Barcode | Frame_Shift_Del | Frame_Shift_Ins | In_Frame_Del | In_Frame_Ins | Missense_Mutation | Nonsense_Mutation | Nonstop_Mutation | Splice_Site | Translation_Start_Site | total |
|---|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| TCGA-AN-A046-01A-21W-A050-09 | 3 | 12 | 0 | 0 | 4497 | 757 | 6 | 91 | 0 | 5366 |
| TCGA-AC-A23H-01A-11D-A159-09 | 16 | 3 | 1 | 0 | 3647 | 404 | 7 | 73 | 10 | 4161 |
| TCGA-EW-A2FV-01A-11D-A17D-09 | 3846 | 0 | 0 | 0 | 19 | 0 | 0 | 34 | 0 | 3899 |
| TCGA-D8-A27V-01A-12D-A17D-09 | 2875 | 0 | 1 | 0 | 140 | 16 | 0 | 45 | 1 | 3078 |
| TCGA-BH-A18G-01A-11D-A12B-09 | 128 | 40 | 12 | 0 | 974 | 46 | 1 | 33 | 2 | 1236 |

Trailing sample rows observed:

| Tumor_Sample_Barcode | total |
|---|---:|
| TCGA-PL-A8LY-01A-11D-A41F-09 | 4 |
| TCGA-LL-A440-01A-11D-A243-09 | 3 |
| TCGA-EW-A1P1-01A-31D-A14G-09 | 2 |
| TCGA-AC-A2FK-01A-12D-A17W-09 | 1 |
| TCGA-BH-A1FE-06A-11D-A20S-09 | 1 |

## Supplemental MAF context

These values were inspected directly from the same maftools-loaded MAF object for overall, gene-level, and field context:

- Variant rows: 85,864
- Tumor samples: 1,026
- Unique genes: 16,686
- Top genes by total mutation count: PIK3CA 393, TP53 356, TTN 321, CDH1 132, GATA3 131
- Fields: `Hugo_Symbol`, `Chromosome`, `Start_Position`, `End_Position`, `Variant_Classification`, `Variant_Type`, `Reference_Allele`, `Tumor_Seq_Allele2`, `Tumor_Sample_Barcode`, `Matched_Norm_Sample_Barcode`, `HGVSc`, `HGVSp_Short`, `Transcript_ID`, `Exon_Number`, `t_ref_count`, `t_alt_count`, `n_ref_count`, `n_alt_count`, `IMPACT`, `ExAC_AF`, `IMPACT`, `FILTER`, `Tumor_Sample_Barcode_min`

## R-script export and direct validation

- Exported R script: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/exported_r_scripts/summarize_brca_maf.R`
- Direct R output: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/summary.txt`
- Named direct R output copy: `maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/summarize_brca_maf.direct_r.txt`
- Direct R status: succeeded with Rscript 4.5.1.
- Direct R key results: 1,026 samples; top sample `TCGA-AN-A046-01A-21W-A050-09` total 5,366; second sample `TCGA-AC-A23H-01A-11D-A159-09` total 4,161; summed sample totals 85,864.

## Consistency

The direct R output matches the observed MCP output for the printed sample-summary structure and key leading/trailing sample totals.
