#!/bin/bash
set -e

VCF_DIR="/Users/linqingxuan/maftools-mcp/ANNOVAR_test/VCFs"
OUT_DIR="/Users/linqingxuan/maftools-mcp/ANNOVAR_test/gemini-3.1-pro/run_04/annovar_outputs"
ANNOVAR_PL="/Users/linqingxuan/annovar/annovar/table_annovar.pl"
HUMANDB="/Users/linqingxuan/annovar/annovar/humandb"

for vcf in "$VCF_DIR"/*.vcf; do
    filename=$(basename "$vcf" .vcf)
    if [ ! -f "$OUT_DIR/$filename.hg19_multianno.txt" ]; then
        echo "Processing $filename..."
        perl "$ANNOVAR_PL" "$vcf" "$HUMANDB" \
            -buildver hg19 \
            -out "$OUT_DIR/$filename" \
            -protocol refGene \
            -operation g \
            -remove -vcfinput -nastring .
    fi
done
echo "All VCFs processed."
