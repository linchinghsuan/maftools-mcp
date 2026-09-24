#!/usr/bin/env bash
set -uo pipefail

RUN_DIR="/Users/linqingxuan/maftools-mcp/ANNOVAR_test/gpt-5.5/run_02"
VCF_DIR="/Users/linqingxuan/maftools-mcp/ANNOVAR_test/VCFs"
ANNOVAR_DIR="/Users/linqingxuan/annovar/annovar"
TABLE_ANNOVAR="${ANNOVAR_DIR}/table_annovar.pl"
HUMANDB="${ANNOVAR_DIR}/humandb"
BUILDVER="hg19"
PROTOCOL="refGene"
OPERATION="g"
THREADS="1"

ANNOTATION_DIR="${RUN_DIR}/annotations"
LOG_DIR="${RUN_DIR}/logs"
METADATA_DIR="${RUN_DIR}/metadata"
COMMAND_LOG="${LOG_DIR}/annovar_commands.tsv"
STATUS_TSV="${METADATA_DIR}/annovar_annotation_status.tsv"

mkdir -p "${ANNOTATION_DIR}" "${LOG_DIR}" "${METADATA_DIR}"

printf 'sample\tvcf_path\toutput_prefix\tmultianno_path\tlog_path\texit_code\tinput_variant_count\tannotated_variant_count\tstatus\n' > "${STATUS_TSV}"
printf 'sample\tcommand\n' > "${COMMAND_LOG}"

shopt -s nullglob
vcfs=("${VCF_DIR}"/*.vcf)
IFS=$'\n' vcfs=($(printf '%s\n' "${vcfs[@]}" | sort))
unset IFS

if [[ ${#vcfs[@]} -eq 0 ]]; then
  printf 'No VCF files found in %s\n' "${VCF_DIR}" >&2
  exit 2
fi

for vcf in "${vcfs[@]}"; do
  sample=$(basename "${vcf}" .vcf)
  sample_dir="${ANNOTATION_DIR}/${sample}"
  mkdir -p "${sample_dir}"
  out_prefix="${sample_dir}/${sample}"
  log_path="${LOG_DIR}/${sample}.annovar.log"
  multianno_path="${out_prefix}.${BUILDVER}_multianno.txt"

  cmd=(perl "${TABLE_ANNOVAR}" "${vcf}" "${HUMANDB}"
    -buildver "${BUILDVER}"
    -out "${out_prefix}"
    -protocol "${PROTOCOL}"
    -operation "${OPERATION}"
    -remove
    -polish
    -vcfinput
    -nastring "."
    -thread "${THREADS}")

  printf '%s\t' "${sample}" >> "${COMMAND_LOG}"
  printf '%q ' "${cmd[@]}" >> "${COMMAND_LOG}"
  printf '\n' >> "${COMMAND_LOG}"

  "${cmd[@]}" > "${log_path}" 2>&1
  exit_code=$?

  input_count=$(awk 'BEGIN{n=0} $0 !~ /^#/ {n++} END{print n}' "${vcf}")
  if [[ -s "${multianno_path}" ]]; then
    annotated_count=$(awk 'NR > 1 {n++} END{print n+0}' "${multianno_path}")
  else
    annotated_count=0
  fi

  if [[ ${exit_code} -eq 0 && -s "${multianno_path}" ]]; then
    status="success"
  else
    status="error"
  fi

  printf '%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n' \
    "${sample}" "${vcf}" "${out_prefix}" "${multianno_path}" "${log_path}" \
    "${exit_code}" "${input_count}" "${annotated_count}" "${status}" >> "${STATUS_TSV}"
done
