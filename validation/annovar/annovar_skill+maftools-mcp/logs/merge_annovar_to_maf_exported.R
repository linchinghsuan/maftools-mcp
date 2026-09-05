# Auto-exported by Maftools-MCP export_r_script for validation.
# This script was captured from the existing MCP tool implementation.
# MCP tool: merge_annovar_to_maf
# Underlying R/Maftools function: maftools::annovarToMaf
# Effective MCP parameters:
#   annovar_files = ["ANNOVAR_test/annovar_skill+maftools-mcp/*.hg19_multianno.txt"]
#   output_dir = "ANNOVAR_test/outputs"
#   refBuild = "hg19"
#   table = "refGene"
#   ens2hugo = true
#   sep = "\t"
#   sampleAnno = null
#   basename = "merged"

suppressPackageStartupMessages(library(maftools))

files <- c("ANNOVAR_test/annovar_skill+maftools-mcp/Sample_01.hg19_multianno.txt","ANNOVAR_test/annovar_skill+maftools-mcp/Sample_04.hg19_multianno.txt","ANNOVAR_test/annovar_skill+maftools-mcp/Sample_06.hg19_multianno.txt","ANNOVAR_test/annovar_skill+maftools-mcp/Sample_09.hg19_multianno.txt","ANNOVAR_test/annovar_skill+maftools-mcp/Sample_10.hg19_multianno.txt","ANNOVAR_test/annovar_skill+maftools-mcp/Sample_11.hg19_multianno.txt","ANNOVAR_test/annovar_skill+maftools-mcp/Sample_13.hg19_multianno.txt","ANNOVAR_test/annovar_skill+maftools-mcp/Sample_14.hg19_multianno.txt","ANNOVAR_test/annovar_skill+maftools-mcp/Sample_15.hg19_multianno.txt","ANNOVAR_test/annovar_skill+maftools-mcp/Sample_16.hg19_multianno.txt","ANNOVAR_test/annovar_skill+maftools-mcp/Sample_18.hg19_multianno.txt","ANNOVAR_test/annovar_skill+maftools-mcp/Sample_19.hg19_multianno.txt","ANNOVAR_test/annovar_skill+maftools-mcp/Sample_21.hg19_multianno.txt","ANNOVAR_test/annovar_skill+maftools-mcp/Sample_22.hg19_multianno.txt","ANNOVAR_test/annovar_skill+maftools-mcp/Sample_23.hg19_multianno.txt","ANNOVAR_test/annovar_skill+maftools-mcp/Sample_25.hg19_multianno.txt","ANNOVAR_test/annovar_skill+maftools-mcp/Sample_26.hg19_multianno.txt","ANNOVAR_test/annovar_skill+maftools-mcp/Sample_28.hg19_multianno.txt","ANNOVAR_test/annovar_skill+maftools-mcp/Sample_29.hg19_multianno.txt","ANNOVAR_test/annovar_skill+maftools-mcp/Sample_30.hg19_multianno.txt","ANNOVAR_test/annovar_skill+maftools-mcp/Sample_31.hg19_multianno.txt","ANNOVAR_test/annovar_skill+maftools-mcp/Sample_32.hg19_multianno.txt","ANNOVAR_test/annovar_skill+maftools-mcp/Sample_35.hg19_multianno.txt","ANNOVAR_test/annovar_skill+maftools-mcp/Sample_36.hg19_multianno.txt","ANNOVAR_test/annovar_skill+maftools-mcp/Sample_37.hg19_multianno.txt","ANNOVAR_test/annovar_skill+maftools-mcp/Sample_38.hg19_multianno.txt","ANNOVAR_test/annovar_skill+maftools-mcp/Sample_39.hg19_multianno.txt")

maf_list <- list()
idx <- 1

for (f in files) {
    maf_obj <- tryCatch({
        annovarToMaf(
            annovar = f,
            Center = NULL,
            refBuild = "hg19",
            tsbCol = NULL,
            table = "refGene",
            ens2hugo = TRUE,
            basename = NULL,
            sep = "	",
            MAFobj = TRUE,
            sampleAnno = NULL
        )
    }, error = function(e) {
        stop(paste0("annovarToMaf failed for file: ", f, "\n", conditionMessage(e)))
    })

    maf_list[[idx]] <- maf_obj
    idx <- idx + 1
}

merged_maf <- tryCatch({
    merge_mafs(maf_list)
}, error = function(e) {
    stop(paste0("merge_mafs failed.\n", conditionMessage(e)))
})

maf_df <- merged_maf@data

write.table(
    maf_df,
    file = "ANNOVAR_test/annovar_skill+maftools-mcp/merged.maf",
    sep = "\t",
    quote = FALSE,
    row.names = FALSE
)
