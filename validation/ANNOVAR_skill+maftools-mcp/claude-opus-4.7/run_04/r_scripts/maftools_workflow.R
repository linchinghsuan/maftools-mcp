# run_04 R script: replicate the Maftools-MCP workflow for reproducibility.
# 1) Merge 50 ANNOVAR multianno.txt files into a cohort MAF
# 2) Draw a top-20 oncoplot from the merged MAF
#
# Run:  Rscript maftools_workflow.R
#
# Notes:
#  - This mirrors what the Maftools-MCP tools executed during the actual run.
#  - Genome build hg19, protocol refGene (only DB available in humandb/).

suppressPackageStartupMessages({
    library(maftools)
})

run_dir      <- "/Users/linqingxuan/maftools-mcp/ANNOVAR_test/claude-opus-4.7/run_04"
annovar_dir  <- file.path(run_dir, "annovar_outputs")
out_dir      <- file.path(run_dir, "maftools_outputs")
dir.create(out_dir, showWarnings = FALSE, recursive = TRUE)

# ---- 1. Merge ANNOVAR outputs into a single MAF ----
annovar_files <- list.files(annovar_dir, pattern = "\\.hg19_multianno\\.txt$", full.names = TRUE)
stopifnot(length(annovar_files) == 50)

maf_path <- file.path(out_dir, "cohort_run04.maf")

annovarToMaf(
    annovar   = annovar_files,
    Center    = NA,
    refBuild  = "hg19",
    tsbCol    = NULL,
    table     = "refGene",
    ens2hugo  = TRUE,
    basename  = file.path(out_dir, "cohort_run04"),  # writes cohort_run04.maf
    sep       = "\t",
    MAFobj    = FALSE
)

# ---- 2. Read merged MAF and draw top-20 oncoplot ----
maf <- read.maf(maf = maf_path)

png(
    filename = file.path(out_dir, "oncoplot_top20.png"),
    width    = 2600,
    height   = 2000,
    res      = 300
)
oncoplot(
    maf       = maf,
    top       = 20,
    titleText = "Cohort Top-20 Oncoplot (run_04)"
)
dev.off()

cat("Done. Outputs written to:", out_dir, "\n")
