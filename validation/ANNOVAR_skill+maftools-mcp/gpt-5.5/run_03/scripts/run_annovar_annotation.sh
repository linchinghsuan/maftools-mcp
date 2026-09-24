#!/usr/bin/env bash
set -u

RUN_DIR="/Users/linqingxuan/maftools-mcp/ANNOVAR_test/gpt-5.5/run_03"
VCF_DIR="/Users/linqingxuan/maftools-mcp/ANNOVAR_test/VCFs"
ANNOVAR_DIR="/Users/linqingxuan/annovar/annovar"
HUMANDB="$ANNOVAR_DIR/humandb"
TABLE_ANNOVAR="$ANNOVAR_DIR/table_annovar.pl"
OUT_DIR="$RUN_DIR/annotation"
LOG_DIR="$RUN_DIR/logs"
RECORD_DIR="$RUN_DIR/records"

BUILDVER="hg19"
PROTOCOL="refGene"
OPERATION="g"
COMMON_ARGS=(-buildver "$BUILDVER" -protocol "$PROTOCOL" -operation "$OPERATION" -remove -polish -vcfinput -nastring . -thread 1)

mkdir -p "$OUT_DIR" "$LOG_DIR" "$RECORD_DIR"

PARAMS_JSON="$RECORD_DIR/annovar_parameters.json"
STATUS_TSV="$RECORD_DIR/annovar_sample_status.tsv"

cat > "$PARAMS_JSON" <<JSON
{
  "run_id": "gpt-5.5_run_03",
  "vcf_dir": "$VCF_DIR",
  "annovar_dir": "$ANNOVAR_DIR",
  "table_annovar": "$TABLE_ANNOVAR",
  "humandb": "$HUMANDB",
  "genome_build": "$BUILDVER",
  "build_evidence": "VCF headers contain assembly=hg19 and MuTect reference_sequence=ucsc.hg19.chrOnly.fasta",
  "protocol": "$PROTOCOL",
  "operation": "$OPERATION",
  "options": ["-remove", "-polish", "-vcfinput", "-nastring", ".", "-thread", "1"],
  "database_policy": "Used existing local ANNOVAR and humandb only; no database download or modification requested."
}
JSON

printf "sample\tvcf_path\toutput_prefix\tmultianno_path\tlog_path\texit_code\tvcf_variant_count\tannotated_variant_count\tstatus\n" > "$STATUS_TSV"

shopt -s nullglob
vcfs=("$VCF_DIR"/*.vcf)
IFS=$'\n' vcfs=($(printf '%s\n' "${vcfs[@]}" | sort))
unset IFS

if [[ ${#vcfs[@]} -ne 50 ]]; then
  printf "Expected 50 VCF files, found %s\n" "${#vcfs[@]}" >&2
fi

for vcf in "${vcfs[@]}"; do
  sample=$(basename "$vcf" .vcf)
  prefix="$OUT_DIR/$sample"
  multianno="$prefix.${BUILDVER}_multianno.txt"
  log="$LOG_DIR/${sample}.annovar.log"
  vcf_count=$(perl -ne 'next if /^#/; $n++; END { print $n + 0 }' "$vcf")

  perl "$TABLE_ANNOVAR" "$vcf" "$HUMANDB" -out "$prefix" "${COMMON_ARGS[@]}" > "$log" 2>&1
  exit_code=$?

  if [[ -s "$multianno" ]]; then
    anno_count=$(perl -ne 'next if $. == 1; $n++; END { print $n + 0 }' "$multianno")
  else
    anno_count=0
  fi

  if [[ $exit_code -eq 0 && -s "$multianno" ]]; then
    status="success"
  else
    status="error"
  fi

  printf "%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n" "$sample" "$vcf" "$prefix" "$multianno" "$log" "$exit_code" "$vcf_count" "$anno_count" "$status" >> "$STATUS_TSV"
done

perl -F'\t' -ane '
  next if $. == 1;
  $total++;
  $success++ if $F[8] =~ /^success$/;
  $errors++ if $F[8] !~ /^success$/;
  $vcf += $F[6];
  $anno += $F[7];
  END {
    print "metric\tvalue\n";
    print "samples_total\t", ($total + 0), "\n";
    print "samples_success\t", ($success + 0), "\n";
    print "samples_error\t", ($errors + 0), "\n";
    print "vcf_variants_total\t", ($vcf + 0), "\n";
    print "annotated_variants_total\t", ($anno + 0), "\n";
  }
' "$STATUS_TSV" > "$RECORD_DIR/annovar_summary_counts.tsv"
