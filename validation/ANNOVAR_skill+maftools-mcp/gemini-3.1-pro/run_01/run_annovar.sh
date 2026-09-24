#!/bin/bash

# ANNOVAR Run Script
# Genome build: hg19
# Protocol: refGene
# Operation: g
# Flags: -remove -polish -vcfinput -nastring .

VCF_DIR="/Users/linqingxuan/maftools-mcp/ANNOVAR_test/VCFs"
DB_DIR="/Users/linqingxuan/annovar/annovar/humandb"
ANNOVAR_BIN="/Users/linqingxuan/annovar/annovar/table_annovar.pl"
OUT_DIR="./annotations"

export ANNOVAR_BIN DB_DIR OUT_DIR

run_annovar() {
    vcf_file=$1
    basename=$(basename "$vcf_file" .vcf)
    echo "Processing $basename..."
    perl "$ANNOVAR_BIN" "$vcf_file" "$DB_DIR" \
        -buildver hg19 \
        -out "$OUT_DIR/$basename" \
        -protocol refGene \
        -operation g \
        -remove -polish -vcfinput -nastring . > "$OUT_DIR/${basename}.log" 2>&1
}

export -f run_annovar

# Run in parallel with 8 jobs
find "$VCF_DIR" -name "*.vcf" | xargs -n 1 -P 8 -I {} bash -c 'run_annovar "$@"' _ {}

echo "Annotation finished."
