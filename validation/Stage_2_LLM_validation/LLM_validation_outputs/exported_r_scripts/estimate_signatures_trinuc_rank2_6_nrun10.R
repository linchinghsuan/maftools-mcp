# Stage 2 validation retry for Maftools-MCP estimate_signatures.
# MCP tool: estimate_signatures
# Input: LLM_validation_outputs/trinuc_matrix.rds
# Parameters: nMin = 2, nTry = 6, nrun = 10

library(maftools)
library(NMF)

input_rds <- "LLM_validation_outputs/trinuc_matrix.rds"
output_dir <- "LLM_validation_outputs"
output_rds <- file.path(output_dir, "estimateSignatures.direct_r.rds")
summary_tsv <- file.path(output_dir, "estimateSignatures.direct_r.nmfSummary.tsv")

trinuc <- readRDS(input_rds)

est <- maftools::estimateSignatures(
  mat = trinuc,
  nMin = 2,
  nTry = 6,
  nrun = 10,
  verbose = TRUE,
  plotBestFitRes = FALSE
)

saveRDS(est, output_rds)

if (is.list(est) && "nmfSummary" %in% names(est)) {
  utils::write.table(
    est$nmfSummary,
    file = summary_tsv,
    sep = "\t",
    quote = FALSE,
    row.names = FALSE
  )
}
