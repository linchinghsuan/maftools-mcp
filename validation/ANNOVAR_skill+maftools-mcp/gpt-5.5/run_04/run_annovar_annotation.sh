#!/usr/bin/env bash
set -u

RUN_DIR="/Users/linqingxuan/maftools-mcp/ANNOVAR_test/gpt-5.5/run_04"
VCF_DIR="/Users/linqingxuan/maftools-mcp/ANNOVAR_test/VCFs"
ANNOVAR_DIR="/Users/linqingxuan/annovar/annovar"
HUMANDB="${ANNOVAR_DIR}/humandb"
BUILDVER="hg19"
PROTOCOL="refGene"
OPERATION="g"
THREADS="4"

ANNOTATION_DIR="${RUN_DIR}/annotation"
LOG_DIR="${RUN_DIR}/logs"
RECORD_DIR="${RUN_DIR}/records"
COUNTS_DIR="${RUN_DIR}/counts"

mkdir -p "${ANNOTATION_DIR}" "${LOG_DIR}" "${RECORD_DIR}" "${COUNTS_DIR}"

STATUS_TSV="${RECORD_DIR}/annovar_annotation_status.tsv"
COUNTS_TSV="${COUNTS_DIR}/annovar_annotation_counts.tsv"
PARAMS_TSV="${RECORD_DIR}/annovar_parameters.tsv"
WORKFLOW_TSV="${RECORD_DIR}/workflow_sequence.tsv"

printf 'parameter\tvalue\n' > "${PARAMS_TSV}"
printf 'annovar_dir\t%s\n' "${ANNOVAR_DIR}" >> "${PARAMS_TSV}"
printf 'table_annovar\t%s\n' "${ANNOVAR_DIR}/table_annovar.pl" >> "${PARAMS_TSV}"
printf 'humandb\t%s\n' "${HUMANDB}" >> "${PARAMS_TSV}"
printf 'buildver\t%s\n' "${BUILDVER}" >> "${PARAMS_TSV}"
printf 'genome_build_evidence\tVCF contig assembly=hg19; reference=ucsc.hg19.chrOnly.fasta\n' >> "${PARAMS_TSV}"
printf 'protocol\t%s\n' "${PROTOCOL}" >> "${PARAMS_TSV}"
printf 'operation\t%s\n' "${OPERATION}" >> "${PARAMS_TSV}"
printf 'other_parameters\t-remove -polish -vcfinput -nastring . -thread %s\n' "${THREADS}" >> "${PARAMS_TSV}"
printf 'database_policy\tUsed existing local humandb only; no database download or modification\n' >> "${PARAMS_TSV}"

printf 'step\ttype\tdescription\tcommand_or_tool\toutput\n' > "${WORKFLOW_TSV}"
printf '1\tANNOVAR\tAnnotate all VCF inputs with local hg19 refGene\trun_annovar_annotation.sh\t%s\n' "${STATUS_TSV}" >> "${WORKFLOW_TSV}"

printf 'sample\tvcf_path\tinput_variant_count\tmultianno_path\tmultianno_row_count\tlog_path\texit_code\tstatus\tcommand\n' > "${STATUS_TSV}"
printf 'sample\tinput_variant_count\tmultianno_row_count\n' > "${COUNTS_TSV}"

find "${VCF_DIR}" -maxdepth 1 -type f -name '*.vcf' | sort | while IFS= read -r vcf; do
  sample="$(basename "${vcf}" .vcf)"
  out_prefix="${ANNOTATION_DIR}/${sample}"
  multianno="${out_prefix}.${BUILDVER}_multianno.txt"
  sample_log="${LOG_DIR}/${sample}.annovar.log"
  input_count="$(perl -ne 'next if /^#/; $n++; END { print $n + 0 }' "${vcf}")"
  command="perl ${ANNOVAR_DIR}/table_annovar.pl ${vcf} ${HUMANDB} -buildver ${BUILDVER} -out ${out_prefix} -protocol ${PROTOCOL} -operation ${OPERATION} -remove -polish -vcfinput -nastring . -thread ${THREADS}"

  /usr/bin/time -l perl "${ANNOVAR_DIR}/table_annovar.pl" "${vcf}" "${HUMANDB}" \
    -buildver "${BUILDVER}" \
    -out "${out_prefix}" \
    -protocol "${PROTOCOL}" \
    -operation "${OPERATION}" \
    -remove -polish -vcfinput -nastring . -thread "${THREADS}" \
    > "${sample_log}" 2>&1
  exit_code="$?"

  if [[ -f "${multianno}" ]]; then
    row_count="$(perl -ne 'next if $. == 1; $n++; END { print $n + 0 }' "${multianno}")"
  else
    row_count="0"
  fi

  if [[ "${exit_code}" == "0" && -f "${multianno}" ]]; then
    status="success"
  else
    status="error"
  fi

  printf '%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n' \
    "${sample}" "${vcf}" "${input_count}" "${multianno}" "${row_count}" "${sample_log}" "${exit_code}" "${status}" "${command}" >> "${STATUS_TSV}"
  printf '%s\t%s\t%s\n' "${sample}" "${input_count}" "${row_count}" >> "${COUNTS_TSV}"
done

perl -F'\t' -lane '
  next if $. == 1;
  $total++;
  $success++ if $F[7] eq "success";
  $errors++ if $F[7] ne "success";
  $in += $F[2];
  $out += $F[4];
  END {
    print "metric\tvalue";
    print "total_samples\t" . ($total + 0);
    print "successful_samples\t" . ($success + 0);
    print "error_samples\t" . ($errors + 0);
    print "input_variants_total\t" . ($in + 0);
    print "multianno_rows_total\t" . ($out + 0);
  }
' "${STATUS_TSV}" > "${COUNTS_DIR}/annovar_success_error_summary.tsv"
