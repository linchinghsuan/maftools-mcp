# Auto-exported by Maftools-MCP export_r_script for validation.
# This script was captured from the existing MCP tool implementation.
# MCP tool: merge_maf_to_mafobj
# Underlying R/Maftools function: maftools::makeCluster
# Effective MCP parameters:
#   maf_files = ["maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_input_file/maf_merge/*.maf"]
#   output_dir = "maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_outputs"
#   output_basename = "final_merged"
#   write_output = true

library(data.table)
library(foreach)
library(doParallel)
library(maftools)

files <- c("maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_input_file/maf_merge/*.maf")

# parallel backend: use 8 cores only if > 1 file
cores <- ifelse(length(files) > 1, 8, 1)
cl <- makeCluster(cores)
registerDoParallel(cl)

merged_df <- foreach(i = 1:length(files), .combine = rbind, .packages = "data.table") %dopar% {
    fread(cmd = paste("grep -v '#' ", files[i]), quote = FALSE)
}

stopCluster(cl)

maf_obj <- read.maf(merged_df)

if (TRUE) {
    write.table(
        merged_df,
        file = "maftools_validation_data/mcp_inspector_validation/direct_r_execution/direct_r_outputs/final_merged.maf",
        sep = "\t",
        quote = FALSE,
        row.names = FALSE
    )
}
