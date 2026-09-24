#!/bin/bash
# ANNOVAR annotation for 50 VCFs (hg19, refGene)
set -u

ANNOVAR_DIR="/Users/linqingxuan/annovar/annovar"
HUMANDB="${ANNOVAR_DIR}/humandb"
VCF_DIR="/Users/linqingxuan/maftools-mcp/ANNOVAR_test/VCFs"
RUN_DIR="/Users/linqingxuan/maftools-mcp/ANNOVAR_test/claude-opus-4.7/run_05"
OUT_DIR="${RUN_DIR}/annovar_out"
LOG_DIR="${RUN_DIR}/logs"

SUCCESS_LOG="${LOG_DIR}/success.txt"
ERROR_LOG="${LOG_DIR}/error.txt"
: > "$SUCCESS_LOG"
: > "$ERROR_LOG"

BUILDVER=hg19
PROTOCOL=refGene
OPERATION=g

N_TOTAL=0
N_OK=0
N_FAIL=0

for vcf in "${VCF_DIR}"/Sample_*.vcf; do
    N_TOTAL=$((N_TOTAL+1))
    sample=$(basename "$vcf" .vcf)
    out_prefix="${OUT_DIR}/${sample}"
    log_file="${LOG_DIR}/${sample}.log"

    perl "${ANNOVAR_DIR}/table_annovar.pl" \
        "$vcf" "$HUMANDB" \
        -buildver "$BUILDVER" \
        -out "$out_prefix" \
        -protocol "$PROTOCOL" \
        -operation "$OPERATION" \
        -remove -polish -vcfinput -nastring . \
        > "$log_file" 2>&1

    rc=$?
    if [ $rc -eq 0 ] && [ -s "${out_prefix}.${BUILDVER}_multianno.txt" ]; then
        N_OK=$((N_OK+1))
        n_lines=$(($(wc -l < "${out_prefix}.${BUILDVER}_multianno.txt") - 1))
        echo -e "${sample}\tOK\t${n_lines}" >> "$SUCCESS_LOG"
    else
        N_FAIL=$((N_FAIL+1))
        echo -e "${sample}\tFAIL\trc=${rc}" >> "$ERROR_LOG"
    fi
done

echo "TOTAL=${N_TOTAL} OK=${N_OK} FAIL=${N_FAIL}"
