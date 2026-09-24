#!/bin/bash
# ANNOVAR annotation runner - run_04 (Claude Opus 4.7)
# Genome build: hg19 (from VCF ##contig assembly=hg19)
# Protocol: refGene (only hg19 gene database available in local humandb/)
# Operation: g (gene-based)
# Databases NOT downloaded or modified - using existing local install only.

set -u
ANNOVAR_DIR="/Users/linqingxuan/annovar/annovar"
HUMANDB="${ANNOVAR_DIR}/humandb"
VCF_DIR="/Users/linqingxuan/maftools-mcp/ANNOVAR_test/VCFs"
OUT_DIR="/Users/linqingxuan/maftools-mcp/ANNOVAR_test/claude-opus-4.7/run_04/annovar_outputs"
LOG_DIR="/Users/linqingxuan/maftools-mcp/ANNOVAR_test/claude-opus-4.7/run_04/logs"
SUMMARY_TSV="/Users/linqingxuan/maftools-mcp/ANNOVAR_test/claude-opus-4.7/run_04/annotation_summary.tsv"

printf "sample\tvcf_input\tstatus\tmultianno_txt\tnum_variants\texit_code\tstderr_log\n" > "$SUMMARY_TSV"

for vcf in "$VCF_DIR"/*.vcf; do
    sample=$(basename "$vcf" .vcf)
    out_prefix="$OUT_DIR/${sample}"
    log="$LOG_DIR/${sample}.log"

    perl "$ANNOVAR_DIR/table_annovar.pl" "$vcf" "$HUMANDB" \
        -buildver hg19 \
        -out "$out_prefix" \
        -protocol refGene \
        -operation g \
        -remove -polish -vcfinput -nastring . \
        > "$log" 2>&1
    ec=$?

    multianno="${out_prefix}.hg19_multianno.txt"
    if [ $ec -eq 0 ] && [ -s "$multianno" ]; then
        nvar=$(($(wc -l < "$multianno") - 1))
        printf "%s\t%s\tSUCCESS\t%s\t%s\t%s\t%s\n" "$sample" "$vcf" "$multianno" "$nvar" "$ec" "$log" >> "$SUMMARY_TSV"
        echo "OK  $sample  variants=$nvar"
    else
        printf "%s\t%s\tFAIL\t%s\t0\t%s\t%s\n" "$sample" "$vcf" "$multianno" "$ec" "$log" >> "$SUMMARY_TSV"
        echo "FAIL $sample  ec=$ec"
    fi
done

echo "---DONE---"
echo "Success: $(grep -c SUCCESS "$SUMMARY_TSV")"
echo "Fail:    $(grep -c FAIL "$SUMMARY_TSV")"
