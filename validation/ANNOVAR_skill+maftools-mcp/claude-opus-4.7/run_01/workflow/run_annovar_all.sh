#!/usr/bin/env bash
# ANNOVAR batch annotation for 50 VCFs
# Genome build: hg19 (confirmed from VCF ##contig assembly=hg19; source aligner used ucsc.hg19)
# Protocol : refGene       (only hg19 gene DB available locally in humandb/)
# Operation: g             (gene-based)
# Flags    : -remove -polish -vcfinput -nastring .
# No databases were downloaded or modified for this run.

set -u
ANNOVAR_DIR=/Users/linqingxuan/annovar/annovar
HUMANDB="${ANNOVAR_DIR}/humandb"
VCF_DIR=/Users/linqingxuan/maftools-mcp/ANNOVAR_test/VCFs
RUN_DIR=/Users/linqingxuan/maftools-mcp/ANNOVAR_test/claude-opus-4.7/run_01
OUT_DIR="${RUN_DIR}/annovar_out"
LOG_DIR="${RUN_DIR}/logs"
STATUS_TSV="${LOG_DIR}/annovar_status.tsv"
PARALLEL=6

mkdir -p "${OUT_DIR}" "${LOG_DIR}"
printf "sample\tvcf\tstatus\tmultianno_lines\tstart\tend\n" > "${STATUS_TSV}"

annotate_one() {
    local vcf="$1"
    local sample; sample=$(basename "${vcf}" .vcf)
    local log="${LOG_DIR}/${sample}.log"
    local out_prefix="${OUT_DIR}/${sample}"
    local start end status lines rc
    start=$(date -Iseconds)
    ( cd "${ANNOVAR_DIR}" && perl table_annovar.pl "${vcf}" "${HUMANDB}" \
          -buildver hg19 \
          -out "${out_prefix}" \
          -protocol refGene \
          -operation g \
          -remove -polish -vcfinput -nastring . ) >"${log}" 2>&1
    rc=$?
    end=$(date -Iseconds)
    if [[ ${rc} -eq 0 && -s "${out_prefix}.hg19_multianno.txt" ]]; then
        status="SUCCESS"
        lines=$(( $(wc -l <"${out_prefix}.hg19_multianno.txt") - 1 ))
    else
        status="FAIL_rc${rc}"
        lines=0
    fi
    printf "%s\t%s\t%s\t%s\t%s\t%s\n" "${sample}" "${vcf}" "${status}" "${lines}" "${start}" "${end}" >>"${STATUS_TSV}"
}
export -f annotate_one
export ANNOVAR_DIR HUMANDB LOG_DIR OUT_DIR STATUS_TSV

find "${VCF_DIR}" -maxdepth 1 -name '*.vcf' | sort | \
    xargs -n1 -P "${PARALLEL}" -I {} bash -c 'annotate_one "$@"' _ {}
