library(maftools)

maf <- readRDS("/Users/linqingxuan/mcp_server/maftools_mcp/src/maftools_mcp/tcga_data/BRCA.rds")

png("/Users/linqingxuan/maftools-mcp/Use-case_evaluation&repeated-run_performance/gpt-5.5/case_03/run_03/outputs/mafSurvGroup.png", width=2600, height=2000, res=300)

mafSurvGroup(
    maf = maf,
    geneSet = c("TP53"),
    time = "CDR_OS.time",
    Status = "CDR_OS"
)

dev.off()
