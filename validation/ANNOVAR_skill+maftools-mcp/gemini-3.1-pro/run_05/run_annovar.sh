#!/bin/bash
VCF_DIR="/Users/linqingxuan/maftools-mcp/ANNOVAR_test/VCFs"
ANNOVAR_PL="/Users/linqingxuan/annovar/annovar/table_annovar.pl"
HUMANDB="/Users/linqingxuan/annovar/annovar/humandb"
OUT_DIR="annovar_outputs"
LOG_DIR="logs"

count=0
for vcf in "$VCF_DIR"/*.vcf; do
    base=$(basename "$vcf" .vcf)
    if [ ! -f "$OUT_DIR/$base.hg19_multianno.txt" ]; then
        echo "Processing $base..."
        perl "$ANNOVAR_PL" "$vcf" "$HUMANDB" \
            -buildver hg19 \
            -out "$OUT_DIR/$base" \
            -protocol refGene \
            -operation g \
            -remove -vcfinput -nastring . > "$LOG_DIR/annovar_${base}.log" 2>&1
        if [ $? -eq 0 ]; then
            count=$((count+1))
        else
            echo "Error processing $base. Check log for details."
        fi
    fi
done
echo "Finished processing remaining files."
