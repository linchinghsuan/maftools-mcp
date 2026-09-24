#!/usr/bin/env bash
set -u -o pipefail

RUN_DIR="/Users/linqingxuan/maftools-mcp/ANNOVAR_test/gpt-5.5/run_01"
VCF_DIR="/Users/linqingxuan/maftools-mcp/ANNOVAR_test/VCFs"
ANNOVAR_DIR="/Users/linqingxuan/annovar/annovar"
TABLE_ANNOVAR="${ANNOVAR_DIR}/table_annovar.pl"
HUMANDB="${ANNOVAR_DIR}/humandb"
BUILDVER="hg19"
PROTOCOL="refGene"
OPERATION="g"
THREADS="4"

SUMMARY="${RUN_DIR}/records/annovar_annotation_summary.tsv"
COMMANDS="${RUN_DIR}/records/annovar_commands.tsv"

mkdir -p "${RUN_DIR}/annotation" "${RUN_DIR}/logs" "${RUN_DIR}/records"
printf "sample\tvcf_path\toutput_prefix\tmultianno_txt\tmultianno_vcf\texit_code\tinput_variants\tannotated_rows\tstatus\n" > "${SUMMARY}"
printf "sample\tcommand\n" > "${COMMANDS}"

for vcf in "${VCF_DIR}"/*.vcf; do
  sample="$(basename "${vcf}" .vcf)"
  sample_dir="${RUN_DIR}/annotation/${sample}"
  out_prefix="${sample_dir}/${sample}"
  stdout_log="${RUN_DIR}/logs/${sample}.annovar.stdout.log"
  stderr_log="${RUN_DIR}/logs/${sample}.annovar.stderr.log"
  multianno_txt="${out_prefix}.${BUILDVER}_multianno.txt"
  multianno_vcf="${out_prefix}.${BUILDVER}_multianno.vcf"
  mkdir -p "${sample_dir}"

  command="perl '${TABLE_ANNOVAR}' '${vcf}' '${HUMANDB}' -buildver ${BUILDVER} -out '${out_prefix}' -protocol ${PROTOCOL} -operation ${OPERATION} -remove -polish -vcfinput -nastring . -thread ${THREADS}"
  printf "%s\t%s\n" "${sample}" "${command}" >> "${COMMANDS}"

  perl "${TABLE_ANNOVAR}" "${vcf}" "${HUMANDB}" \
    -buildver "${BUILDVER}" \
    -out "${out_prefix}" \
    -protocol "${PROTOCOL}" \
    -operation "${OPERATION}" \
    -remove -polish -vcfinput -nastring . -thread "${THREADS}" \
    > "${stdout_log}" 2> "${stderr_log}"
  exit_code=$?

  input_variants="$(perl -ne 'next if /^#/; $n++; END { print $n // 0 }' "${vcf}")"
  if [[ -f "${multianno_txt}" ]]; then
    annotated_rows="$(perl -ne 'next if $. == 1; $n++; END { print $n // 0 }' "${multianno_txt}")"
  else
    annotated_rows="0"
  fi

  if [[ "${exit_code}" -eq 0 && -s "${multianno_txt}" ]]; then
    status="success"
  else
    status="error"
  fi

  printf "%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n" \
    "${sample}" "${vcf}" "${out_prefix}" "${multianno_txt}" "${multianno_vcf}" \
    "${exit_code}" "${input_variants}" "${annotated_rows}" "${status}" >> "${SUMMARY}"
done
