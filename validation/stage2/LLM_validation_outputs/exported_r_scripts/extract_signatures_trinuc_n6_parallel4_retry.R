library(maftools)
library(NMF)

input_rds <- "LLM_validation_outputs/trinuc_matrix.rds"
output_dir <- "LLM_validation_outputs"
output_rds <- file.path(output_dir, "extractSignatures.direct_r.rds")
summary_txt <- file.path(output_dir, "extractSignatures.direct_r.summary.txt")

mat <- readRDS(input_rds)

sig <- maftools::extractSignatures(
  mat = mat,
  n = 6,
  plotBestFitRes = FALSE,
  parallel = 4,
  pConstant = NULL
)

saveRDS(sig, file = output_rds)

sink(summary_txt)
cat("input_rds:", input_rds, "\n")
cat("output_rds:", output_rds, "\n")
cat("class:", paste(class(sig), collapse = ","), "\n")
cat("names:", paste(names(sig), collapse = ","), "\n")
print(str(sig, max.level = 2))
sink()
