#!/usr/bin/env bash
# ANNOVAR batch annotation script for 50 VCFs
# Genome build: hg19 (confirmed via VCF ##contig assembly=hg19)
# Available hg19 DB in humandb/: refGene (only)
# Protocol: refGene
# Operation: g (gene-based)
# Flags: -remove -polish -vcfinput -nastring .

set -u
ANNOVAR_DIR="/Users/linqingxuan/annovar/annovar"
VCF_DIR="/Users/linqingxuan/maftools-mcp/ANNOVAR_test/VCFs"
OUT_DIR="/Users/linqingxuan/maftools-mcp/ANNOVAR_test/claude-opus-4.7/run_02/annovar_outputs"
LOG_DIR="/Users/linqingxuan/maftools-mcp/ANNOVAR_test/claude-opus-4.7/run_02/logs"
SUMMARY="$LOG_DIR/annovar_summary.tsv"

mkdir -p "$OUT_DIR" "$LOG_DIR"
echo -e "sample\tstatus\tvariants_input\tvariants_annotated\tlog_file" > "$SUMMARY"

annotate_one() {
    local vcf="$1"
    local base
    base="$(basename "$vcf" .vcf)"
    local log="$LOG_DIR/${base}.log"
    (
        cd "$ANNOVAR_DIR" || exit 1
        perl table_annovar.pl "$vcf" humandb/ \
            -buildver hg19 \
            -out "$OUT_DIR/${base}" \
            -protocol refGene \
            -operation g \
            -remove -polish -vcfinput -nastring .
    ) >"$log" 2>&1
    local rc=$?
    local ma="$OUT_DIR/${base}.hg19_multianno.txt"
    local vin=$(grep -v "^#" "$vcf" | wc -l | tr -d ' ')
    local vout="NA"
    if [[ -f "$ma" ]]; then
        vout=$(($(wc -l <"$ma") - 1))
    fi
    if [[ $rc -eq 0 && -f "$ma" ]]; then
        echo -e "${base}\tSUCCESS\t${vin}\t${vout}\t${log}"
    else
        echo -e "${base}\tFAIL\t${vin}\t${vout}\t${log}"
    fi
}
export -f annotate_one
export ANNOVAR_DIR OUT_DIR LOG_DIR

# Run in parallel, cap at 6
i=0
pids=()
for vcf in "$VCF_DIR"/*.vcf; do
    annotate_one "$vcf" >>"$SUMMARY" &
    pids+=($!)
    i=$((i+1))
    if (( i % 6 == 0 )); then
        for p in "${pids[@]}"; do wait "$p"; done
        pids=()
    fi
done
for p in "${pids[@]}"; do wait "$p"; done

echo "Done. Summary at $SUMMARY"
