# Auto-exported by Maftools-MCP export_r_script for validation.
# This script was captured from the existing MCP tool implementation.
# MCP tool: merge_annovar_to_maf
# Underlying R/Maftools function: maftools::annovarToMaf
# Effective MCP parameters:
#   annovar_files = ["maftools_validation_data/LLM_Stage2_validation/LLM_validation_input_file/annovar_to_maf/test1.multianno.txt", "maftools_validation_data/LLM_Stage2_validation/LLM_validation_input_file/annovar_to_maf/test2.multianno.txt", "maftools_validation_data/LLM_Stage2_validation/LLM_validation_input_file/annovar_to_maf/test3.multianno.txt", "maftools_validation_data/LLM_Stage2_validation/LLM_validation_input_file/annovar_to_maf/test4.multianno.txt", "maftools_validation_data/LLM_Stage2_validation/LLM_validation_input_file/annovar_to_maf/test5.multianno.txt"]
#   output_dir = "maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs"
#   refBuild = "hg19"
#   table = "refGene"
#   ens2hugo = true
#   sep = "\t"
#   sampleAnno = null
#   basename = "merged"

suppressPackageStartupMessages(library(maftools))

files <- c("maftools_validation_data/LLM_Stage2_validation/LLM_validation_input_file/annovar_to_maf/test1.multianno.txt","maftools_validation_data/LLM_Stage2_validation/LLM_validation_input_file/annovar_to_maf/test2.multianno.txt","maftools_validation_data/LLM_Stage2_validation/LLM_validation_input_file/annovar_to_maf/test3.multianno.txt","maftools_validation_data/LLM_Stage2_validation/LLM_validation_input_file/annovar_to_maf/test4.multianno.txt","maftools_validation_data/LLM_Stage2_validation/LLM_validation_input_file/annovar_to_maf/test5.multianno.txt")

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
    file = "maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/merged.maf",
    sep = "\t",
    quote = FALSE,
    row.names = FALSE
)
