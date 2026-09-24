# Auto-exported by Maftools-MCP export_r_script for validation.
# This script was captured from the existing MCP tool implementation.
# MCP tool: plot_maf_survgroup_custom
# Underlying R/Maftools function: maftools::mafSurvGroup
# Effective MCP parameters:
#   maf_path = "maftools_validation_data/LLM_Stage2_validation/LLM_validation_input_file/BRCA.maf"
#   clinical_csv = "maftools_validation_data/LLM_Stage2_validation/LLM_validation_input_file/BRCA_custom_survival_clinical.csv"
#   geneSet = ["TP53"]
#   sample_col = "Tumor_Sample_Barcode"
#   time_col = "CDR_OS.time"
#   status_col = "CDR_OS"
#   output_dir = "maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs"
#   img_width = 2600
#   img_height = 2000

library(maftools)

clin <- read.csv("maftools_validation_data/LLM_Stage2_validation/LLM_validation_input_file/BRCA_custom_survival_clinical.csv", header=TRUE, sep=",")

if (!("Tumor_Sample_Barcode" %in% colnames(clin))) stop("Sample column Tumor_Sample_Barcode missing in clinical CSV")
if (!("CDR_OS.time" %in% colnames(clin))) stop("Time column CDR_OS.time missing in clinical CSV")
if (!("CDR_OS" %in% colnames(clin))) stop("Status column CDR_OS missing in clinical CSV")

# make sure sample IDs match MAF Tumor_Sample_Barcode (commonly first 12 chars for TCGA-like IDs)
clin[[ "Tumor_Sample_Barcode" ]] <- substr(as.character(clin[[ "Tumor_Sample_Barcode" ]]), 1, 12)
colnames(clin)[colnames(clin) == "Tumor_Sample_Barcode"] <- "Tumor_Sample_Barcode"

maf <- read.maf(
    maf = "maftools_validation_data/LLM_Stage2_validation/LLM_validation_input_file/BRCA.maf",
    clinicalData = clin,
    verbose = TRUE
)

png("maftools_validation_data/LLM_Stage2_validation/LLM_validation_outputs/mafSurvGroup_CUSTOM.png", width=2600, height=2000, res=300)

mafSurvGroup(
    maf = maf,
    geneSet = c("TP53"),
    time = "CDR_OS.time",
    Status = "CDR_OS"
)

dev.off()
