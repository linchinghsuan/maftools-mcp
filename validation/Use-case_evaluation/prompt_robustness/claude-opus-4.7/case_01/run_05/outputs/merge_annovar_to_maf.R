# Auto-exported by Maftools-MCP export_r_script for validation.
# This script was captured from the existing MCP tool implementation.
# MCP tool: merge_annovar_to_maf
# Underlying R/Maftools function: maftools::annovarToMaf
# Effective MCP parameters:
#   annovar_files = ["/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/OSCC/*.hg19_multianno.txt"]
#   output_dir = "/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/prompt_robustness/claude-opus-4.7/case_01/run_05/outputs"
#   refBuild = "hg19"
#   table = "refGene"
#   ens2hugo = true
#   sep = "\t"
#   sampleAnno = null
#   basename = "OSCC_merged"

suppressPackageStartupMessages(library(maftools))

files <- c("/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/OSCC/Sample_01.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/OSCC/Sample_04.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/OSCC/Sample_06.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/OSCC/Sample_09.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/OSCC/Sample_10.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/OSCC/Sample_11.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/OSCC/Sample_13.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/OSCC/Sample_14.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/OSCC/Sample_15.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/OSCC/Sample_16.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/OSCC/Sample_18.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/OSCC/Sample_19.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/OSCC/Sample_21.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/OSCC/Sample_22.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/OSCC/Sample_23.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/OSCC/Sample_25.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/OSCC/Sample_26.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/OSCC/Sample_28.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/OSCC/Sample_29.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/OSCC/Sample_30.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/OSCC/Sample_31.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/OSCC/Sample_32.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/OSCC/Sample_35.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/OSCC/Sample_36.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/OSCC/Sample_37.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/OSCC/Sample_38.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/OSCC/Sample_39.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/OSCC/Sample_40.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/OSCC/Sample_41.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/OSCC/Sample_42.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/OSCC/Sample_43.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/OSCC/Sample_44.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/OSCC/Sample_45.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/OSCC/Sample_46.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/OSCC/Sample_47.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/OSCC/Sample_48.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/OSCC/Sample_49.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/OSCC/Sample_50.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/OSCC/Sample_51.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/OSCC/Sample_52.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/OSCC/Sample_54.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/OSCC/Sample_55.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/OSCC/Sample_56.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/OSCC/Sample_57.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/OSCC/Sample_58.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/OSCC/Sample_59.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/OSCC/Sample_61.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/OSCC/Sample_62.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/OSCC/Sample_63.hg19_multianno.txt","/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/OSCC/Sample_64.hg19_multianno.txt")

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
    file = "/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/prompt_robustness/claude-opus-4.7/case_01/run_05/outputs/OSCC_merged.maf",
    sep = "\t",
    quote = FALSE,
    row.names = FALSE
)
