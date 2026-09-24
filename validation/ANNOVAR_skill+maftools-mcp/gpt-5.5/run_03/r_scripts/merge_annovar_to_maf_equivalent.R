suppressPackageStartupMessages({
  library(maftools)
})

run_dir <- "/Users/linqingxuan/maftools-mcp/ANNOVAR_test/gpt-5.5/run_03"
annovar_files <- Sys.glob(file.path(run_dir, "annotation", "*.hg19_multianno.txt"))
annovar_files <- sort(annovar_files)
out_maf <- file.path(run_dir, "maftools", "cohort_50.maf")

annovarToMaf(
  annovar = annovar_files,
  Center = NULL,
  refBuild = "hg19",
  tsbCol = NULL,
  table = "refGene",
  ens2hugo = TRUE,
  basename = sub("\\.maf$", "", out_maf),
  sep = "\t"
)
