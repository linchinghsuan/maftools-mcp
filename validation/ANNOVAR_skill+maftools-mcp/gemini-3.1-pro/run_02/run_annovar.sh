#!/bin/bash
IN_DIR="/Users/linqingxuan/maftools-mcp/ANNOVAR_test/VCFs"
OUT_DIR="/Users/linqingxuan/maftools-mcp/ANNOVAR_test/gemini-3.1-pro/run_02/annovar_out"
HUMANDB="/Users/linqingxuan/annovar/annovar/humandb"
ANNOVAR="/Users/linqingxuan/annovar/annovar/table_annovar.pl"

mkdir -p "$OUT_DIR"

for vcf in "$IN_DIR"/*.vcf; do
    base=$(basename "$vcf" .vcf)
    echo "Processing $base"
    perl "$ANNOVAR" "$vcf" "$HUMANDB" \
        -buildver hg19 \
        -out "$OUT_DIR/$base" \
        -protocol refGene \
        -operation g \
        -remove -vcfinput -nastring .
done
