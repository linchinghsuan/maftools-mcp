# Auto-exported by Maftools-MCP export_r_script for validation.

library(maftools)

# Directory with ANNOVAR files
input_dir <- "/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/OSCC"
files <- list.files(input_dir, pattern = "\\.hg19_multianno\\.txt$", full.names = TRUE)

# Convert all to MAF
mafs <- lapply(files, function(f) {
  sample_name <- gsub("\\.hg19_multianno\\.txt", "", basename(f))
  maf <- annovarToMaf(annovar = f, Center = 'C', refBuild = 'hg19',
               tsb = sample_name, table = 'refGene')
  colnames(maf)[colnames(maf) == 'sample_id'] <- 'Tumor_Sample_Barcode'
  maf
})

# Merge
combined_maf <- merge_mafs(mafs)

# Output directory
output_dir <- "/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/prompt_robustness/gemini-3.1-flash-lite/case_01/run_03/outputs"

# Oncoplot
png(file.path(output_dir, "oncoplot.png"), width = 2600, height = 2000)
oncoplot(maf = combined_maf, top = 20)
dev.off()

# Save MAF
write.mafSummary(maf = combined_maf, basename = file.path(output_dir, "cohort_maf"))
