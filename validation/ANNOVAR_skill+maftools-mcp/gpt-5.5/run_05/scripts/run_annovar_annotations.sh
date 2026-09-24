#!/usr/bin/env bash
set -uo pipefail

RUN_DIR="/Users/linqingxuan/maftools-mcp/ANNOVAR_test/gpt-5.5/run_05"
VCF_DIR="/Users/linqingxuan/maftools-mcp/ANNOVAR_test/VCFs"
ANNOVAR_DIR="/Users/linqingxuan/annovar/annovar"
HUMANDB="${ANNOVAR_DIR}/humandb"
OUT_DIR="${RUN_DIR}/annovar_annotations"
LOG_DIR="${RUN_DIR}/logs"
COUNT_DIR="${RUN_DIR}/counts"

BUILDVER="hg19"
PROTOCOL="refGene"
OPERATION="g"
THREADS="4"

mkdir -p "${OUT_DIR}" "${LOG_DIR}" "${COUNT_DIR}"

SUMMARY="${RUN_DIR}/annovar_annotation_summary.tsv"
COUNTS="${COUNT_DIR}/annovar_variant_counts.tsv"
PARAMS="${RUN_DIR}/annovar_parameters.tsv"

printf 'parameter\tvalue\n' > "${PARAMS}"
printf 'annovar_dir\t%s\n' "${ANNOVAR_DIR}" >> "${PARAMS}"
printf 'humandb\t%s\n' "${HUMANDB}" >> "${PARAMS}"
printf 'vcf_dir\t%s\n' "${VCF_DIR}" >> "${PARAMS}"
printf 'output_dir\t%s\n' "${OUT_DIR}" >> "${PARAMS}"
printf 'buildver\t%s\n' "${BUILDVER}" >> "${PARAMS}"
printf 'protocol\t%s\n' "${PROTOCOL}" >> "${PARAMS}"
printf 'operation\t%s\n' "${OPERATION}" >> "${PARAMS}"
printf 'vcfinput\ttrue\n' >> "${PARAMS}"
printf 'remove_intermediates\ttrue\n' >> "${PARAMS}"
printf 'polish\ttrue\n' >> "${PARAMS}"
printf 'nastring\t.\n' >> "${PARAMS}"
printf 'thread\t%s\n' "${THREADS}" >> "${PARAMS}"

printf 'sample\tvcf\tmultianno\tlog\tstatus\texit_code\n' > "${SUMMARY}"
printf 'sample\tvcf_variants\tmultianno_rows\n' > "${COUNTS}"

for vcf in "${VCF_DIR}"/*.vcf; do
  sample="$(basename "${vcf}" .vcf)"
  prefix="${OUT_DIR}/${sample}"
  log="${LOG_DIR}/${sample}.annovar.log"
  multianno="${prefix}.${BUILDVER}_multianno.txt"

  perl "${ANNOVAR_DIR}/table_annovar.pl" "${vcf}" "${HUMANDB}" \
    -buildver "${BUILDVER}" \
    -out "${prefix}" \
    -protocol "${PROTOCOL}" \
    -operation "${OPERATION}" \
    -remove -polish -vcfinput -nastring . -thread "${THREADS}" \
    > "${log}" 2>&1
  exit_code=$?

  if [[ ${exit_code} -eq 0 && -s "${multianno}" ]]; then
    status="success"
  else
    status="error"
  fi

  vcf_variants=$(awk 'BEGIN{n=0} $0 !~ /^#/ {n++} END{print n}' "${vcf}")
  if [[ -s "${multianno}" ]]; then
    multianno_rows=$(awk 'BEGIN{n=0} NR>1 {n++} END{print n}' "${multianno}")
  else
    multianno_rows="0"
  fi

  printf '%s\t%s\t%s\t%s\t%s\t%s\n' "${sample}" "${vcf}" "${multianno}" "${log}" "${status}" "${exit_code}" >> "${SUMMARY}"
  printf '%s\t%s\t%s\n' "${sample}" "${vcf_variants}" "${multianno_rows}" >> "${COUNTS}"
done
