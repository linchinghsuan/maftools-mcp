#!/bin/bash
VCF_DIR="/Users/linqingxuan/maftools-mcp/ANNOVAR_test/VCFs"
OUTPUT_DIR="/Users/linqingxuan/maftools-mcp/ANNOVAR_test/gemini-3.1-flash/run_02"
ANNOVAR_PATH="/Users/linqingxuan/annovar/annovar"
DB_PATH="/Users/linqingxuan/annovar/annovar/humandb"

cd $VCF_DIR
for vcf in *.vcf; do
    echo "Annotating $vcf..."
    perl $ANNOVAR_PATH/table_annovar.pl $vcf $DB_PATH \
        -buildver hg19 \
        -out $OUTPUT_DIR/${vcf%.vcf} \
        -protocol refGene \
        -operation g \
        -remove -polish -vcfinput -nastring .
done
