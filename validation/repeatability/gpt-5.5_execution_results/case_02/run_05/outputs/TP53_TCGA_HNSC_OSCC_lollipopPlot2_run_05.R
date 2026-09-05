# Auto-exported by Maftools-MCP export_r_script for validation.
# This script was captured from the existing MCP tool implementation.
# MCP tool: plot_lollipopPlot2
# Underlying R/Maftools function: maftools::lollipopPlot2
# Effective MCP parameters:
#   tcga_rds_path = "maftools_validation_data/LLM_Stage2_validation/LLM_validation_input_file/HNSC.rds"
#   user_maf_path = "maftools_validation_data/use_case_test/OSCC.maf"
#   user_maf_path2 = null
#   gene = "TP53"
#   output_dir = "maftools_validation_data/use_case_test/validation_results/gpt-5.5/case_02/run_05/outputs"
#   AACol1 = null
#   AACol2 = null
#   labPosAngle = 45
#   labPosSize = 0.4
#   refSeqID = null
#   proteinID = null
#   colors = null
#   alpha = 0.85
#   axisTextSize = [0.7, 0.7]
#   pointSize = 1
#   roundedRect = true
#   showDomainLabel = true
#   domainBorderCol = "gray40"
#   domainLabelSize = 0.55
#   legendTxtSize = 0.6
#   verbose = true
#   img_width = 2400
#   img_height = 1400

library(maftools)

m1 <- readRDS("maftools_validation_data/LLM_Stage2_validation/LLM_validation_input_file/HNSC.rds")
m2 <- maftools::read.maf("maftools_validation_data/use_case_test/OSCC.maf")




png("maftools_validation_data/use_case_test/validation_results/gpt-5.5/case_02/run_05/outputs/lollipop_TP53.png", width=2400, height=1400, res=300)

maftools::lollipopPlot2(
    m1 = m1,
    m2 = m2,
    gene = "TP53",

    AACol1 = NULL,
    AACol2 = NULL,

    m1_name = "TCGA",
    m2_name = "User",

    refSeqID = NULL,
    proteinID = NULL,

    labPosAngle = 45,
    labPosSize = 0.4,

    colors = NULL,
    alpha = 0.85,

    axisTextSize = c(0.7,0.7),
    pointSize = 1,

    roundedRect = TRUE,
    showDomainLabel = TRUE,

    domainBorderCol = "gray40",
    domainLabelSize = 0.55,

    legendTxtSize = 0.6,

    verbose = TRUE
)

dev.off()
