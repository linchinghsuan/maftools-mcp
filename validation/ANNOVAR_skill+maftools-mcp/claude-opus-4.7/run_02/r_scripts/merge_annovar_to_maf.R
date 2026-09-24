# Auto-exported by Maftools-MCP export_r_script for validation.
# This script was captured from the existing MCP tool implementation.
# MCP tool: merge_annovar_to_maf
# Underlying R/Maftools function: maftools::annovarToMaf
# Effective MCP parameters:
#   annovar_files = ["/Users/linqingxuan/maftools-mcp/ANNOVAR_test/claude-opus-4.7/run_02/annovar_outputs/*.hg19_multianno.txt"]
#   refBuild = "hg19"
#   table = "refGene"
#   ens2hugo = true
#   sep = "\t"
#   sampleAnno = null
#   basename = "cohort50"

suppressPackageStartupMessages(library(maftools))

files <- c("/Users/linqingxuan/maftools-mcp/ANNOVAR_test/claude-opus-4.7/run_02/annovar_outputs/Sample_01.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/ANNOVAR_test/claude-opus-4.7/run_02/annovar_outputs/Sample_04.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/ANNOVAR_test/claude-opus-4.7/run_02/annovar_outputs/Sample_06.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/ANNOVAR_test/claude-opus-4.7/run_02/annovar_outputs/Sample_09.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/ANNOVAR_test/claude-opus-4.7/run_02/annovar_outputs/Sample_10.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/ANNOVAR_test/claude-opus-4.7/run_02/annovar_outputs/Sample_11.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/ANNOVAR_test/claude-opus-4.7/run_02/annovar_outputs/Sample_13.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/ANNOVAR_test/claude-opus-4.7/run_02/annovar_outputs/Sample_14.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/ANNOVAR_test/claude-opus-4.7/run_02/annovar_outputs/Sample_15.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/ANNOVAR_test/claude-opus-4.7/run_02/annovar_outputs/Sample_16.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/ANNOVAR_test/claude-opus-4.7/run_02/annovar_outputs/Sample_18.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/ANNOVAR_test/claude-opus-4.7/run_02/annovar_outputs/Sample_19.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/ANNOVAR_test/claude-opus-4.7/run_02/annovar_outputs/Sample_21.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/ANNOVAR_test/claude-opus-4.7/run_02/annovar_outputs/Sample_22.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/ANNOVAR_test/claude-opus-4.7/run_02/annovar_outputs/Sample_23.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/ANNOVAR_test/claude-opus-4.7/run_02/annovar_outputs/Sample_25.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/ANNOVAR_test/claude-opus-4.7/run_02/annovar_outputs/Sample_26.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/ANNOVAR_test/claude-opus-4.7/run_02/annovar_outputs/Sample_28.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/ANNOVAR_test/claude-opus-4.7/run_02/annovar_outputs/Sample_29.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/ANNOVAR_test/claude-opus-4.7/run_02/annovar_outputs/Sample_30.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/ANNOVAR_test/claude-opus-4.7/run_02/annovar_outputs/Sample_31.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/ANNOVAR_test/claude-opus-4.7/run_02/annovar_outputs/Sample_32.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/ANNOVAR_test/claude-opus-4.7/run_02/annovar_outputs/Sample_35.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/ANNOVAR_test/claude-opus-4.7/run_02/annovar_outputs/Sample_36.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/ANNOVAR_test/claude-opus-4.7/run_02/annovar_outputs/Sample_37.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/ANNOVAR_test/claude-opus-4.7/run_02/annovar_outputs/Sample_38.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/ANNOVAR_test/claude-opus-4.7/run_02/annovar_outputs/Sample_39.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/ANNOVAR_test/claude-opus-4.7/run_02/annovar_outputs/Sample_40.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/ANNOVAR_test/claude-opus-4.7/run_02/annovar_outputs/Sample_41.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/ANNOVAR_test/claude-opus-4.7/run_02/annovar_outputs/Sample_42.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/ANNOVAR_test/claude-opus-4.7/run_02/annovar_outputs/Sample_43.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/ANNOVAR_test/claude-opus-4.7/run_02/annovar_outputs/Sample_44.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/ANNOVAR_test/claude-opus-4.7/run_02/annovar_outputs/Sample_45.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/ANNOVAR_test/claude-opus-4.7/run_02/annovar_outputs/Sample_46.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/ANNOVAR_test/claude-opus-4.7/run_02/annovar_outputs/Sample_47.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/ANNOVAR_test/claude-opus-4.7/run_02/annovar_outputs/Sample_48.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/ANNOVAR_test/claude-opus-4.7/run_02/annovar_outputs/Sample_49.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/ANNOVAR_test/claude-opus-4.7/run_02/annovar_outputs/Sample_50.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/ANNOVAR_test/claude-opus-4.7/run_02/annovar_outputs/Sample_51.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/ANNOVAR_test/claude-opus-4.7/run_02/annovar_outputs/Sample_52.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/ANNOVAR_test/claude-opus-4.7/run_02/annovar_outputs/Sample_54.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/ANNOVAR_test/claude-opus-4.7/run_02/annovar_outputs/Sample_55.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/ANNOVAR_test/claude-opus-4.7/run_02/annovar_outputs/Sample_56.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/ANNOVAR_test/claude-opus-4.7/run_02/annovar_outputs/Sample_57.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/ANNOVAR_test/claude-opus-4.7/run_02/annovar_outputs/Sample_58.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/ANNOVAR_test/claude-opus-4.7/run_02/annovar_outputs/Sample_59.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/ANNOVAR_test/claude-opus-4.7/run_02/annovar_outputs/Sample_61.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/ANNOVAR_test/claude-opus-4.7/run_02/annovar_outputs/Sample_62.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/ANNOVAR_test/claude-opus-4.7/run_02/annovar_outputs/Sample_63.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/ANNOVAR_test/claude-opus-4.7/run_02/annovar_outputs/Sample_64.hg19_multianno.txt")

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
    file = "/Users/linqingxuan/maftools-mcp/ANNOVAR_test/claude-opus-4.7/run_02/maftools_outputs/cohort50.maf",
    sep = "\t",
    quote = FALSE,
    row.names = FALSE
)
