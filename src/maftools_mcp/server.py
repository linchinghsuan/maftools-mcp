#!/usr/bin/env python3
from fastmcp import FastMCP
import rpy2.robjects as ro
from rpy2.robjects.packages import importr
from fastmcp.utilities.types import Image
from typing import List
from typing import Dict
from typing import Any
import os
import argparse
import glob
import inspect
import json
import re
import textwrap

# ========= MCP Server =========
mcp = FastMCP("maftools_mcp")

# ========= MCP Tools =========

@mcp.tool()
def describe_maftools_mcp() -> str:
    """
    Return a Markdown overview explaining what Maftools-MCP can do.
    Use this tool when the user asks what this MCP supports,
    what analyses it can perform, or how to use it.
    """

    return """
# Maftools-MCP: Capabilities Overview

Maftools-MCP is an AI-powered interface that connects natural language queries with the **R maftools ecosystem**, enabling users to perform cancer genomics analyses without writing R code.

It allows users to transform mutation datasets into interpretable insights and visualizations such as mutation landscapes, gene-level mutation maps, and clinical survival analysis.

---

# Common Workflows

Below are common analysis scenarios that **Maftools-MCP** can perform.

---

## 1️⃣ VCF Integration → Cohort Mutation Landscape

**Scenario**

You have multiple VCF files and want to merge them into a cohort-level dataset and visualize the overall mutation landscape.

**Typical Analysis**

- Merge multiple VCF files
- Convert VCF data into **MAF format**
- Generate a cohort-level **oncoplot**

**Example Prompt**

Merge all VCF files in `/app/outputs/` and generate an oncoplot of the top 20 most frequently mutated genes.

---

## 2️⃣ Cohort Overview from a MAF File

**Scenario**

You already have a **MAF file** and want a quick overview of the mutation landscape.

**Typical Analysis**

- Mutation summary
- Tumor Mutation Burden (TMB)
- Oncoplot visualization
- Variant allele frequency distribution

**Example Prompt**

Load `/app/outputs/cohort.maf`, summarize the mutation profile, and generate an oncoplot of the top 20 mutated genes.

---

## 3️⃣ Gene-Level Mutation Analysis

**Scenario**

You want to explore how mutations are distributed within a **specific gene**.

**Typical Analysis**

- Lollipop plot
- Mutation positions on the protein
- Protein domain visualization
- Mutation type distribution

**Example Prompt**

Generate a TP53 lollipop plot for the cohort `/app/outputs/cohort.maf`, including protein domains.

---

## 4️⃣ Cross-Cohort Comparison

**Scenario**

You want to compare mutation patterns between a **public dataset** and **your own cohort**.

**Typical Analysis**

- Mutation distribution comparison
- Gene mutation pattern comparison
- Visualization across cohorts

**Example Prompt**

Generate a TP53 lollipop plot comparing TCGA-HNSC with the OSCC cohort (`/app/outputs/OSCC.maf`).

---

## 5️⃣ Clinical Association & Survival Analysis

**Scenario**

You want to investigate whether specific mutations are associated with **clinical outcomes**.

**Typical Analysis**

- Mutation-based sample stratification
- Kaplan–Meier survival analysis
- Clinical feature association

**Required Clinical Fields (Example)**

- OS.time
- OS
- Tumor_Sample_Barcode

**Example Prompt**

Stratify TCGA-BRCA samples by TP53 mutation status and compare overall survival.

---

## 6️⃣ Mutational Signature & Pattern Analysis

**Scenario**

You want to investigate the **mutational processes** active in a cohort.

**Typical Analysis**

- Base substitution pattern analysis
- Mutational signature estimation
- Mutational spectrum visualization

**Example Prompt**

Analyze base substitution patterns and estimate mutational signatures in `/app/outputs/cohort.maf`.

---

## 7️⃣ Data Filtering & Subsetting

**Scenario**

You want to focus analysis on **specific genes, mutation types, or samples**.

**Typical Analysis**

- Filter mutations by gene
- Subset specific samples
- Analyze specific mutation classes

**Example Prompt**

Filter mutations for TP53 and PIK3CA in `/app/outputs/cohort.maf` and generate an oncoplot.

---

# Supported Data Formats

This MCP supports mutation datasets including:

- VCF (ANNOVAR-annotated)
- MAF (Mutation Annotation Format)
- RDS (maftools MAF objects)

If running the MCP through Docker, remember that input files should be placed under:

`/app/outputs/...`

---

# Documentation

For detailed documentation and usage examples:

https://reurl.cc/np64QD
"""

@mcp.tool()
def maftools_docs() -> str:
    """
    Return the Maftools-MCP documentation link.

    Use this tool when the user asks for:
    - documentation
    - guide
    - link
    - help
    - how to use Maftools-MCP
    - what this MCP can do

    Documentation:
    https://reurl.cc/np64QD
    """

    return "📖 Maftools-MCP Documentation: https://reurl.cc/np64QD"

@mcp.tool()
def merge_annovar_to_maf(
    annovar_files: List[str],
    output_dir: str = "outputs",
    refBuild: str = "hg19",         
    table: str = "refGene",
    ens2hugo: bool = True,
    sep: str = "\t",
    sampleAnno: str | None = None,
    basename: str = "merged"
) -> str:
    """
    Convert multiple ANNOVAR multianno(.txt) files into a single merged MAF file.
    Supports glob patterns in `annovar_files`, e.g. ["/app/outputs/OSCC/*.hg19_multianno.txt"].
    """

    os.makedirs(output_dir, exist_ok=True)

    # 1) Expand glob patterns in Python (R won't expand '*')
    expanded: List[str] = []
    for p in annovar_files:
        if any(ch in p for ch in ("*", "?", "[")):
            expanded.extend(glob.glob(p))
        else:
            expanded.append(p)

    # 2) De-duplicate, sort, and keep only readable files
    expanded = sorted(set(expanded))
    expanded = [
        f for f in expanded
        if os.path.isfile(f) and os.access(f, os.R_OK)
    ]

    if not expanded:
        return "❌ No readable annovar files found (after glob expansion)."

    # Helpers for R
    def r_null(x: str | None) -> str:
        return "NULL" if x is None else f'"{x}"'

    r_bool = "TRUE" if ens2hugo else "FALSE"
    annovar_list_r = "c(" + ",".join([f'"{p}"' for p in expanded]) + ")"

    output_path = os.path.join(output_dir, f"{basename}.maf")

    # 3) Run R (maftools)
    ro.r(f"""
        suppressPackageStartupMessages(library(maftools))

        files <- {annovar_list_r}

        maf_list <- list()
        idx <- 1

        for (f in files) {{
            maf_obj <- tryCatch({{
                annovarToMaf(
                    annovar = f,
                    Center = NULL,
                    refBuild = "{refBuild}",
                    tsbCol = NULL,
                    table = "{table}",
                    ens2hugo = {r_bool},
                    basename = NULL,
                    sep = "{sep}",
                    MAFobj = TRUE,
                    sampleAnno = {r_null(sampleAnno)}
                )
            }}, error = function(e) {{
                stop(paste0("annovarToMaf failed for file: ", f, "\\n", conditionMessage(e)))
            }})

            maf_list[[idx]] <- maf_obj
            idx <- idx + 1
        }}

        merged_maf <- tryCatch({{
            merge_mafs(maf_list)
        }}, error = function(e) {{
            stop(paste0("merge_mafs failed.\\n", conditionMessage(e)))
        }})

        maf_df <- merged_maf@data

        write.table(
            maf_df,
            file = "{output_path}",
            sep = "\\t",
            quote = FALSE,
            row.names = FALSE
        )
    """)

    return f"✅ Successfully merged {len(expanded)} files into {os.path.abspath(output_path)}"

@mcp.tool()
def merge_maf_to_mafobj(
    maf_files: List[str],
    output_dir: str = "outputs",
    output_basename: str = "final_merged",
    write_output: bool = True
) -> str:
    """
    Merge multiple MAF files into a single MAF object.
    """

    os.makedirs(output_dir, exist_ok=True)

    maf_list_r = "c(" + ",".join([f'"{p}"' for p in maf_files]) + ")"
    output_path = os.path.join(output_dir, output_basename + ".maf")

    ro.r(f"""
        library(data.table)
        library(foreach)
        library(doParallel)
        library(maftools)

        files <- {maf_list_r}

        # parallel backend: use 8 cores only if > 1 file
        cores <- ifelse(length(files) > 1, 8, 1)
        cl <- makeCluster(cores)
        registerDoParallel(cl)

        merged_df <- foreach(i = 1:length(files), .combine = rbind, .packages = "data.table") %dopar% {{
            fread(cmd = paste("grep -v '#' ", files[i]), quote = FALSE)
        }}

        stopCluster(cl)

        maf_obj <- read.maf(merged_df)

        if ({'TRUE' if write_output else 'FALSE'}) {{
            write.table(
                merged_df,
                file = "{output_path}",
                sep = "\\t",
                quote = FALSE,
                row.names = FALSE
            )
        }}
    """)

    if write_output:
        return f"✅ Successfully merged {len(maf_files)} MAF files → {os.path.abspath(output_path)}"
    else:
        return f"✅ Successfully merged {len(maf_files)} MAF files into a MAF object (no file written)."

@mcp.tool()
def rds_to_maf(
    rds_path: str,
    output_dir: str = "outputs",
    basename: str | None = None
) -> str:
    """
    Convert an RDS MAF object into a standard MAF TSV file usable by all maftools tools.
    """
    import os

    os.makedirs(output_dir, exist_ok=True)

    if basename is None:
        basename = os.path.splitext(os.path.basename(rds_path))[0]

    maf_out = os.path.abspath(
        os.path.join(output_dir, f"{basename}.maf")
    )

    ro.r(f"""
        maf_obj <- readRDS("{rds_path}")

        # Verify this is a MAF object
        if (!inherits(maf_obj, "MAF")) {{
            stop("Provided RDS is not a maftools::MAF object.")
        }}

        # Export MAF table
        write.table(
            maf_obj@data,
            file = "{maf_out}",
            sep = "\\t",
            quote = FALSE,
            row.names = FALSE
        )
    """)

    return (
        "✅ Converted MAF RDS to plain MAF TSV.\n"
        f"📁 Input RDS: {os.path.abspath(rds_path)}\n"
        f"📄 Output MAF: {maf_out}"
    )
    
@mcp.tool()
def list_genes(maf_path: str, output_file: str = "gene_list.txt") -> str:
    """List all unique genes in the MAF file."""
    if not os.path.exists(maf_path):
        return f"❌ File not found: {maf_path}"

    ro.r(f"""
        maf <- maftools::read.maf("{maf_path}")
        genes <- unique(maf@data$Hugo_Symbol)
        write.table(genes, file="{output_file}", quote=FALSE,
                    row.names=FALSE, col.names=FALSE)
    """)

    # Read gene list
    with open(output_file) as f:
        genes = [line.strip() for line in f.readlines()]

    count = len(genes)
    preview = ", ".join(genes[:10])  # show first 10 genes

    return (
        f"🧬 Found {count} unique genes.\n"
        f"📄 Full list saved to {os.path.abspath(output_file)}\n"
        f"🔍 Preview: {preview} ..."
    )

@mcp.tool()
def list_samples(maf_path: str, output_file: str = "sample_list.txt") -> str:
    """List all unique Tumor_Sample_Barcodes in the MAF file."""
    if not os.path.exists(maf_path):
        return f"❌ File not found: {maf_path}"

    ro.r(f"""
        maf <- maftools::read.maf("{maf_path}")
        samples <- unique(maf@data$Tumor_Sample_Barcode)

        write.table(
            samples,
            file = "{output_file}",
            quote = FALSE,
            row.names = FALSE,
            col.names = FALSE
        )
    """)

    # Read output file
    with open(output_file) as f:
        samples = [line.strip() for line in f.readlines()]

    count = len(samples)
    preview = ", ".join(samples[:10]) if count > 0 else "(empty)"

    return (
        f"🧪 Found {count} unique samples.\n"
        f"📄 Full list saved to {os.path.abspath(output_file)}\n"
        f"🔍 Preview: {preview} ..."
    )
   
@mcp.tool()
def summarize_maf(maf_path: str) -> str:
    """Summarize MAF file and return sample stats."""
    if not os.path.exists(maf_path):
        return f"❌ File not found: {maf_path}"

    ro.r(f"""
        maf <- maftools::read.maf("{maf_path}")
        sink("summary.txt")
        print(maftools::getSampleSummary(maf))
        sink()
    """)

    with open("summary.txt") as f:
        return f.read()


@mcp.tool()
def plot_summary(
    maf_path: str,
    img_width: int = 2600,
    img_height: int = 2000,
    output_dir: str = "outputs",
    fs: float = 1,
    top: int = 10
) -> Image:
    """Generate mutation summary plot."""

    os.makedirs(output_dir, exist_ok=True)
    out_png = os.path.join(output_dir, "plot_summary.png")

    if maf_path.endswith(".rds"):
        r_load = f'maf <- readRDS("{maf_path}")'
    else:
        r_load = f'maf <- maftools::read.maf("{maf_path}")'

    ro.r(f"""
        library(maftools)

        {r_load}

        png("{out_png}", width={img_width}, height={img_height}, res=300)

        plotmafSummary(
            maf = maf,
            fs = {fs},
            top = {top}
        )

        dev.off()
    """)

    return Image(path=out_png)


@mcp.tool()
def plot_oncoplot(
    maf_path: str,
    output_dir: str = "outputs",
    top: int = 20,
    minMut: int | None = None,
    genes: list[str] | None = None,
    altered: bool = False,
    drawRowBar: bool = True,
    drawColBar: bool = True,
    leftBarData: str | None = None,
    leftBarLims: list[int] | None = None,
    rightBarData: str | None = None,
    rightBarLims: list[int] | None = None,
    topBarData: str | None = None,
    logColBar: bool = False,
    includeColBarCN: bool = True,
    clinicalFeatures: list[str] | None = None,
    annotationColor: str | None = None,
    annotationDat: str | None = None,
    pathways: str | None = None,
    selectedPathways: list[str] | None = None,
    draw_titv: bool = False,
    showTumorSampleBarcodes: bool = False,
    barcode_mar: int = 4,
    barcodeSrt: int = 90,
    gene_mar: int = 5,
    anno_height: int = 1,
    legend_height: int = 4,
    sortByAnnotation: bool = False,
    groupAnnotationBySize: bool = True,
    annotationOrder: list[str] | None = None,
    sortByMutation: bool = False,
    keepGeneOrder: bool = False,
    GeneOrderSort: bool = True,
    sampleOrder: list[str] | None = None,
    additionalFeature: str | None = None,
    additionalFeaturePch: int = 20,
    additionalFeatureCol: str = "gray70",
    additionalFeatureCex: float = 0.9,
    genesToIgnore: list[str] | None = None,
    removeNonMutated: bool = True,
    fill: bool = True,
    cohortSize: int | None = None,
    colors: list[str] | None = None,
    bgCol: str = "#CCCCCC",
    borderCol: str = "white",
    annoBorderCol: str | None = None,
    numericAnnoCol: str | None = None,
    drawBox: bool = False,
    fontSize: float = 0.8,
    SampleNamefontSize: float = 1.0,
    titleFontSize: float = 1.5,
    legendFontSize: float = 1.2,
    annotationFontSize: float = 1.2,
    sepwd_genes: float = 0.5,
    sepwd_samples: float = 0.25,
    writeMatrix: bool = False,
    colbar_pathway: bool = False,
    showTitle: bool = True,
    titleText: str | None = None,
    img_width: int = 2600,
    img_height: int = 2000,
    img_res: int = 300,
    out_name: str = "oncoplot.png",
) -> Image:
    """
    Takes output generated by read.maf and draws an oncoplot.
    """

    # ---------- helpers: Python -> R literals ----------
    def r_bool(x: bool) -> str:
        return "TRUE" if x else "FALSE"

    def r_str(x: str | None) -> str:
        # empty string also treated as NULL to avoid R errors for file-path-like args
        return "NULL" if x is None or x == "" else f'"{x}"'

    def r_chr_vec(x: list[str] | None) -> str:
        # None or [] -> NULL (avoid c() edge cases)
        if not x:
            return "NULL"
        return "c(" + ",".join([f'"{i}"' for i in x]) + ")"

    def r_num_vec(x: list[int] | None) -> str:
        if not x:
            return "NULL"
        return "c(" + ",".join([str(int(i)) for i in x]) + ")"

    def r_int_or_null(x: int | None) -> str:
        return "NULL" if x is None else str(int(x))

    # ---------- I/O ----------
    os.makedirs(output_dir, exist_ok=True)
    out_png = os.path.abspath(os.path.join(output_dir, out_name))

    # ---------- load maf ----------
    if maf_path.lower().endswith(".rds"):
        r_load = f'maf <- readRDS("{maf_path}")'
    else:
        r_load = f'maf <- maftools::read.maf("{maf_path}")'

    # ---------- R script ----------
    r_script = f"""
    suppressPackageStartupMessages(library(maftools))

    {r_load}

    png("{out_png}", width={img_width}, height={img_height}, res={img_res})

    oncoplot(
        maf = maf,
        top = {top},
        minMut = {r_int_or_null(minMut)},
        genes = {r_chr_vec(genes)},
        altered = {r_bool(altered)},
        drawRowBar = {r_bool(drawRowBar)},
        drawColBar = {r_bool(drawColBar)},
        leftBarData = {r_str(leftBarData)},
        leftBarLims = {r_num_vec(leftBarLims)},
        rightBarData = {r_str(rightBarData)},
        rightBarLims = {r_num_vec(rightBarLims)},
        topBarData = {r_str(topBarData)},
        logColBar = {r_bool(logColBar)},
        includeColBarCN = {r_bool(includeColBarCN)},
        clinicalFeatures = {r_chr_vec(clinicalFeatures)},
        annotationColor = {r_str(annotationColor)},
        annotationDat = {r_str(annotationDat)},
        pathways = {r_str(pathways)},
        selectedPathways = {r_chr_vec(selectedPathways)},
        draw_titv = {r_bool(draw_titv)},
        showTumorSampleBarcodes = {r_bool(showTumorSampleBarcodes)},
        barcode_mar = {barcode_mar},
        barcodeSrt = {barcodeSrt},
        gene_mar = {gene_mar},
        anno_height = {anno_height},
        legend_height = {legend_height},
        sortByAnnotation = {r_bool(sortByAnnotation)},
        groupAnnotationBySize = {r_bool(groupAnnotationBySize)},
        annotationOrder = {r_chr_vec(annotationOrder)},
        sortByMutation = {r_bool(sortByMutation)},
        keepGeneOrder = {r_bool(keepGeneOrder)},
        GeneOrderSort = {r_bool(GeneOrderSort)},
        sampleOrder = {r_chr_vec(sampleOrder)},
        additionalFeature = {r_str(additionalFeature)},
        additionalFeaturePch = {additionalFeaturePch},
        additionalFeatureCol = "{additionalFeatureCol}",
        additionalFeatureCex = {additionalFeatureCex},
        genesToIgnore = {r_chr_vec(genesToIgnore)},
        removeNonMutated = {r_bool(removeNonMutated)},
        fill = {r_bool(fill)},
        cohortSize = {r_int_or_null(cohortSize)},
        colors = {r_chr_vec(colors)},
        bgCol = "{bgCol}",
        borderCol = "{borderCol}",
        annoBorderCol = {r_str(annoBorderCol)},
        numericAnnoCol = {r_str(numericAnnoCol)},
        drawBox = {r_bool(drawBox)},
        fontSize = {fontSize},
        SampleNamefontSize = {SampleNamefontSize},
        titleFontSize = {titleFontSize},
        legendFontSize = {legendFontSize},
        annotationFontSize = {annotationFontSize},
        sepwd_genes = {sepwd_genes},
        sepwd_samples = {sepwd_samples},
        writeMatrix = {r_bool(writeMatrix)},
        colbar_pathway = {r_bool(colbar_pathway)},
        showTitle = {r_bool(showTitle)},
        titleText = {r_str(titleText)}
    )

    dev.off()
    """
    ro.r(r_script)
    return Image(path=out_png)
    
@mcp.tool()
def plot_titv(
    maf_path: str,
    useSyn: bool = True,
    plotType: str = "both",
    sampleOrder: list[str] | None = None,
    color: list[str] | None = None,
    showBarcodes: bool = False,
    textSize: float = 0.8,
    baseFontSize: float = 1.0,
    axisTextSize: list[float] | None = None,
    plotNotch: bool = False,
    img_width: int = 2600,
    img_height: int = 2000,
    output_dir: str = "outputs"
) -> Image:
    """
    Plot Transition and Transversion (Ti/Tv) ratios.
    """
    import os
    os.makedirs(output_dir, exist_ok=True)
    out_png = os.path.abspath(os.path.join(output_dir, "titv_plot.png"))
    def vec(x):
        if x is None:
            return "NULL"
        return "c(" + ",".join(f'"{i}"' for i in x) + ")"

    def vec_num(x):
        if x is None:
            return "NULL"
        return "c(" + ",".join(str(i) for i in x) + ")"

    def bool_r(x):
        return "TRUE" if x else "FALSE"

    r_sampleOrder = vec(sampleOrder)
    r_color = vec(color)
    r_showBar = bool_r(showBarcodes)
    r_axisText = vec_num(axisTextSize)
    r_plotNotch = bool_r(plotNotch)
    r_useSyn = bool_r(useSyn)
    
    maf_loader = (
        f'readRDS("{maf_path}")'
        if maf_path.lower().endswith(".rds")
        else f'read.maf("{maf_path}")'
    )

    ro.r(f"""
        library(maftools)

        maf <- {maf_loader}

        # calculate TiTv matrix
        titv_res <- maftools::titv(
            maf = maf,
            plot = FALSE,
            useSyn = {r_useSyn}
        )

        png("{out_png}", width={img_width}, height={img_height}, res=300)
        maftools::plotTiTv(
            res = titv_res,
            plotType = "{plotType}",
            sampleOrder = {r_sampleOrder},
            color = {r_color},
            showBarcodes = {r_showBar},
            textSize = {textSize},
            baseFontSize = {baseFontSize},
            axisTextSize = {r_axisText},
            plotNotch = {r_plotNotch}
        )
        dev.off()
    """)

    return Image(path=os.path.abspath(out_png))


@mcp.tool()
def plot_vaf(
    maf_path: str,
    vafCol: str = "t_vaf",
    genes: list[str] | None = None,
    top: int = 10,
    orderByMedian: bool = True,
    keepGeneOrder: bool = False,
    flip: bool = False,
    fn: str | None = None,
    gene_fs: float = 0.8,
    axis_fs: float = 0.8,
    height: float = 5,
    width: float = 5,
    showN: bool = True,
    color: list[str] | None = None,
    vaf_cutoff: float = 0,
    output_dir: str = "outputs"
) -> Image:
    """
    Plots vaf distribution of genes as a boxplot.
    """

    import os
    os.makedirs(output_dir, exist_ok=True)

    # Output path
    out_png = fn if fn else os.path.abspath(
        os.path.join(output_dir, "vaf_plot.png")
    )

    # ----- helpers -----
    def vec(x):
        if x is None:
            return "NULL"
        return "c(" + ",".join(f'"{i}"' for i in x) + ")"

    def bool_r(x):
        return "TRUE" if x else "FALSE"

    r_genes = vec(genes)
    r_color = vec(color)
    r_orderByMedian = bool_r(orderByMedian)
    r_keepGeneOrder = bool_r(keepGeneOrder)
    r_flip = bool_r(flip)
    r_showN = bool_r(showN)

    maf_loader = (
        f'readRDS("{maf_path}")'
        if maf_path.lower().endswith(".rds")
        else f'read.maf("{maf_path}")'
    )

    ro.r(f"""
        library(maftools)

        maf <- {maf_loader}
        maf_data <- maf@data

        # ---- Compute VAF if missing ----
        if (!("{vafCol}" %in% colnames(maf_data))) {{
            maf_data$t_alt_count <- suppressWarnings(as.numeric(maf_data$t_alt_count))
            maf_data$t_ref_count <- suppressWarnings(as.numeric(maf_data$t_ref_count))

            maf_data$t_vaf <- maf_data$t_alt_count /
                              (maf_data$t_alt_count + maf_data$t_ref_count)

            maf@data <- maf_data
        }}

        # ---- Apply VAF cutoff ----
        if ({vaf_cutoff} > 0) {{
            maf_data <- maf@data
            maf_data <- maf_data[ maf_data${vafCol} > {vaf_cutoff}, ]
            maf@data <- maf_data
        }}

        # ---- Plot ----
        png("{out_png}", width = {int(width*300)}, height = {int(height*300)}, res = 300)

        maftools::plotVaf(
            maf = maf,
            vafCol = "{vafCol}",
            genes = {r_genes},
            top = {top},
            orderByMedian = {r_orderByMedian},
            keepGeneOrder = {r_keepGeneOrder},
            flip = {r_flip},
            fn = NULL,
            gene_fs = {gene_fs},
            axis_fs = {axis_fs},
            height = {height},
            width = {width},
            showN = {r_showN},
            color = {r_color}
        )

        dev.off()
    """)

    return Image(path=os.path.abspath(out_png))
    
@mcp.tool()
def math_score(
    maf_path: str,
    vafCol: str | None = None,   
    sampleName: str | None = None, 
    vafCutOff: float = 0.075,
    output_dir: str = "outputs"
) -> str:
    """
    Calcuates Mutant-Allele Tumor Heterogeneity (MATH) scores from variant allele frequencies.
    """
    import os
    os.makedirs(output_dir, exist_ok=True)

    r_vafCol = "NULL" if vafCol is None else f'"{vafCol}"'
    r_sampleName = "NULL" if sampleName is None else f'"{sampleName}"'

    out_tsv = os.path.abspath(os.path.join(output_dir, "math_score.tsv"))

    ro.r(f"""
        library(maftools)

        maf <- read.maf("{maf_path}")
        maf_data <- maf@data

        # ---- Auto compute VAF column if missing ----
        if (!is.null({r_vafCol}) && !({r_vafCol} %in% colnames(maf_data))) {{

            maf_data$t_alt_count <- suppressWarnings(as.numeric(maf_data$t_alt_count))
            maf_data$t_ref_count <- suppressWarnings(as.numeric(maf_data$t_ref_count))

            maf_data$t_vaf <- maf_data$t_alt_count /
                              (maf_data$t_alt_count + maf_data$t_ref_count)

            maf@data <- maf_data

            message("VAF column not found. Auto-generated t_vaf using counts.")
        }}

        # ---- run MATH score ----
        math_res <- math.score(
            maf = maf,
            vafCol = {r_vafCol},
            sampleName = {r_sampleName},
            vafCutOff = {vafCutOff}
        )

        # normalize to data.frame
        if (is.data.frame(math_res)) {{
            out_df <- math_res
        }} else {{
            out_df <- as.data.frame(math_res)
        }}

        write.table(
            out_df,
            file="{out_tsv}",
            sep="\\t",
            quote=FALSE,
            row.names=FALSE
        )
    """)

    return f"📐 MATH score table saved: {out_tsv}"

@mcp.tool()
def plot_lollipop(
    maf_path: str,
    gene: str,
    output_dir: str = "outputs",
    img_width: int = 2600,
    img_height: int = 2000,
    AACol: str | None = None,
    labelPos: list[int] | None = None,
    labPosSize: float = 0.9,
    showMutationRate: bool = True,
    showDomainLabel: bool = True,
    cBioPortal: bool = False,
    refSeqID: str | None = None,
    proteinID: str | None = None,
    roundedRect: bool = True,
    repel: bool = False,
    collapsePosLabel: bool = True,
    showLegend: bool = True,
    legendTxtSize: float = 0.8,
    labPosAngle: float = 0,
    domainLabelSize: float = 0.8,
    axisTextSize: list[float] | None = None,
    printCount: bool = False,
    colors: list[str] | None = None,
    domainAlpha: float = 1,
    domainBorderCol: str = "black",
    bgBorderCol: str = "black",
    labelOnlyUniqueDoamins: bool = True,
    defaultYaxis: bool = False,
    titleSize: list[float] | None = None,
    pointSize: float = 1.5,
) -> Image:
    """
    Draws lollipop plot of amino acid changes. Protein domains are derived from PFAM database.
    """

    import os

    if gene.strip() == "":
        raise ValueError("You must specify a gene for lollipopPlot.")

    if not os.path.exists(maf_path):
        raise FileNotFoundError(f"File not found: {maf_path}")

    os.makedirs(output_dir, exist_ok=True)

    to_r_vec = lambda x: (
        "NULL" if (x is None or len(x) == 0) else "c(" + ",".join([f'"{i}"' for i in x]) + ")"
    )
    to_r_num_vec = lambda x: (
        "NULL" if (x is None or len(x) == 0) else "c(" + ",".join([str(i) for i in x]) + ")"
    )
    to_r_bool = lambda x: "TRUE" if x else "FALSE"

    r_AACol = "NULL" if AACol is None else f'"{AACol}"'
    r_labelPos = to_r_num_vec(labelPos)

    r_showMutationRate = to_r_bool(showMutationRate)
    r_showDomainLabel = to_r_bool(showDomainLabel)
    r_cBioPortal = to_r_bool(cBioPortal)

    r_refSeqID = "NULL" if refSeqID is None else f'"{refSeqID}"'
    r_proteinID = "NULL" if proteinID is None else f'"{proteinID}"'

    r_roundedRect = to_r_bool(roundedRect)
    r_repel = to_r_bool(repel)
    r_collapsePosLabel = to_r_bool(collapsePosLabel)
    r_showLegend = to_r_bool(showLegend)

    r_axisTextSize = to_r_num_vec(axisTextSize)
    r_printCount = to_r_bool(printCount)

    r_colors = to_r_vec(colors)

    r_labelOnlyUniqueDoamins = to_r_bool(labelOnlyUniqueDoamins)
    r_defaultYaxis = to_r_bool(defaultYaxis)

    r_titleSize = to_r_num_vec(titleSize)

    out_png = os.path.abspath(
        os.path.join(output_dir, f"lollipop_{gene}.png")
    )

    ro.r(f"""
        library(maftools)

        maf <- maftools::read.maf("{maf_path}")

        png("{out_png}", width={img_width}, height={img_height}, res=300)

        maftools::lollipopPlot(
            maf = maf,
            gene = "{gene}",
            AACol = {r_AACol},
            labelPos = {r_labelPos},
            labPosSize = {labPosSize},
            showMutationRate = {r_showMutationRate},
            showDomainLabel = {r_showDomainLabel},
            cBioPortal = {r_cBioPortal},
            refSeqID = {r_refSeqID},
            proteinID = {r_proteinID},
            roundedRect = {r_roundedRect},
            repel = {r_repel},
            collapsePosLabel = {r_collapsePosLabel},
            showLegend = {r_showLegend},
            legendTxtSize = {legendTxtSize},
            labPosAngle = {labPosAngle},
            domainLabelSize = {domainLabelSize},
            axisTextSize = {r_axisTextSize},
            printCount = {r_printCount},
            colors = {r_colors},
            domainAlpha = {domainAlpha},
            domainBorderCol = "{domainBorderCol}",
            bgBorderCol = "{bgBorderCol}",
            labelOnlyUniqueDoamins = {r_labelOnlyUniqueDoamins},
            defaultYaxis = {r_defaultYaxis},
            titleSize = {r_titleSize},
            pointSize = {pointSize}
        )

        dev.off()
    """)

    return Image(path=os.path.abspath(out_png))
    
@mcp.tool()
def plot_rainfall(
    maf_path: str,
    sample: str,
    output_dir: str = "outputs",
    img_width: int = 2600,
    img_height: int = 2000,
    detectChangePoints: bool = False,
    color: list[str] | None = None,
    savePlot: bool = False,
    width: float = 6,
    height: float = 3,
    fontSize: float = 1.2,
    pointSize: float = 0.4
) -> Image:
    """Generate rainfall plot for a specific Tumor_Sample_Barcode."""

    import os

    if not os.path.exists(maf_path):
        raise FileNotFoundError(f"File not found: {maf_path}")

    if sample.strip() == "":
        raise ValueError("ERROR: sample (tsb) cannot be empty.")

    os.makedirs(output_dir, exist_ok=True)

    to_r_vec = lambda x: (
        "NULL" if (x is None or len(x) == 0) else "c(" + ",".join([f'"{i}"' for i in x]) + ")"
    )
    to_r_bool = lambda x: "TRUE" if x else "FALSE"

    r_color = to_r_vec(color)
    r_detectChangePoints = to_r_bool(detectChangePoints)
    r_savePlot = to_r_bool(savePlot)

    out_png = os.path.abspath(
        os.path.join(output_dir, f"rainfall_{sample}.png")
    )

    ro.r(f"""
        library(maftools)

        maf <- maftools::read.maf("{maf_path}")

        png("{out_png}", width={img_width}, height={img_height}, res=300)

        maftools::rainfallPlot(
            maf = maf,
            tsb = "{sample}",
            detectChangePoints = {r_detectChangePoints},
            color = {r_color},
            savePlot = {r_savePlot},
            width = {width},
            height = {height},
            fontSize = {fontSize},
            pointSize = {pointSize}
        )

        dev.off()
    """)

    return Image(path=out_png)
    
@mcp.tool()
def plot_tcga_compare(
    maf_path: str,
    capture_size: float | None = None,
    tcga_capture_size: float = 35.8,
    cohortName: str | None = None,
    tcga_cohorts: list[str] | None = None,
    primarySite: bool = False,
    col: list[str] = ["gray70", "black"],
    bg_col: list[str] = ["#EDF8B1", "#2C7FB8"],
    medianCol: str = "red",
    decreasing: bool = False,
    logscale: bool = True,
    rm_hyper: bool = False,
    rm_zero: bool = True,
    cohortFontSize: float = 0.8,
    axisFontSize: float = 0.8,
    output_dir: str = "outputs",
    img_width: int = 2600,
    img_height: int = 2000
) -> Image:
    """Compares mutation load in input MAF against all of 33 TCGA cohorts."""

    import os

    if not os.path.exists(maf_path):
        raise FileNotFoundError(f"File not found: {maf_path}")
    os.makedirs(output_dir, exist_ok=True)

    to_r_vec = lambda x: (
        "NULL" if (x is None or len(x) == 0) else "c(" + ",".join([f'"{i}"' for i in x]) + ")"
    )
    to_r_bool = lambda x: "TRUE" if x else "FALSE"

    r_tcga_cohorts = to_r_vec(tcga_cohorts)
    r_col = to_r_vec(col)
    r_bg_col = to_r_vec(bg_col)

    r_capture_size = "NULL" if capture_size is None else capture_size
    r_primarySite = to_r_bool(primarySite)
    r_decreasing = to_r_bool(decreasing)
    r_logscale = to_r_bool(logscale)
    r_rm_hyper = to_r_bool(rm_hyper)
    r_rm_zero = to_r_bool(rm_zero)

    r_cohortName = "NULL" if cohortName is None else f'"{cohortName}"'

    out_png = os.path.abspath(
        os.path.join(output_dir, "tcga_compare.png")
    )

    ro.r(f"""
        library(maftools)

        maf <- maftools::read.maf("{maf_path}")

        png("{out_png}", width={img_width}, height={img_height}, res=300)

        maftools::tcgaCompare(
            maf = maf,
            capture_size = {r_capture_size},
            tcga_capture_size = {tcga_capture_size},
            cohortName = {r_cohortName},
            tcga_cohorts = {r_tcga_cohorts},
            primarySite = {r_primarySite},
            col = {r_col},
            bg_col = {r_bg_col},
            medianCol = "{medianCol}",
            decreasing = {r_decreasing},
            logscale = {r_logscale},
            rm_hyper = {r_rm_hyper},
            rm_zero = {r_rm_zero},
            cohortFontSize = {cohortFontSize},
            axisFontSize = {axisFontSize}
        )

        dev.off()
    """)

    return Image(path=out_png)

# ----------------------------
# 1) TCGA mappings
# ----------------------------
TCGA_BASE: Dict[str, str] = {
    "ACC": "Adrenocortical carcinoma",
    "BLCA": "Bladder Urothelial Carcinoma",
    "BRCA": "Breast Invasive Carcinoma",
    "CESC": "Cervical and Endocervical Cancers",
    "CHOL": "Cholangiocarcinoma",
    "COAD": "Colon Adenocarcinoma",
    "DLBC": "Lymphoid Neoplasm Diffuse Large B-cell Lymphoma",
    "ESCA": "Esophageal Carcinoma",
    "GBM": "Glioblastoma Multiforme",
    "HNSC": "Head and Neck Squamous Cell Carcinoma",
    "KICH": "Kidney Chromophobe",
    "KIRC": "Kidney Renal Clear Cell Carcinoma",
    "KIRP": "Kidney Renal Papillary Cell Carcinoma",
    "LAML": "Acute Myeloid Leukemia",
    "LGG": "Brain Lower Grade Glioma",
    "LIHC": "Liver Hepatocellular Carcinoma",
    "LUAD": "Lung Adenocarcinoma",
    "LUSC": "Lung Squamous Cell Carcinoma",
    "MESO": "Mesothelioma",
    "OV": "Ovarian Serous Cystadenocarcinoma",
    "PAAD": "Pancreatic Adenocarcinoma",
    "PCPG": "Pheochromocytoma and Paraganglioma",
    "PRAD": "Prostate Adenocarcinoma",
    "READ": "Rectum Adenocarcinoma",
    "SARC": "Sarcoma",
    "SKCM": "Skin Cutaneous Melanoma",
    "STAD": "Stomach Adenocarcinoma",
    "TGCT": "Testicular Germ Cell Tumors",
    "THCA": "Thyroid Carcinoma",
    "THYM": "Thymoma",
    "UCEC": "Uterine Corpus Endometrial Carcinoma",
    "UCS": "Uterine Carcinosarcoma",
    "UVM": "Uveal Melanoma",
}

TCGA_STUDY_MAP: Dict[str, str] = {}
for abbr, fullname in TCGA_BASE.items():
    TCGA_STUDY_MAP[abbr.lower()] = abbr
    TCGA_STUDY_MAP[f"{abbr.lower()} - {fullname.lower()}"] = abbr


# ----------------------------
# 2) PCAWG mappings
# ----------------------------
PCAWG_BASE: Dict[str, str] = {
    "Biliary-AdenoCA": "Biliary Adenocarcinoma",
    "Bone-Cart": "Bone, Cartilaginous neoplasm",
    "Bone-Epith": "Bone neoplasm, epithelioid",
    "Bone-Osteosarc": "Bone, Osteosarcoma",
    "Breast-AdenoCa": "Breast, Adenocarcinoma",
    "Breast-DCIS": "Breast, Duct micropapillary carcinoma",
    "Breast-LobularCa": "Breast, Lobular carcinoma",
    "CNS-Medullo": "CNS, Medulloblastoma",
    "CNS-PiloAstro": "CNS, Pilocytic astrocytoma",
    "Eso-AdenoCa": "Esophagus, Adenocarcinoma",
    "Head-SCC": "Head/Neck Squamous cell carcinoma",
    "Kidney-RCC": "Kidney Renal cell carcinoma",
    "Liver-HCC": "Hepatocellular carcinoma",
    "Lymph-BNHL": "Mature B-cell lymphoma",
    "Lymph-CLL": "Chronic lymphocytic leukemia",
    "Lymph-NOS": "Lymphoma, Not Otherwise Specified",
    "Myeloid-AML": "Acute myeloid leukemia",
    "Myeloid-MDS": "Myelodysplastic syndrome",
    "Myeloid-MPN": "Myeloproliferative neoplasm",
    "Ovary-AdenoCA": "Ovary, Adenocarcinoma",
    "Panc-AdenoCA": "Pancreas, Adenocarcinoma",
    "Panc-Endocrine": "Pancreas, Neuroendocrine tumor",
    "Prost-AdenoCA": "Prostate, Adenocarcinoma",
    "Skin-Melanoma": "Melanoma",
    "Stomach-AdenoCA": "Stomach, Adenocarcinoma",
}


def normalize_key(x: str) -> str:
    # PCAWG keys often include "-" and mixed case; keep "-" but normalize case/spaces/underscores.
    return x.lower().strip().replace("_", "-")


PCAWG_STUDY_MAP: Dict[str, str] = {}
for abbr, fullname in PCAWG_BASE.items():
    PCAWG_STUDY_MAP[normalize_key(abbr)] = abbr
    PCAWG_STUDY_MAP[normalize_key(f"{abbr} - {fullname}")] = abbr


# ----------------------------
# 4) Available list tools
# ----------------------------
@mcp.tool()
def tcga_available() -> str:
    """
    List available TCGA studies.
    """
    lines = [f"{abbr} - {fullname}" for abbr, fullname in TCGA_BASE.items()]
    return "📊 Available TCGA studies:\n" + "\n".join(lines)


@mcp.tool()
def pcawg_available() -> str:
    """
    List available PCAWG studies.
    """
    lines = [f"{abbr} - {fullname}" for abbr, fullname in PCAWG_BASE.items()]
    return "📊 Available PCAWG studies:\n" + "\n".join(lines)


# ----------------------------
# 5) Loader tools
# ----------------------------
@mcp.tool()
def load_tcga_data(cancer_name: str) -> str:
    """
    Load TCGA MAF dataset.
      - tcga_data/{study}.rds   (MAF object)
      - tcga_data/{study}.maf   (tab-delimited MAF table)
    """
    cancer_key = cancer_name.lower().strip()

    if cancer_key not in TCGA_STUDY_MAP:
        return f"❌ No matching TCGA study found for: {cancer_name}"

    study = TCGA_STUDY_MAP[cancer_key]

    output_dir = "tcga_data"
    os.makedirs(output_dir, exist_ok=True)

    rds_path = os.path.abspath(os.path.join(output_dir, f"{study}.rds"))
    maf_path = os.path.abspath(os.path.join(output_dir, f"{study}.maf"))

    ro.r(f"""
        suppressPackageStartupMessages(library(TCGAmutations))
        suppressPackageStartupMessages(library(maftools))

        maf_obj <- TCGAmutations::tcga_load(study = "{study}")

        # 1) save RDS (keeps full MAF object: slots, annotations, etc.)
        saveRDS(maf_obj, file = "{rds_path}")

        # 2) save as .maf (write the underlying MAF data table)
        maf_tbl <- maf_obj@data

        write.table(
          maf_tbl,
          file = "{maf_path}",
          sep = "\\t",
          quote = FALSE,
          row.names = FALSE
        )
    """)

    return (
        f"✅ TCGA {study} loaded.\n"
        f"📦 RDS saved: {rds_path}\n"
        f"📄 MAF saved: {maf_path}"
    )


@mcp.tool()
def load_pcawg_data(cancer_name: str) -> str:
    """
    Load PCAWG MAF dataset.
      - pcawg_data/{study}.rds
      - pcawg_data/{study}.maf
    """
    cancer_key = normalize_key(cancer_name)

    if cancer_key not in PCAWG_STUDY_MAP:
        examples = list(PCAWG_BASE.keys())[:10]
        return (
            f"❌ No matching PCAWG study found for: {cancer_name}\n"
            f"Examples: {', '.join(examples)}\n"
            f"Try pcawg_available()"
        )

    study = PCAWG_STUDY_MAP[cancer_key]

    output_dir = "pcawg_data"
    os.makedirs(output_dir, exist_ok=True)

    rds_path = os.path.abspath(os.path.join(output_dir, f"{study}.rds"))
    maf_path = os.path.abspath(os.path.join(output_dir, f"{study}.maf"))

    ro.r(f"""
        suppressPackageStartupMessages(library(PCAWGmutations))
        suppressPackageStartupMessages(library(maftools))

        # use positional argument (no 'cohort=')
        maf_obj <- PCAWGmutations::pcawg_load("{study}")

        saveRDS(maf_obj, file = "{rds_path}")

        maf_tbl <- maf_obj@data
        write.table(
          maf_tbl,
          file = "{maf_path}",
          sep = "\\t",
          quote = FALSE,
          row.names = FALSE
        )
    """)

    return (
        f"✅ PCAWG {study} loaded.\n"
        f"📦 RDS saved: {rds_path}\n"
        f"📄 MAF saved: {maf_path}"
    )

@mcp.tool()
def plot_cooncoplot(
    tcga_rds_path: str | None = None,
    user_maf_path: str | None = None,
    user_maf_path2: str | None = None,
    output_dir: str = "outputs",
    genes: list[str] | None = None,
    clinicalFeatures1: list[str] | None = None,
    clinicalFeatures2: list[str] | None = None,
    annotationColor1: dict[str, str] | None = None,
    annotationColor2: dict[str, str] | None = None,
    sortByAnnotation1: bool = False,
    sortByAnnotation2: bool = False,
    sampleOrder1: list[str] | None = None,
    sampleOrder2: list[str] | None = None,
    additionalFeature1: list[str] | None = None,
    additionalFeaturePch1: int = 20,
    additionalFeatureCol1: str = "white",
    additionalFeatureCex1: float = 0.9,
    additionalFeature2: list[str] | None = None,
    additionalFeaturePch2: int = 20,
    additionalFeatureCol2: str = "white",
    additionalFeatureCex2: float = 0.9,
    sepwd_genes1: float = 0.5,
    sepwd_samples1: float = 0.5,
    sepwd_genes2: float = 0.5,
    sepwd_samples2: float = 0.5,
    colors: dict[str, str] | None = None,
    removeNonMutated: bool = True,
    anno_height: float = 2,
    legend_height: float = 4,
    geneNamefont: float = 0.8,
    showSampleNames: bool = False,
    SampleNamefont: float = 0.5,
    barcode_mar: float = 1,
    outer_mar: float = 3,
    gene_mar: float = 1,
    legendFontSize: float = 1.2,
    titleFontSize: float = 1.5,
    keepGeneOrder: bool = False,
    bgCol: str = "#CCCCCC",
    borderCol: str = "white",
    img_width: int = 2600,
    img_height: int = 2000
) -> Image:
    """
    Generate a coOncoplot with full parameter customization
    for:
      - TCGA vs User MAF, or
      - User vs User MAF.
    """
    import os
    os.makedirs(output_dir, exist_ok=True)
    out_png = os.path.abspath(
        os.path.join(output_dir, "cooncoplot.png"))

    if tcga_rds_path is not None and user_maf_path2 is None:
        mode = "tcga_vs_user"
    elif tcga_rds_path is None and user_maf_path2 is not None:
        mode = "user_vs_user"
    else:
        return "❌ Please provide either (tcga_rds_path + user_maf_path) OR (user_maf_path + user_maf_path2)."

    to_r_vec = lambda x: (
        "NULL" if (x is None or len(x) == 0) else "c(" + ",".join([f'"{i}"' for i in x]) + ")"
    )
    to_r_list = lambda x: (
        "NULL" if (x is None or len(x) == 0) else (
            "list(" + ",".join([f'{k}="{v}"' for k, v in x.items()]) + ")"
        )
    )

    r_genes = to_r_vec(genes)
    r_cf1 = to_r_vec(clinicalFeatures1)
    r_cf2 = to_r_vec(clinicalFeatures2)
    r_ac1 = to_r_list(annotationColor1)
    r_ac2 = to_r_list(annotationColor2)
    r_samp1 = to_r_vec(sampleOrder1)
    r_samp2 = to_r_vec(sampleOrder2)
    r_af1 = to_r_vec(additionalFeature1)
    r_af2 = to_r_vec(additionalFeature2)
    r_colors = to_r_list(colors)

    r_removeNonMutated = "TRUE" if removeNonMutated else "FALSE"
    r_sort1 = "TRUE" if sortByAnnotation1 else "FALSE"
    r_sort2 = "TRUE" if sortByAnnotation2 else "FALSE"
    r_showNames = "TRUE" if showSampleNames else "FALSE"
    r_keepGeneOrder = "TRUE" if keepGeneOrder else "FALSE"

    ro.r(f"""
        library(maftools)

        # load datasets
        { 'm1 <- readRDS("'+tcga_rds_path+'")' if mode == "tcga_vs_user" else '' }
        { 'm2 <- maftools::read.maf("'+user_maf_path+'")' if mode == "tcga_vs_user" else '' }

        { 'm1 <- maftools::read.maf("'+user_maf_path+'")' if mode == "user_vs_user" else '' }
        { 'm2 <- maftools::read.maf("'+user_maf_path2+'")' if mode == "user_vs_user" else '' }

        png("{out_png}", width={img_width}, height={img_height}, res=300)

        maftools::coOncoplot(
            m1 = m1,
            m2 = m2,
            genes = {r_genes},
            m1Name = "{ 'TCGA' if mode=='tcga_vs_user' else 'Cohort1' }",
            m2Name = "{ 'User' if mode=='tcga_vs_user' else 'Cohort2' }",
            clinicalFeatures1 = {r_cf1},
            clinicalFeatures2 = {r_cf2},
            annotationColor1 = {r_ac1},
            annotationColor2 = {r_ac2},
            sortByAnnotation1 = {r_sort1},
            sortByAnnotation2 = {r_sort2},
            sampleOrder1 = {r_samp1},
            sampleOrder2 = {r_samp2},
            additionalFeature1 = {r_af1},
            additionalFeaturePch1 = {additionalFeaturePch1},
            additionalFeatureCol1 = "{additionalFeatureCol1}",
            additionalFeatureCex1 = {additionalFeatureCex1},
            additionalFeature2 = {r_af2},
            additionalFeaturePch2 = {additionalFeaturePch2},
            additionalFeatureCol2 = "{additionalFeatureCol2}",
            additionalFeatureCex2 = {additionalFeatureCex2},
            sepwd_genes1 = {sepwd_genes1},
            sepwd_samples1 = {sepwd_samples1},
            sepwd_genes2 = {sepwd_genes2},
            sepwd_samples2 = {sepwd_samples2},
            colors = {r_colors},
            removeNonMutated = {r_removeNonMutated},
            anno_height = {anno_height},
            legend_height = {legend_height},
            geneNamefont = {geneNamefont},
            showSampleNames = {r_showNames},
            SampleNamefont = {SampleNamefont},
            barcode_mar = {barcode_mar},
            outer_mar = {outer_mar},
            gene_mar = {gene_mar},
            legendFontSize = {legendFontSize},
            titleFontSize = {titleFontSize},
            keepGeneOrder = {r_keepGeneOrder},
            bgCol = "{bgCol}",
            borderCol = "{borderCol}"
        )

        dev.off()
    """)

    return Image(path=out_png)
    
@mcp.tool()
def plot_cobarplot(
    tcga_rds_path: str | None = None,
    user_maf_path: str | None = None,
    user_maf_path2: str | None = None,
    output_dir: str = "outputs",
    genes: list[str] | None = None,
    orderBy: str | None = None,
    m1Name: str | None = None,
    m2Name: str | None = None,
    colors: list[str] | None = None,
    normalize: bool = True,
    yLims: list[float] | None = None,
    borderCol: str = "gray",
    titleSize: float = 1,
    geneSize: float = 0.8,
    showPct: bool = True,
    pctSize: float = 0.7,
    axisSize: float = 0.8,
    legendTxtSize: float = 1,
    img_width: int = 2600,
    img_height: int = 2000
) -> Image:
    """
    Draw two barplots side by side for cohort comparision:
      - TCGA vs User
      - User vs User
    """
    import os
    os.makedirs(output_dir, exist_ok=True)
    out_png = os.path.abspath(
        os.path.join(output_dir, "coBarplot.png"))

    if tcga_rds_path is not None and user_maf_path2 is None:
        mode = "tcga_vs_user"
    elif tcga_rds_path is None and user_maf_path2 is not None:
        mode = "user_vs_user"
    else:
        return "❌ Please provide either (tcga_rds_path + user_maf_path) OR (user_maf_path + user_maf_path2)."

    def r_vec(x):
        if not x:
            return "NULL"
        return "c(" + ",".join([f'"{v}"' for v in x]) + ")"

    r_genes = r_vec(genes)
    r_colors = r_vec(colors)
    r_yLims = "NULL" if not yLims else "c(" + ",".join(map(str, yLims)) + ")"

    r_orderBy = "NULL" if orderBy is None else f'"{orderBy}"'
    r_m1Name = "NULL" if m1Name is None else f'"{m1Name}"'
    r_m2Name = "NULL" if m2Name is None else f'"{m2Name}"'

    r_showPct = "TRUE" if showPct else "FALSE"
    r_normalize = "TRUE" if normalize else "FALSE"

    ro.r(f"""
        library(maftools)

        # Load m1 and m2 according to mode
        { 'm1 <- readRDS("'+tcga_rds_path+'")' if mode=='tcga_vs_user' else 'm1 <- maftools::read.maf("'+user_maf_path+'")' }
        { 'm2 <- maftools::read.maf("'+user_maf_path+'")' if mode=='tcga_vs_user' else 'm2 <- maftools::read.maf("'+user_maf_path2+'")' }

        png("{out_png}", width={img_width}, height={img_height}, res=300)

        coBarplot(
            m1 = m1,
            m2 = m2,
            genes = {r_genes},
            orderBy = {r_orderBy},
            m1Name = { r_m1Name if r_m1Name!='NULL' else '"TCGA"' if mode=='tcga_vs_user' else '"Cohort1"' },
            m2Name = { r_m2Name if r_m2Name!='NULL' else '"User"' if mode=='tcga_vs_user' else '"Cohort2"' },
            colors = {r_colors},
            normalize = {r_normalize},
            yLims = {r_yLims},
            borderCol = "{borderCol}",
            titleSize = {titleSize},
            geneSize = {geneSize},
            showPct = {r_showPct},
            pctSize = {pctSize},
            axisSize = {axisSize},
            legendTxtSize = {legendTxtSize}
        )

        dev.off()
    """)

    return Image(path=out_png)
    
@mcp.tool()
def plot_lollipopPlot2(
    tcga_rds_path: str | None = None,
    user_maf_path: str | None = None,
    user_maf_path2: str | None = None,
    gene: str = "",
    output_dir: str = "outputs",
    AACol1: str | None = None,
    AACol2: str | None = None,
    labPosAngle: float = 0,
    labPosSize: float = 1.2,
    refSeqID: str | None = None,
    proteinID: str | None = None,
    colors: list[str] | None = None,
    alpha: float = 1,
    axisTextSize: list[float] | None = None,
    pointSize: float = 1.2,
    roundedRect: bool = True,
    showDomainLabel: bool = True,
    domainBorderCol: str = "black",
    domainLabelSize: float = 1.2,
    legendTxtSize: float = 1.2,
    verbose: bool = True,
    img_width: int = 2600,
    img_height: int = 2000
) -> Image:
    """
    Generate a lollipopPlot2 comparing:
      - TCGA vs User MAF (if tcga_rds_path provided)
      - User vs User MAF (if user_maf_path2 provided)
    """
    import os

    if gene.strip() == "":
        return "❌ ERROR: You must specify a gene for lollipopPlot2."

    os.makedirs(output_dir, exist_ok=True)

    out_png = os.path.abspath(os.path.join(output_dir, f"lollipop_{gene}.png"))

    if tcga_rds_path is not None and user_maf_path2 is None:
        mode = "tcga_vs_user"
    elif tcga_rds_path is None and user_maf_path2 is not None:
        mode = "user_vs_user"
    else:
        return "❌ Please provide either (tcga_rds_path + user_maf_path) OR (user_maf_path + user_maf_path2)."

    to_r_vec = lambda x: "NULL" if (x is None or len(x) == 0) else \
        "c(" + ",".join([f'"{i}"' for i in x]) + ")"
    to_r_num_vec = lambda x: "NULL" if (x is None or len(x) == 0) else \
        "c(" + ",".join([str(i) for i in x]) + ")"
    to_r_bool = lambda x: "TRUE" if x else "FALSE"

    r_AACol1 = "NULL" if AACol1 is None else f'"{AACol1}"'
    r_AACol2 = "NULL" if AACol2 is None else f'"{AACol2}"'

    r_refSeqID = "NULL" if refSeqID is None else f'"{refSeqID}"'
    r_proteinID = "NULL" if proteinID is None else f'"{proteinID}"'

    r_colors = to_r_vec(colors)
    r_axisTextSize = to_r_num_vec(axisTextSize)

    r_roundedRect = to_r_bool(roundedRect)
    r_showDomainLabel = to_r_bool(showDomainLabel)
    r_verbose = to_r_bool(verbose)

    ro.r(f"""
        library(maftools)

        { 'm1 <- readRDS("'+tcga_rds_path+'")' if mode=='tcga_vs_user' else '' }
        { 'm2 <- maftools::read.maf("'+user_maf_path+'")' if mode=='tcga_vs_user' else '' }

        { 'm1 <- maftools::read.maf("'+user_maf_path+'")' if mode=='user_vs_user' else '' }
        { 'm2 <- maftools::read.maf("'+user_maf_path2+'")' if mode=='user_vs_user' else '' }

        png("{out_png}", width={img_width}, height={img_height}, res=300)

        maftools::lollipopPlot2(
            m1 = m1,
            m2 = m2,
            gene = "{gene}",

            AACol1 = {r_AACol1},
            AACol2 = {r_AACol2},

            m1_name = "{ 'TCGA' if mode=='tcga_vs_user' else 'Cohort1' }",
            m2_name = "{ 'User' if mode=='tcga_vs_user' else 'Cohort2' }",

            refSeqID = {r_refSeqID},
            proteinID = {r_proteinID},

            labPosAngle = {labPosAngle},
            labPosSize = {labPosSize},

            colors = {r_colors},
            alpha = {alpha},

            axisTextSize = {r_axisTextSize},
            pointSize = {pointSize},

            roundedRect = {r_roundedRect},
            showDomainLabel = {r_showDomainLabel},

            domainBorderCol = "{domainBorderCol}",
            domainLabelSize = {domainLabelSize},

            legendTxtSize = {legendTxtSize},

            verbose = {r_verbose}
        )

        dev.off()
    """)

    return Image(path=out_png)

@mcp.tool()
def compare_maf_forestplot(
    tcga_rds_path: str | None = None,
    user_maf_path: str | None = None,
    user_maf_path2: str | None = None,
    output_dir: str = "outputs",
    geneFontSize: float = 1.0,
    titleSize: float = 1.5,
    lineWidth: float = 1.5,
    minMut: int = 5,
    pVal: float = 0.1,
    img_width: int = 2600,
    img_height: int = 2000
) -> Image:
    """
    Compare two cohorts using mafCompare and create a forestPlot.
    Supports:
      - TCGA vs User
      - User vs User
    """
    import os

    os.makedirs(output_dir, exist_ok=True)

    forest_path = os.path.abspath(
        os.path.join(output_dir, "forestPlot.png")
    )

    if tcga_rds_path and not user_maf_path2:
        if not os.path.exists(tcga_rds_path):
            raise FileNotFoundError(tcga_rds_path)
        if not user_maf_path or not os.path.exists(user_maf_path):
            raise FileNotFoundError(user_maf_path)

        mode = "tcga_vs_user"

    elif user_maf_path and user_maf_path2:
        if not os.path.exists(user_maf_path):
            raise FileNotFoundError(user_maf_path)
        if not os.path.exists(user_maf_path2):
            raise FileNotFoundError(user_maf_path2)

        mode = "user_vs_user"

    else:
        raise ValueError(
            "Provide either:\n"
            "  - tcga_rds_path + user_maf_path\n"
            "OR\n"
            "  - user_maf_path + user_maf_path2"
        )

    ro.r(f"""
        library(maftools)

        # Load cohorts
        {"m1 <- readRDS("+repr(tcga_rds_path)+"); m2 <- maftools::read.maf("+repr(user_maf_path)+")" if mode=="tcga_vs_user"
        else "m1 <- maftools::read.maf("+repr(user_maf_path)+"); m2 <- maftools::read.maf("+repr(user_maf_path2)+")"}

        # Run mafCompare
        cmp <- mafCompare(
            m1 = m1,
            m2 = m2,
            m1Name = "{'TCGA' if mode=='tcga_vs_user' else 'Cohort1'}",
            m2Name = "{'User' if mode=='tcga_vs_user' else 'Cohort2'}",
            minMut = {minMut}
        )

        # Create forest plot
        png("{forest_path}", width={img_width}, height={img_height}, res=300)
        forestPlot(
            mafCompareRes = cmp,
            pVal = {pVal},
            geneFontSize = {geneFontSize},
            titleSize = {titleSize},
            lineWidth = {lineWidth}
        )
        dev.off()
    """)

    return Image(path=forest_path)

@mcp.tool()
def trinucleotide_matrix(
    maf_path: str,
    ref_genome: str | None = None,
    prefix: str | None = None,
    add: bool = True,
    ignoreChr: list[str] | None = None,
    useSyn: bool = True,
    fn: str | None = None,
    output_dir: str = "outputs"
) -> str:
    """
    Extract single 5' and 3' bases flanking the mutated site for de-novo signature analysis.
    Also estimates APOBEC enrichment scores.
    """
    import os
    os.makedirs(output_dir, exist_ok=True)

    r_add = "TRUE" if add else "FALSE"
    r_useSyn = "TRUE" if useSyn else "FALSE"
    r_prefix = "NULL" if prefix is None else f'"{prefix}"'
    r_fn = "NULL" if fn is None else f'"{fn}"'
    r_ref = "NULL" if ref_genome is None else f'"{ref_genome}"'
    r_ignoreChr = "NULL" if (ignoreChr is None or len(ignoreChr) == 0) else "c(" + ",".join([f'"{c}"' for c in ignoreChr]) + ")"

    mat_rds = os.path.abspath(os.path.join(output_dir, "trinuc_matrix.rds"))

    ro.r(f"""
        library(maftools)
        maf_obj <- read.maf("{maf_path}")

        mat <- trinucleotideMatrix(
            maf = maf_obj,
            ref_genome = {r_ref},
            prefix = {r_prefix},
            add = {r_add},
            ignoreChr = {r_ignoreChr},
            useSyn = {r_useSyn},
            fn = {r_fn}
        )

        saveRDS(mat, file="{mat_rds}")
    """)

    return f"🧬 trinucleotide matrix saved: {mat_rds}"
      
@mcp.tool()
def estimate_signatures(
    trinuc_matrix_rds: str,
    nMin: int = 2,
    nTry: int = 6,
    nrun: int = 10,
    pConstant: float | None = None,
    verbose: bool = True,
    output_dir: str = "outputs"
) -> str:
    """
		Estimate number of signatures based on cophenetic correlation metric.
    """
    import os
    os.makedirs(output_dir, exist_ok=True)

    r_verbose = "TRUE" if verbose else "FALSE"
    r_pConstant = "NULL" if pConstant is None else f"{pConstant}"

    est_rds = os.path.abspath(os.path.join(output_dir, "estimateSignatures.rds"))

    ro.r(f"""
        library(maftools)
        library(NMF)

        mat <- readRDS("{trinuc_matrix_rds}")

        est <- estimateSignatures(
            mat,
            nMin = {nMin},
            nTry = {nTry},
            nrun = {nrun},
            pConstant = {r_pConstant},
            verbose = {r_verbose},
            plotBestFitRes = FALSE
        )

        saveRDS(est, file="{est_rds}")
    """)

    return f"🔍 estimateSignatures completed: {est_rds}"

@mcp.tool()
def plot_cophenetic(
    estimateSignatures_rds: str,
    output_dir: str = "outputs",
    img_width: int = 2600,
    img_height: int = 2000
) -> Image:
    """
    Draw an elbow plot of cophenetic correlation metric.
    """
    import os
    os.makedirs(output_dir, exist_ok=True)

    out_png = os.path.abspath(os.path.join(output_dir, "cophenetic_plot.png"))

    ro.r(f"""
        library(maftools)

        est <- readRDS("{estimateSignatures_rds}")

        png("{out_png}", width={img_width}, height={img_height}, res=300)
        plotCophenetic(res = est, bestFit = NULL)
        dev.off()
    """)

    return Image(path=out_png)


@mcp.tool()
def extract_signatures(
    trinuc_matrix_rds: str,
    n: int,
    parallel: int = 4,
    pConstant: float | None = None,
    output_dir: str = "outputs"
) -> str:
    """
    Decompose a matrix of 96 substitution classes into n signatures.
    """
    import os
    os.makedirs(output_dir, exist_ok=True)

    r_pConstant = "NULL" if pConstant is None else f"{pConstant}"

    full_rds = os.path.abspath(os.path.join(output_dir, "extractSignatures.rds"))
    sig_rds = os.path.abspath(os.path.join(output_dir, "signatures.rds"))
    contrib_rds = os.path.abspath(os.path.join(output_dir, "contributions.rds"))

    ro.r(f"""
        library(maftools)
        library(NMF)

        mat <- readRDS("{trinuc_matrix_rds}")

        ext <- extractSignatures(
            mat,
            n = {n},
            plotBestFitRes = FALSE,
            parallel = {parallel},
            pConstant = {r_pConstant}
        )

        saveRDS(ext, file="{full_rds}")
        saveRDS(ext$signatures, file="{sig_rds}")
        saveRDS(ext$contributions, file="{contrib_rds}")
    """)

    return (
        "🧬 extractSignatures completed.\n"
        f"📁 Full: {full_rds}\n"
        f"📁 Signatures: {sig_rds}\n"
        f"📁 Contributions: {contrib_rds}"
    )

@mcp.tool()
def compare_signatures(
    extractSignatures_rds: str,
    sig_db: str = "legacy",
    verbose: bool = True,
    output_dir: str = "outputs"
) -> str:
    """
    Compare identified de novo mutational signatures against known COSMIC signatures.
    """
    import os
    os.makedirs(output_dir, exist_ok=True)

    r_verbose = "TRUE" if verbose else "FALSE"

    comp_rds = os.path.abspath(os.path.join(output_dir, "compareSignatures.rds"))
    sim_txt = os.path.abspath(os.path.join(output_dir, "similarity_matrix.txt"))

    ro.r(f"""
        library(maftools)

        ext <- readRDS("{extractSignatures_rds}")

        comp <- compareSignatures(
            nmfRes = ext,
            sig_db = "{sig_db}",
            verbose = {r_verbose}
        )

        saveRDS(comp, file="{comp_rds}")
        write.table(comp$similarity, file="{sim_txt}", sep="\\t", quote=FALSE)
    """)

    return (
        "🔬 compareSignatures finished.\n"
        f"📁 Result RDS: {comp_rds}\n"
        f"📄 Similarity matrix: {sim_txt}"
    )
    
@mcp.tool()
def plot_signatures(
    extractSignatures_rds: str,
    contributions: bool = False,
    font_size: float = 1.2,
    show_title: bool = True,
    sig_db: str = "legacy",
    axis_lwd: int = 2,
    title_size: float = 0.9,
    show_barcodes: bool = False,
    yaxisLim: float = 0.3,
    output_dir: str = "outputs",
    img_width: int = 2600,
    img_height: int = 2000
) -> Image:
    """
    Plot extracted mutational signatures derived from NMF decomposition.
    """
    import os
    os.makedirs(output_dir, exist_ok=True)

    out_png = os.path.abspath(os.path.join(output_dir, "signature_profiles.png"))

    r_contrib = "TRUE" if contributions else "FALSE"
    r_title = "TRUE" if show_title else "FALSE"
    r_barcodes = "TRUE" if show_barcodes else "FALSE"

    ro.r(f"""
        library(maftools)

        ext <- readRDS("{extractSignatures_rds}")

        png("{out_png}", width={img_width}, height={img_height}, res=300)
        plotSignatures(
            nmfRes = ext,
            contributions = {r_contrib},
            font_size = {font_size},
            show_title = {r_title},
            sig_db = "{sig_db}",
            axis_lwd = {axis_lwd},
            title_size = {title_size},
            show_barcodes = {r_barcodes},
            yaxisLim = {yaxisLim}
        )
        dev.off()
    """)

    return Image(path=out_png)

@mcp.tool()
def clinical_enrichment(
    maf_path: str,
    clinicalFeature: str,
    clinicalData: str | None = None,  
    annotationDat: str | None = None,
    minMut: int = 5,
    useCNV: bool = True,
    pVal: float = 0.05,
    cols: list[str] | None = None,
    annoFontSize: float = 0.8,
    geneFontSize: float = 0.8,
    legendFontSize: float = 0.8,
    showTitle: bool = True,
    output_dir: str = "outputs"
) -> Image:
    """
    Performs mutational enrichment analysis for a given clinical feature.
    """
    import os

    if clinicalFeature.strip() == "":
        raise ValueError("clinicalFeature cannot be empty.")

    if not os.path.exists(maf_path):
        raise FileNotFoundError(f"File not found: {maf_path}")

    if clinicalData is not None and not os.path.exists(clinicalData):
        raise FileNotFoundError(f"clinicalData not found: {clinicalData}")

    os.makedirs(output_dir, exist_ok=True)

    output_table = os.path.abspath(os.path.join(output_dir, "clinical_enrichment_results.txt"))
    output_plot  = os.path.abspath(os.path.join(output_dir, "clinical_enrichment_plot.png"))

    r_useCNV = "TRUE" if useCNV else "FALSE"
    r_anno = "NULL" if annotationDat is None else f'"{annotationDat}"'
    r_showTitle = "TRUE" if showTitle else "FALSE"

    if not cols:
        r_cols = "NULL"
    else:
        r_cols = "c(" + ",".join([f'"{c}"' for c in cols]) + ")"

    # loader: rds -> readRDS, else read.maf
    maf_loader = (
        f'readRDS("{maf_path}")'
        if maf_path.lower().endswith(".rds")
        else f'maftools::read.maf("{maf_path}")'
    )

    # clinical table loader (tsv/csv)
    # - assume first column is Tumor_Sample_Barcode if not explicitly named
    r_clin = "NULL"
    if clinicalData is not None:
        # choose sep by extension (simple heuristic)
        ext = os.path.splitext(clinicalData)[1].lower()
        sep = "," if ext in [".csv"] else "\t"
        r_clin = f'read.table("{clinicalData}", header=TRUE, sep="{sep}", stringsAsFactors=FALSE, check.names=FALSE)'

    ro.r(f"""
        library(maftools)

        maf_obj <- {maf_loader}

        # ---- Attach clinical data if provided or missing ----
        if (!is.null({r_clin})) {{
            clin <- {r_clin}

            # Try to ensure Tumor_Sample_Barcode column exists
            if (!("Tumor_Sample_Barcode" %in% colnames(clin))) {{
                colnames(clin)[1] <- "Tumor_Sample_Barcode"
            }}

            maf_obj@clinical.data <- clin
        }}

        if (is.null(maf_obj@clinical.data) || nrow(maf_obj@clinical.data) == 0) {{
            stop("No clinical data found in maf_obj@clinical.data. Provide an .rds MAF with clinical data or pass clinicalData table.")
        }}

        if (!("{clinicalFeature}" %in% colnames(maf_obj@clinical.data))) {{
            stop(paste0("clinicalFeature not found in clinical.data: {clinicalFeature}. Available columns: ",
                        paste(colnames(maf_obj@clinical.data), collapse=", ")))
        }}

        enrich_res <- clinicalEnrichment(
            maf = maf_obj,
            clinicalFeature = "{clinicalFeature}",
            annotationDat = {r_anno},
            minMut = {minMut},
            useCNV = {r_useCNV}
        )

        write.table(
            enrich_res$groupwise_comparision,
            file = "{output_table}",
            sep = "\\t",
            quote = FALSE,
            row.names = FALSE
        )

        png("{output_plot}", width = 1800, height = 1400, res = 300)

        plotEnrichmentResults(
            enrich_res = enrich_res,
            pVal = {pVal},
            cols = {r_cols},
            annoFontSize = {annoFontSize},
            geneFontSize = {geneFontSize},
            legendFontSize = {legendFontSize},
            showTitle = {r_showTitle}
        )

        dev.off()
    """)

    return Image(path=output_plot)

@mcp.tool()
def signature_enrichment(
    maf_rds: str,
    sig_res_rds: str,
    minMut: int = 5,
    useCNV: bool = False,
    output_dir: str = "outputs"
) -> Image:
    """
    Performs mutational signature enrichment analysis and saves the plot.
    """
    import os

    os.makedirs(output_dir, exist_ok=True)

    plot_path = os.path.abspath(
        os.path.join(output_dir, "signature_enrichment.png")
    )

    r_useCNV = "TRUE" if useCNV else "FALSE"

    ro.r(f"""
        library(maftools)

        maf_obj <- readRDS("{maf_rds}")
        sig_res <- readRDS("{sig_res_rds}")
        
        png("{plot_path}", width = 1800, height = 1400, res = 300)

        signatureEnrichment(
            maf = maf_obj,
            sig_res = sig_res,
            minMut = {minMut},
            useCNV = {r_useCNV}
        )

        dev.off()
    """)

    return Image(path=plot_path)
    
@mcp.tool()
def drug_interactions(
    maf_path: str,
    top: int = 20,
    genes: list[str] | None = None,
    plotType: str = "bar",
    drugs: bool = False,
    fontSize: float = 0.8,
    output_dir: str = "outputs",
    img_width: int = 2600,
    img_height: int = 2000
) -> Image:
    """
    Checks for drug-gene interactions and druggable categories.
    """
    import os
    os.makedirs(output_dir, exist_ok=True)

    r_genes = "NULL" if (genes is None or len(genes) == 0) else "c(" + ",".join([f'"{g}"' for g in genes]) + ")"
    r_drugs = "TRUE" if drugs else "FALSE"

    out_png = os.path.abspath(os.path.join(output_dir, "drug_interactions.png"))

    ro.r(f"""
        library(maftools)

        maf_obj <- read.maf("{maf_path}")
        png("{out_png}", width={img_width}, height={img_height}, res=300)
        drugInteractions(
            maf = maf_obj,
            top = {top},
            genes = {r_genes},
            plotType = "{plotType}",
            drugs = {r_drugs},
            fontSize = {fontSize}
        )

        dev.off()
    """)

    return Image(path=out_png)

@mcp.tool()
def filter_maf(
    maf_path: str,
    genes: bool | list[str] = True,
    tsb: list[str] | None = None,
    isTCGA: bool = False,
    output_dir: str = "outputs"
) -> str:
    """
    Filter MAF by genes or Tumor Sample Barcode (tsb).

    Outputs:
        - filtered_maf.rds  : filtered MAF object
        - filtered_maf.tsv  : filtered mutation table
    """
    import os
    os.makedirs(output_dir, exist_ok=True)

    if genes is True:
        r_genes = "TRUE"
    elif isinstance(genes, list) and len(genes) > 0:
        r_genes = "c(" + ",".join([f'"{g}"' for g in genes]) + ")"
    else:
        r_genes = "NULL"

    r_tsb = "NULL" if (tsb is None or len(tsb) == 0) else \
        "c(" + ",".join([f'"{s}"' for s in tsb]) + ")"

    r_isTCGA = "TRUE" if isTCGA else "FALSE"

    filtered_rds = os.path.abspath(os.path.join(output_dir, "filtered_maf.rds"))
    filtered_tsv = os.path.abspath(os.path.join(output_dir, "filtered_maf.tsv"))

    ro.r(f"""
        library(maftools)

        maf_obj <- read.maf("{maf_path}")

        filtered <- filterMaf(
            maf = maf_obj,
            genes = {r_genes},
            tsb = {r_tsb},
            isTCGA = {r_isTCGA}
        )

        saveRDS(filtered, file="{filtered_rds}")

        write.table(
            filtered@data,
            file="{filtered_tsv}",
            sep="\\t",
            quote=FALSE,
            row.names=FALSE
        )
    """)

    return (
        "🧹 filterMaf completed.\n"
        f"📦 RDS: {filtered_rds}\n"
        f"📄 TSV: {filtered_tsv}"
    )
@mcp.tool()
def subset_maf(
    maf_path: str,
    tsb: list[str] | None = None,
    genes: list[str] | None = None,
    query: str | None = None,
    clinQuery: str | None = None,
    ranges: list[str] | None = None,
    mult: str = "first",
    fields: list[str] | None = None,
    mafObj: bool = True,
    includeSyn: bool = True,
    isTCGA: bool = False,
    dropLevels: bool = True,
    restrictTo: str = "all",
    output_dir: str = "outputs"
) -> str:
    """
    Subset MAF using sample names, gene names, mutation conditions,
    clinical filters, genomic ranges, or custom queries.

    Outputs:
        - subset_maf.rds : Result as a MAF object / data.frame
        - subset_maf.tsv : Subset mutation table
    """
    import os
    os.makedirs(output_dir, exist_ok=True)

    r_tsb = "NULL" if (tsb is None or len(tsb) == 0) else "c(" + ",".join([f'"{s}"' for s in tsb]) + ")"
    r_genes = "NULL" if (genes is None or len(genes) == 0) else "c(" + ",".join([f'"{g}"' for g in genes]) + ")"
    r_ranges = "NULL" if (ranges is None or len(ranges) == 0) else "c(" + ",".join([f'"{r}"' for r in ranges]) + ")"
    r_fields = "NULL" if (fields is None or len(fields) == 0) else "c(" + ",".join([f'"{f}"' for f in fields]) + ")"

    r_query = "NULL" if query is None else f'"{query}"'
    r_clinQuery = "NULL" if clinQuery is None else f'"{clinQuery}"'

    r_mafObj = "TRUE" if mafObj else "FALSE"
    r_includeSyn = "TRUE" if includeSyn else "FALSE"
    r_isTCGA = "TRUE" if isTCGA else "FALSE"
    r_dropLevels = "TRUE" if dropLevels else "FALSE"

    subset_rds = os.path.abspath(os.path.join(output_dir, "subset_maf.rds"))
    subset_tsv = os.path.abspath(os.path.join(output_dir, "subset_maf.tsv"))

    ro.r(f"""
        library(maftools)

        maf_obj <- read.maf("{maf_path}")

        sub_maf <- subsetMaf(
            maf = maf_obj,
            tsb = {r_tsb},
            genes = {r_genes},
            query = {r_query},
            clinQuery = {r_clinQuery},
            ranges = {r_ranges},
            mult = "{mult}",
            fields = {r_fields},
            mafObj = {r_mafObj},
            includeSyn = {r_includeSyn},
            isTCGA = {r_isTCGA},
            dropLevels = {r_dropLevels},
            restrictTo = "{restrictTo}"
        )

        saveRDS(sub_maf, file="{subset_rds}")

        if (is(sub_maf, "MAF")) {{
            write.table(
                sub_maf@data,
                file="{subset_tsv}",
                sep="\\t",
                quote=FALSE,
                row.names=FALSE
            )
        }} else {{
            write.table(
                sub_maf,
                file="{subset_tsv}",
                sep="\\t",
                quote=FALSE,
                row.names=FALSE
            )
        }}
    """)

    return (
        "🔍 subsetMaf completed.\n"
        f"📦 RDS: {subset_rds}\n"
        f"📄 TSV: {subset_tsv}"
    )
    
@mcp.tool()
def genes_to_barcodes(
    maf_path: str,
    genes: list[str],
    justNames: bool = False,
    verbose: bool = True,
    output_dir: str = "outputs"
) -> str:
    """
    Extract Tumor Sample Barcodes where specified genes are mutated.

    Outputs:
        - genes_to_barcodes.rds  (R object for downstream MCP / R usage)
        - genes_to_barcodes.tsv  (structured table)
    """
    import os
    os.makedirs(output_dir, exist_ok=True)

    if not genes:
        raise ValueError("genes cannot be empty")

    r_genes = "c(" + ",".join([f'"{g}"' for g in genes]) + ")"
    r_justNames = "TRUE" if justNames else "FALSE"
    r_verbose = "TRUE" if verbose else "FALSE"

    rds_out = os.path.abspath(os.path.join(output_dir, "genes_to_barcodes.rds"))
    tsv_out = os.path.abspath(os.path.join(output_dir, "genes_to_barcodes.tsv"))

    ro.r(f"""
        library(maftools)

        maf_obj <- read.maf("{maf_path}")

        result <- genesToBarcodes(
            maf = maf_obj,
            genes = {r_genes},
            justNames = {r_justNames},
            verbose = {r_verbose}
        )

        # Save native R object
        saveRDS(result, file="{rds_out}")

        # Normalize to data.frame for TSV export
        if (is.character(result)) {{
            out_df <- data.frame(Tumor_Sample_Barcode = result)
        }} else {{
            out_df <- as.data.frame(result)
        }}

        write.table(
            out_df,
            file="{tsv_out}",
            sep="\\t",
            quote=FALSE,
            row.names=FALSE
        )
    """)

    return (
        "🧬 genesToBarcodes completed.\n"
        f"📦 RDS: {rds_out}\n"
        f"📄 TSV: {tsv_out}"
    )
    
    
@mcp.tool()
def genotype_matrix(
    maf_path: str,
    genes: list[str] | None = None,
    tsb: list[str] | None = None,
    includeSyn: bool = False,
    vafCol: str | None = None,
    vafCutoff: list[float] | None = None,
    output_dir: str = "outputs"
) -> str:
    """
    Generate a genotype matrix (genes x samples) from a MAF file.

    Output:
        - genotype_matrix.tsv (structured matrix table)
    """
    import os
    os.makedirs(output_dir, exist_ok=True)

    to_r_vec = lambda x: (
        "NULL" if (x is None or len(x) == 0) else "c(" + ",".join([f'"{i}"' for i in x]) + ")"
    )
    to_r_numeric_vec = lambda x: (
        "NULL" if (x is None or len(x) == 0) else "c(" + ",".join([str(i) for i in x]) + ")"
    )

    r_genes = to_r_vec(genes)
    r_tsb = to_r_vec(tsb)
    r_includeSyn = "TRUE" if includeSyn else "FALSE"
    r_vafCol = "NULL" if vafCol is None else f'"{vafCol}"'
    r_vafCutoff = to_r_numeric_vec(vafCutoff)

    out_tsv = os.path.abspath(os.path.join(output_dir, "genotype_matrix.tsv"))

    ro.r(f"""
        library(maftools)

        maf_obj <- read.maf("{maf_path}")

        gmat <- genotypeMatrix(
            maf = maf_obj,
            genes = {r_genes},
            tsb = {r_tsb},
            includeSyn = {r_includeSyn},
            vafCol = {r_vafCol},
            vafCutoff = {r_vafCutoff}
        )

        write.table(
            gmat,
            file="{out_tsv}",
            sep="\\t",
            quote=FALSE,
            row.names=TRUE,
            col.names=NA
        )
    """)

    return f"🧬 Genotype matrix table saved: {out_tsv}"
    
@mcp.tool()
def get_clinical_data(
    maf_path: str,
    output_dir: str = "outputs"
) -> str:
    """
    Extract clinical annotation table from a MAF object or TCGA RDS object.
    """
    import os
    os.makedirs(output_dir, exist_ok=True)

    out_tsv = os.path.abspath(os.path.join(output_dir, "clinical_data.tsv"))

    is_rds = maf_path.lower().endswith(".rds")
    r_load = f'readRDS("{maf_path}")' if is_rds else f'read.maf("{maf_path}")'

    ro.r(f"""
        library(maftools)

        maf_obj <- {r_load}

        clin <- getClinicalData(maf_obj)

        write.table(
            clin,
            file="{out_tsv}",
            sep="\\t",
            quote=FALSE,
            row.names=FALSE
        )
    """)

    return f"🩺 Clinical data table saved: {out_tsv}"

@mcp.tool()
def get_fields(
    maf_path: str,
    output_dir: str = "outputs"
) -> str:
    """
    Retrieve all available fields/columns present in the MAF data table.

    Output:
        - maf_fields.tsv
    """
    import os
    os.makedirs(output_dir, exist_ok=True)

    out_tsv = os.path.abspath(os.path.join(output_dir, "maf_fields.tsv"))

    ro.r(f"""
        library(maftools)

        maf_obj <- read.maf("{maf_path}")

        fields <- getFields(maf_obj)

        write.table(
            data.frame(Field = fields),
            file="{out_tsv}",
            sep="\\t",
            quote=FALSE,
            row.names=FALSE,
            col.names=TRUE
        )
    """)

    return f"📑 MAF fields table saved: {out_tsv}"

@mcp.tool()
def get_gene_summary(
    maf_path: str | None = None,
    gistic_rds_path: str | None = None,
    output_dir: str = "outputs"
) -> str:
    """
    Generate gene-level summary statistics from either:
      - a MAF file (SNV/INDEL summary via maftools), or
      - a GISTIC RDS object.

    Output:
        - gene_summary.tsv
    """
    import os
    os.makedirs(output_dir, exist_ok=True)

    if maf_path is None and gistic_rds_path is None:
        return "❌ Please provide either maf_path or gistic_rds_path."

    if maf_path is not None and gistic_rds_path is not None:
        return "❌ Please provide only ONE input: either maf_path or gistic_rds_path."

    out_tsv = os.path.abspath(os.path.join(output_dir, "gene_summary.tsv"))

    if maf_path is not None:
        ro.r(f"""
            library(maftools)

            maf_obj <- read.maf("{maf_path}")

            gene_summary <- getGeneSummary(maf_obj)

            write.table(
                gene_summary,
                file="{out_tsv}",
                sep="\\t",
                quote=FALSE,
                row.names=FALSE
            )
        """)

        return (
            "🧬 MAF gene summary table generated\n"
            f"📄 Output: {out_tsv}"
        )

    ro.r(f"""
        library(TCGAgistic)

        gistic_obj <- readRDS("{gistic_rds_path}")

        gene_summary <- getGeneSummary(gistic_obj)

        write.table(
            gene_summary,
            file="{out_tsv}",
            sep="\\t",
            quote=FALSE,
            row.names=FALSE
        )
    """)

    return (
        "📊 GISTIC CNV gene summary table generated\n"
        f"📄 Output: {out_tsv}"
    )
        
# ----------------------------
# TCGA GISTIC mappings
# ----------------------------
TCGA_GISTIC_BASE: Dict[str, str] = {
    "ACC": "Adrenocortical carcinoma",
    "BLCA": "Bladder urothelial carcinoma",
    "BRCA": "Breast invasive carcinoma",
    "CESC": "Cervical and endocervical cancers",
    "CHOL": "Cholangiocarcinoma",
    "COAD": "Colon adenocarcinoma",
    "COADREAD": "Colorectal adenocarcinoma",
    "DLBC": "Lymphoid Neoplasm Diffuse Large B-cell Lymphoma",
    "ESCA": "Esophageal carcinoma",
    "GBM": "Glioblastoma multiforme",
    "GBMLGG": "Glioma",
    "HNSC": "Head and Neck squamous cell carcinoma",
    "KICH": "Kidney Chromophobe",
    "KIPAN": "Pan-kidney cohort (KICH+KIRC+KIRP)",
    "KIRC": "Kidney renal clear cell carcinoma",
    "KIRP": "Kidney renal papillary cell carcinoma",
    "LAML": "Acute Myeloid Leukemia",
    "LGG": "Brain Lower Grade Glioma",
    "LIHC": "Liver hepatocellular carcinoma",
    "LUAD": "Lung adenocarcinoma",
    "LUSC": "Lung squamous cell carcinoma",
    "MESO": "Mesothelioma",
    "OV": "Ovarian serous cystadenocarcinoma",
    "PAAD": "Pancreatic adenocarcinoma",
    "PCPG": "Pheochromocytoma and Paraganglioma",
    "PRAD": "Prostate adenocarcinoma",
    "READ": "Rectum adenocarcinoma",
    "SARC": "Sarcoma",
    "SKCM": "Skin Cutaneous Melanoma",
    "STAD": "Stomach adenocarcinoma",
    "STES": "Stomach and Esophageal carcinoma",
    "TGCT": "Testicular Germ Cell Tumors",
    "THCA": "Thyroid carcinoma",
    "THYM": "Thymoma",
    "UCEC": "Uterine Corpus Endometrial Carcinoma",
    "UCS": "Uterine Carcinosarcoma",
    "UVM": "Uveal Melanoma",
}

TCGA_GISTIC_STUDY_MAP: Dict[str, str] = {}
for abbr, fullname in TCGA_GISTIC_BASE.items():
    TCGA_GISTIC_STUDY_MAP[abbr.lower()] = abbr
    TCGA_GISTIC_STUDY_MAP[fullname.lower()] = abbr
    TCGA_GISTIC_STUDY_MAP[f"{abbr.lower()} - {fullname.lower()}"] = abbr
    
@mcp.tool()
def tcga_available_gistic() -> str:
    """
    List available TCGA GISTIC studies.
    """
    lines = [f"{abbr} - {fullname}" for abbr, fullname in TCGA_GISTIC_BASE.items()]
    return "📊 Available TCGA GISTIC studies:\n" + "\n".join(lines)
    
@mcp.tool()
def load_tcga_gistic(
    cancer_name: str,
    copy_number_level: str = "all",
    output_dir: str = "tcga_gistic"
) -> str:
    """
    Load TCGA GISTIC CNV dataset using TCGAgistic.

    Args:
        cancer_name: TCGA cohort abbreviation or full cancer name
        copy_number_level: one of "all", "deep", "shallow"
        output_dir: directory to save the loaded RDS object

    Returns:
        Status message with saved file path.
    """
    import os

    cancer_key = cancer_name.lower().strip()
    level = copy_number_level.lower().strip()

    if level not in {"all", "deep", "shallow"}:
        return (
            f"❌ Invalid copy_number_level: {copy_number_level}\n"
            "Allowed values: all, deep, shallow"
        )

    if cancer_key not in TCGA_GISTIC_STUDY_MAP:
        return f"❌ No matching TCGA GISTIC study found for: {cancer_name}"

    cohort = TCGA_GISTIC_STUDY_MAP[cancer_key]

    os.makedirs(output_dir, exist_ok=True)
    output_path = os.path.join(output_dir, f"{cohort}_gistic_{level}.rds")

    ro.r(f"""
        library(TCGAgistic)

        gistic_obj <- tcga_gistic_load(
            cohort = "{cohort}",
            source = "Firehose",
            cnLevel = "{level}",
            verbose = FALSE
        )

        saveRDS(gistic_obj, file = "{output_path}")
    """)

    return (
        "✅ TCGA GISTIC data loaded successfully\n"
        f"🧬 Cohort: {cohort}\n"
        f"📊 Copy number level: {level}\n"
        f"📁 Saved to: {os.path.abspath(output_path)}"
    )
    

@mcp.tool()
def get_sample_summary(
    maf_path: str | None = None,
    gistic_rds_path: str | None = None,
    output_dir: str = "outputs"
) -> str:
    """
    Extract per-sample summary statistics from either:
      - a MAF object (mutation summary via maftools::getSampleSummary), or
      - a GISTIC object (CNV summary via TCGAgistic::getSampleSummary).

    Output:
        - sample_summary.tsv (structured data table)
    """
    import os
    os.makedirs(output_dir, exist_ok=True)

    if maf_path is None and gistic_rds_path is None:
        return "❌ Please provide either maf_path or gistic_rds_path."

    if maf_path is not None and gistic_rds_path is not None:
        return "❌ Please provide only ONE input: either maf_path or gistic_rds_path."

    out_tsv = os.path.abspath(os.path.join(output_dir, "sample_summary.tsv"))

    if maf_path is not None:
        ro.r(f"""
            library(maftools)

            maf_obj <- read.maf("{maf_path}")
            sample_summary <- getSampleSummary(maf_obj)

            write.table(
                sample_summary,
                file="{out_tsv}",
                sep="\\t",
                quote=FALSE,
                row.names=FALSE
            )
        """)

        return (
            "🧬 MAF sample summary table generated\n"
            f"📄 Output: {out_tsv}"
        )

    ro.r(f"""
        library(TCGAgistic)
        library(maftools)
        gistic_obj <- readRDS("{gistic_rds_path}")
        sample_summary <- getSampleSummary(gistic_obj)

        write.table(
            sample_summary,
            file="{out_tsv}",
            sep="\\t",
            quote=FALSE,
            row.names=FALSE
        )
    """)

    return (
        "📊 GISTIC CNV sample summary table generated\n"
        f"📄 Output: {out_tsv}"
    )
        
@mcp.tool()
def gistic_bubble_plot(
    gistic_rds_path: str,
    color: list[str] | None = None,
    markBands: list[str] | None = None,
    fdrCutOff: float = 0.1,
    log_y: bool = True,
    txtSize: float = 3,
    output_dir: str = "outputs",
    img_width: int = 2600,
    img_height: int = 2000
) -> Image:
    """
    Plots significantly altered cytobands as a function of number samples in which it is altered and number genes it contains. Size of each bubble is according to -log10 transformed q values.
    """
    import os
    os.makedirs(output_dir, exist_ok=True)

    to_r_vec = lambda x: (
        "NULL" if (x is None or len(x) == 0) else "c(" + ",".join([f'"{i}"' for i in x]) + ")"
    )

    r_color = to_r_vec(color)
    r_markBands = to_r_vec(markBands)
    r_log = "TRUE" if log_y else "FALSE"

    out_png = os.path.abspath(os.path.join(output_dir, "gistic_bubble_plot.png"))

    ro.r(f"""
        library(TCGAgistic)
        library(maftools)
        gistic_obj <- readRDS("{gistic_rds_path}")

        png("{out_png}", width={img_width}, height={img_height}, res=300)

        gisticBubblePlot(
            gistic = gistic_obj,
            color = {r_color},
            markBands = {r_markBands},
            fdrCutOff = {fdrCutOff},
            log_y = {r_log},
            txtSize = {txtSize}
        )

        dev.off()
    """)

    return Image(path=out_png)

@mcp.tool()
def gistic_chrom_plot(
    gistic_rds_path: str,
    fdrCutOff: float = 0.1,
    markBands: list[str] | None = None,
    color: list[str] | None = None,
    ref_build: str = "hg19",
    cytobandOffset: float = 0.01,
    txtSize: float = 0.8,
    cytobandTxtSize: float = 0.6,
    maf_path: str | None = None,
    mutGenes: list[str] | None = None,
    y_lims: list[float] | None = None,
    mutGenesTxtSize: float = 0.6,
    img_width: int = 2600,
    img_height: int = 2000,
    output_dir: str = "outputs"
) -> Image:
    """
    A genomic plot with segments highlighting signififcant Amplifications and Deletion regions.
    """
    import os
    os.makedirs(output_dir, exist_ok=True)

    def r_vec(x):
        if x is None or len(x) == 0:
            return "NULL"
        is_num = all(isinstance(i, (int, float)) for i in x)
        if is_num:
            return "c(" + ",".join(str(i) for i in x) + ")"
        return "c(" + ",".join(f'"{i}"' for i in x) + ")"

    r_markBands = r_vec(markBands)
    r_color = r_vec(color)
    r_mutGenes = r_vec(mutGenes)
    r_y_lims = r_vec(y_lims)

    r_maf = "NULL"
    if maf_path is not None:
        r_maf = f'read.maf("{maf_path}")'

    out_png = os.path.abspath(os.path.join(output_dir, "gistic_chrom_plot.png"))

    ro.r(f"""
        library(TCGAgistic)
        library(maftools)

        gistic_obj <- readRDS("{gistic_rds_path}")

        png("{out_png}", width={img_width}, height={img_height}, res=300)

        gisticChromPlot(
            gistic = gistic_obj,
            fdrCutOff = {fdrCutOff},
            markBands = {r_markBands},
            color = {r_color},
            ref.build = "{ref_build}",
            cytobandOffset = {cytobandOffset},
            txtSize = {txtSize},
            cytobandTxtSize = {cytobandTxtSize},
            maf = {r_maf},
            mutGenes = {r_mutGenes},
            y_lims = {r_y_lims},
            mutGenesTxtSize = {mutGenesTxtSize}
        )

        dev.off()
    """)

    return Image(path=out_png)
    
@mcp.tool()
def gistic_oncoplot(
    gistic_rds_path: str,
    top: int | None = None,
    bands: list[str] | None = None,
    showTumorSampleBarcodes: bool = False,
    gene_mar: float = 5,
    barcode_mar: float = 6,
    sepwd_genes: float = 0.5,
    sepwd_samples: float = 0.25,
    clinicalData_txt: str | None = None,
    clinicalFeatures: list[str] | None = None,
    sortByAnnotation: bool = False,
    sampleOrder: list[str] | None = None,
    annotationColor: list[str] | None = None,
    bandsToIgnore: list[str] | None = None,
    removeNonAltered: bool = True,
    colors: list[str] | None = None,
    SampleNamefontSize: float = 0.6,
    fontSize: float = 0.8,
    legendFontSize: float = 1.2,
    annotationFontSize: float = 1.2,
    borderCol: str = "white",
    bgCol: str = "#CCCCCC",
    img_width: int = 2600,
    img_height: int = 2000,
    output_dir: str = "outputs"
) -> Image:
    """
    Draw CNV oncoplot-style heatmap using GISTIC data.
    """
    import os
    os.makedirs(output_dir, exist_ok=True)

    def r_vec(x):
        return "NULL" if (x is None or len(x) == 0) else "c(" + ",".join(f'"{i}"' for i in x) + ")"

    def bool_r(x):
        return "TRUE" if x else "FALSE"

    r_top = "NULL" if top is None else str(top)

    r_bands = r_vec(bands)
    r_sampleOrder = r_vec(sampleOrder)
    r_clinicalFeatures = r_vec(clinicalFeatures)
    r_annotationColor = r_vec(annotationColor)
    r_bandsToIgnore = r_vec(bandsToIgnore)
    r_colors = r_vec(colors)

    r_showBarcodes = bool_r(showTumorSampleBarcodes)
    r_sortAnno = bool_r(sortByAnnotation)
    r_removeNonAltered = bool_r(removeNonAltered)

    r_clinicalData = "NULL"
    if clinicalData_txt:
        r_clinicalData = f'read.table("{clinicalData_txt}", header=TRUE, sep="\\t", stringsAsFactors=FALSE)'

    out_png = os.path.abspath(os.path.join(output_dir, "gistic_oncoplot.png"))

    ro.r(f"""
        library(TCGAgistic)

        gistic_obj <- readRDS("{gistic_rds_path}")
        png("{out_png}", width={img_width}, height={img_height}, res=300)
        gisticOncoPlot(
            gistic = gistic_obj,
            top = {r_top},
            bands = {r_bands},
            showTumorSampleBarcodes = {r_showBarcodes},
            gene_mar = {gene_mar},
            barcode_mar = {barcode_mar},
            sepwd_genes = {sepwd_genes},
            sepwd_samples = {sepwd_samples},
            clinicalData = {r_clinicalData},
            clinicalFeatures = {r_clinicalFeatures},
            sortByAnnotation = {r_sortAnno},
            sampleOrder = {r_sampleOrder},
            annotationColor = {r_annotationColor},
            bandsToIgnore = {r_bandsToIgnore},
            removeNonAltered = {r_removeNonAltered},
            colors = {r_colors},
            SampleNamefontSize = {SampleNamefontSize},
            fontSize = {fontSize},
            legendFontSize = {legendFontSize},
            annotationFontSize = {annotationFontSize},
            borderCol = "{borderCol}",
            bgCol = "{bgCol}"
        )

        dev.off()
    """)

    return Image(path=out_png)
    
@mcp.tool()
def infer_heterogeneity(
    maf_path: str,
    tsb: list[str] | None = None,
    top: int = 5,
    vafCol: str | None = None,
    segFile: str | None = None,
    ignChr: list[str] | None = None,
    minVaf: float = 0,
    maxVaf: float = 1,
    useSyn: bool = False,
    dirichlet: bool = False,
    plot_tsb: list[str] | None = None,
    genes: list[str] | None = None,
    showCNvars: bool = False,
    colors: list[str] | None = None,
    output_dir: str = "outputs",
    img_width: int = 2000,
    img_height: int = 1600
) -> Image:
    """
    Clusters variants based on Variant Allele Frequencies (VAF)
    and visualizes tumor heterogeneity.
    """
    import os
    os.makedirs(output_dir, exist_ok=True)

    def vec(x):
        return "NULL" if (x is None or len(x) == 0) else "c(" + ",".join(f'"{i}"' for i in x) + ")"

    def bool_r(x):
        return "TRUE" if x else "FALSE"

    r_tsb = vec(tsb)
    r_ignChr = vec(ignChr)
    r_plot_tsb = vec(plot_tsb)
    r_genes = vec(genes)
    r_colors = vec(colors)

    r_vaf = "NULL" if vafCol is None else f'"{vafCol}"'
    r_seg = "NULL" if segFile is None else f'"{segFile}"'

    r_useSyn = bool_r(useSyn)
    r_dirichlet = bool_r(dirichlet)
    r_showCN = bool_r(showCNvars)

    out_table = os.path.abspath(os.path.join(output_dir, "heterogeneity_table.tsv"))
    out_png = os.path.abspath(os.path.join(output_dir, "heterogeneity_clusters.png"))

    ro.r(f"""
        library(maftools)
        library(mclust)

        maf_obj <- read.maf("{maf_path}")

        hetero <- inferHeterogeneity(
            maf = maf_obj,
            tsb = {r_tsb},
            top = {top},
            vafCol = {r_vaf},
            segFile = {r_seg},
            ignChr = {r_ignChr},
            minVaf = {minVaf},
            maxVaf = {maxVaf},
            useSyn = {r_useSyn},
            dirichlet = {r_dirichlet}
        )

        write.table(
            hetero$clusters,
            file = "{out_table}",
            sep = "\\t",
            quote = FALSE,
            row.names = FALSE
        )

        png("{out_png}", width={img_width}, height={img_height}, res=300)

        plotClusters(
            hetero,
            tsb = {r_plot_tsb},
            genes = {r_genes},
            showCNvars = {r_showCN},
            colors = {r_colors}
        )

        dev.off()
    """)

    return Image(path=out_png)
    
@mcp.tool()
def mutcount_matrix(
    maf_path: str,
    includeSyn: bool = False,
    countOnly: bool | None = None,
    removeNonMutated: bool = True,
    output_dir: str = "outputs"
) -> str:
    """
    Generates a count matrix of mutations. i.e, number of mutations per gene per sample.
    """
    import os
    os.makedirs(output_dir, exist_ok=True)

    r_includeSyn = "TRUE" if includeSyn else "FALSE"
    r_removeNonMutated = "TRUE" if removeNonMutated else "FALSE"
    r_countOnly = "NULL" if countOnly is None else ("TRUE" if countOnly else "FALSE")

    out_tsv = os.path.abspath(os.path.join(output_dir, "mutcount_matrix.tsv"))

    ro.r(f"""
        library(maftools)

        maf <- read.maf("{maf_path}")

        mat <- mutCountMatrix(
            maf = maf,
            includeSyn = {r_includeSyn},
            countOnly = {r_countOnly},
            removeNonMutated = {r_removeNonMutated}
        )

        write.table(
            mat,
            file = "{out_tsv}",
            sep = "\\t",
            quote = FALSE,
            row.names = TRUE,
            col.names = NA
        )
    """)

    return f"📊 Mutation count matrix saved: {out_tsv}"
    
@mcp.tool()
def oncodrive(
    maf_path: str,
    AACol: str | None = None,
    minMut: int = 5,
    pvalMethod: str = "zscore",
    nBgGenes: int = 100,
    bgEstimate: bool = True,
    ignoreGenes: list[str] | None = None,
    output_dir: str = "outputs"
) -> str:
    """
    Clusters variants based on their position to detect disease causing genes.
    Expects maf_path to be an RDS file containing a MAF object.
    """
    import os
    import rpy2.robjects as ro

    if not os.path.exists(maf_path):
        raise FileNotFoundError(f"File not found: {maf_path}")

    os.makedirs(output_dir, exist_ok=True)

    def to_r_vec(x):
        if x is None or len(x) == 0:
            return "NULL"
        return "c(" + ",".join([f'"{i}"' for i in x]) + ")"

    r_AACol = "NULL" if AACol is None else f'"{AACol}"'
    r_ignoreGenes = to_r_vec(ignoreGenes)
    r_bgEstimate = "TRUE" if bgEstimate else "FALSE"

    out_tsv = os.path.abspath(os.path.join(output_dir, "oncodrive.tsv"))

    ro.r(f"""
        suppressPackageStartupMessages(library(maftools))

        invisible(capture.output({{
          invisible(capture.output({{
            options(warn = -1)

            maf <- readRDS("{maf_path}")

            if (!inherits(maf, "MAF")) {{
              stop("Input file does not contain a valid MAF object")
            }}

            od <- suppressWarnings(oncodrive(
              maf = maf,
              AACol = {r_AACol},
              minMut = {minMut},
              pvalMethod = "{pvalMethod}",
              nBgGenes = {nBgGenes},
              bgEstimate = {r_bgEstimate},
              ignoreGenes = {r_ignoreGenes}
            ))

            write.table(
              as.data.frame(od),
              file = "{out_tsv}",
              sep = "\\t",
              quote = FALSE,
              row.names = FALSE
            )
          }}, type = "message"))
        }}, type = "output"))
    """)

    return f"🧬 Oncodrive driver-gene table saved: {out_tsv}"

@mcp.tool()
def pathway_enrichment(
    maf_path: str,
    pathdb: str = "sigpw",
    pathways: str | None = None,
    fontSize: float = 1,
    panelWidths: list[int] | None = None,
    plotType: str = "bar",
    col: str = "#f39c12",
    output_dir: str = "outputs",
    img_width: int = 2600,
    img_height: int = 2000
) -> Image:
    """
    Checks for enrichment of known oncogenic pathways and plots result.
    """
    import os
    os.makedirs(output_dir, exist_ok=True)

    if not os.path.exists(maf_path):
        raise FileNotFoundError(maf_path)

    r_pathways = "NULL" if pathways is None else f'"{pathways}"'
    r_panelWidths = (
        "NULL" if (panelWidths is None or len(panelWidths) == 0)
        else "c(" + ",".join(str(i) for i in panelWidths) + ")"
    )
    r_plotType = f'"{plotType}"'

    out_tsv = os.path.abspath(os.path.join(output_dir, "pathways_enrichment.tsv"))
    plot_png = os.path.abspath(os.path.join(output_dir, "pathways_plot.png"))

    ro.r(f"""
        library(maftools)

        maf <- read.maf("{maf_path}")

        png("{plot_png}", width={img_width}, height={img_height}, res=300)

        pw <- pathways(
            maf = maf,
            pathdb = "{pathdb}",
            pathways = {r_pathways},
            fontSize = {fontSize},
            panelWidths = {r_panelWidths},
            plotType = {r_plotType},
            col = "{col}"
        )

        dev.off()

        write.table(
            pw,
            file = "{out_tsv}",
            sep = "\\t",
            quote = FALSE,
            row.names = FALSE
        )
    """)

    return Image(path=plot_png)
    
@mcp.tool()
def plot_pfam_domains(
    maf_path: str,
    AACol: str | None = None,
    summarizeBy: str = "AAPos",
    top: int = 5,
    domainsToLabel: list[str] | None = None,
    baseName: str | None = None,
    varClass: str = "nonSyn",
    img_width: int = 2600,
    img_height: int = 2000,
    width: float = 5,
    height: float = 5,
    labelSize: float = 1,
    output_dir: str = "outputs"
) -> Image:
    """
    Summarizes amino acid positions and annotates them with pfam domain information.
    """
    import os
    os.makedirs(output_dir, exist_ok=True)

    out_png = os.path.abspath(os.path.join(output_dir, "pfam_domains.png"))

    to_r_vec = lambda x: (
        "NULL" if (x is None or len(x) == 0) else "c(" + ",".join([f'"{i}"' for i in x]) + ")"
    )
    to_r_str = lambda x: "NULL" if x is None else f'"{x}"'

    r_AACol = to_r_str(AACol)
    r_domains = to_r_vec(domainsToLabel)
    r_baseName = to_r_str(baseName)

    ro.r(f"""
        library(maftools)
        maf_obj <- read.maf("{maf_path}")
        png("{out_png}", width={img_width}, height={img_height}, res=300)
        pfamDomains(
            maf = maf_obj,
            AACol = {r_AACol},
            summarizeBy = "{summarizeBy}",
            top = {top},
            domainsToLabel = {r_domains},
            baseName = {r_baseName},
            varClass = "{varClass}",
            width = {width},
            height = {height},
            labelSize = {labelSize}
        )

        dev.off()
    """)

    return Image(path=out_png)

@mcp.tool()
def plot_apobec_diff(
    trinuc_matrix_rds: str,
    maf_rds: str,
    pVal: float = 0.05,
    title_size: float = 1,
    axis_lwd: float = 1,
    font_size: float = 1.2,
    output_dir: str = "outputs",
    img_width: int = 2600,
    img_height: int = 2000
) -> Image:
    """
    Plots differences between APOBEC enriched and non-APOBEC enriched samples
    """
    import os
    os.makedirs(output_dir, exist_ok=True)

    out_png = os.path.abspath(os.path.join(output_dir, "apobec_diff.png"))

    ro.r(f"""
        library(maftools)

        maf_obj <- readRDS("{maf_rds}")
        tnm <- readRDS("{trinuc_matrix_rds}")

        png("{out_png}", width={img_width}, height={img_height}, res=300)

        plotApobecDiff(
            tnm = tnm,
            maf = maf_obj,
            pVal = {pVal},
            title_size = {title_size},
            axis_lwd = {axis_lwd},
            font_size = {font_size}
        )

        dev.off()
    """)

    return Image(path=out_png)
@mcp.tool()
def plot_maf_survgroup(
    maf_rds_path: str,
    geneSet: list[str] | None = None,
    time_col: str = "CDR_OS.time",
    status_col: str = "CDR_OS",
    output_dir: str = "outputs",
    img_width: int = 2600,
    img_height: int = 2000
) -> Image:
    """
    Performs survival analysis for a geneset(for TCGA).
    """
    import os
    os.makedirs(output_dir, exist_ok=True)

    if not os.path.exists(maf_rds_path):
        raise FileNotFoundError(maf_rds_path)

    out_png = os.path.abspath(os.path.join(output_dir, "mafSurvGroup.png"))

    def to_r_vec(x):
        return "NULL" if (x is None or len(x) == 0) else "c(" + ",".join([f'"{i}"' for i in x]) + ")"

    r_geneSet = to_r_vec(geneSet)

    ro.r(f"""
        library(maftools)

        maf <- readRDS("{maf_rds_path}")

        png("{out_png}", width={img_width}, height={img_height}, res=300)

        mafSurvGroup(
            maf = maf,
            geneSet = {r_geneSet},
            time = "{time_col}",
            Status = "{status_col}"
        )

        dev.off()
    """)

    return Image(path=out_png)

@mcp.tool()
def plot_maf_survgroup_custom(
    maf_path: str,
    clinical_csv: str,
    geneSet: list[str] | None = None,
    sample_col: str = "Sample",
    time_col: str = "OS_time",
    status_col: str = "OS_status",
    output_dir: str = "outputs",
    img_width: int = 2600,
    img_height: int = 2000
) -> Image:
    """
    Survival analysis for CUSTOM user-uploaded MAF + clinical CSV.
    """
    import os
    os.makedirs(output_dir, exist_ok=True)

    if not os.path.exists(maf_path):
        raise FileNotFoundError(maf_path)
    if not os.path.exists(clinical_csv):
        raise FileNotFoundError(clinical_csv)

    out_png = os.path.abspath(os.path.join(output_dir, "mafSurvGroup_CUSTOM.png"))

    def to_r_vec(x):
        return "NULL" if (x is None or len(x) == 0) else "c(" + ",".join(f'"{i}"' for i in x) + ")"

    r_geneSet = to_r_vec(geneSet)

    ro.r(f"""
        library(maftools)

        clin <- read.csv("{clinical_csv}", header=TRUE, sep=",")

        if (!("{sample_col}" %in% colnames(clin))) stop("Sample column {sample_col} missing in clinical CSV")
        if (!("{time_col}" %in% colnames(clin))) stop("Time column {time_col} missing in clinical CSV")
        if (!("{status_col}" %in% colnames(clin))) stop("Status column {status_col} missing in clinical CSV")

        # make sure sample IDs match MAF Tumor_Sample_Barcode (commonly first 12 chars for TCGA-like IDs)
        clin[[ "{sample_col}" ]] <- substr(as.character(clin[[ "{sample_col}" ]]), 1, 12)
        colnames(clin)[colnames(clin) == "{sample_col}"] <- "Tumor_Sample_Barcode"

        maf <- read.maf(
            maf = "{maf_path}",
            clinicalData = clin,
            verbose = TRUE
        )

        png("{out_png}", width={img_width}, height={img_height}, res=300)

        mafSurvGroup(
            maf = maf,
            geneSet = {r_geneSet},
            time = "{time_col}",
            Status = "{status_col}"
        )

        dev.off()
    """)

    return Image(path=out_png)

@mcp.tool()
def oncodrive_analysis(
    maf_path: str,
    output_dir: str = "outputs",
    AACol: str | None = None,
    minMut: int = 5,
    pvalMethod: str = "zscore",
    nBgGenes: int = 100,
    bgEstimate: bool = True,
    ignoreGenes: list[str] | None = None,
    fdrCutOff: float = 0.05,
    useFraction: bool = False,
    colCode: list[str] | None = None,
    bubbleSize: float = 1.0,
    labelSize: float = 1.0,
    img_width: int = 2600,
    img_height: int = 2000
) -> Image:
    """
    Clusters variants based on their position to detect disease causing genes.
    Expects maf_path to be an RDS file containing a MAF object.
    """
    import os
    import rpy2.robjects as ro

    os.makedirs(output_dir, exist_ok=True)

    if not os.path.exists(maf_path):
        raise FileNotFoundError(f"MAF not found: {maf_path}")

    def to_r_vec(x):
        return "NULL" if (x is None or len(x) == 0) else "c(" + ",".join([f'"{i}"' for i in x]) + ")"

    r_ignore = to_r_vec(ignoreGenes)
    r_colCode = to_r_vec(colCode)
    r_bgEstimate = "TRUE" if bgEstimate else "FALSE"
    r_AACol = "NULL" if AACol is None else f'"{AACol}"'
    r_useFraction = "TRUE" if useFraction else "FALSE"

    out_table = os.path.abspath(os.path.join(output_dir, "oncodrive_result.tsv"))
    out_png = os.path.abspath(os.path.join(output_dir, "oncodrive_plot.png"))
    out_rds = os.path.abspath(os.path.join(output_dir, "oncodrive_result.rds"))

    ro.r(f"""
        suppressPackageStartupMessages(library(maftools))

        invisible(capture.output({{
          invisible(capture.output({{
            options(warn = -1)

            maf <- readRDS("{maf_path}")

            if (!inherits(maf, "MAF")) {{
              stop("Input file does not contain a valid MAF object")
            }}

            res <- suppressWarnings(oncodrive(
              maf = maf,
              AACol = {r_AACol},
              minMut = {minMut},
              pvalMethod = "{pvalMethod}",
              nBgGenes = {nBgGenes},
              bgEstimate = {r_bgEstimate},
              ignoreGenes = {r_ignore}
            ))

            write.table(as.data.frame(res),
              file = "{out_table}",
              sep = "\\t",
              quote = FALSE,
              row.names = FALSE
            )

            saveRDS(res, file = "{out_rds}")

            png("{out_png}", width = {img_width}, height = {img_height}, res = 300)

            suppressWarnings(plotOncodrive(
              res = res,
              fdrCutOff = {fdrCutOff},
              useFraction = {r_useFraction},
              colCode = {r_colCode},
              bubbleSize = {bubbleSize},
              labelSize = {labelSize}
            ))

            dev.off()
          }}, type = "message"))
        }}, type = "output"))
    """)

    return Image(path=out_png)
    
@mcp.tool()
def plot_cbs_segments(
    cbsFile: str | None = None,
    maf_path: str | None = None,
    tsb: str | None = None,
    output_dir: str = "outputs",
    ylims: list[float] | None = None,
    seg_size: float = 0.1,
    genes: list[str] | None = None,
    ref_build: str = "hg19",
    writeTable: bool = False,
    removeXY: bool = False,
    color: list[str] | None = None,
    img_width: int = 2600,
    img_height: int = 1200
) -> Image:
    """
    Plots segmented copy number data.
    """
    import os
    os.makedirs(output_dir, exist_ok=True)

    if cbsFile is None and (maf_path is None or tsb is None):
        raise ValueError("Provide either cbsFile OR (maf_path + tsb).")

    if cbsFile and not os.path.exists(cbsFile):
        raise FileNotFoundError(cbsFile)
    if maf_path and not os.path.exists(maf_path):
        raise FileNotFoundError(maf_path)

    def r_vec(x):
        return "NULL" if (x is None or len(x) == 0) else "c(" + ",".join(f'"{i}"' for i in x) + ")"

    def r_num_vec(x):
        return "NULL" if (x is None or len(x) == 0) else "c(" + ",".join(str(i) for i in x) + ")"

    out_png = os.path.abspath(os.path.join(output_dir, "CBS_segments.png"))

    ro.r(f"""
        library(maftools)

        maf <- {f'maftools::read.maf("{maf_path}")' if maf_path else 'NULL'}

        png("{out_png}", width={img_width}, height={img_height}, res=300)

        plotCBSsegments(
            cbsFile = {f'"{cbsFile}"' if cbsFile else 'NULL'},
            maf = maf,
            tsb = {f'"{tsb}"' if tsb else 'NULL'},
            savePlot = FALSE,
            ylims = {r_num_vec(ylims)},
            seg_size = {seg_size},
            genes = {r_vec(genes)},
            ref.build = "{ref_build}",
            writeTable = {"TRUE" if writeTable else "FALSE"},
            removeXY = {"TRUE" if removeXY else "FALSE"},
            color = {r_vec(color)}
        )

        dev.off()
    """)

    return Image(path=out_png)
    
@mcp.tool()
def prepare_mutsig(
    maf_path: str,
    output_maf: str | None = None
) -> str:
    """
    Correct gene symbols for MutSig compatibility.
    """
    import os

    if not os.path.exists(maf_path):
        raise FileNotFoundError(maf_path)

    if output_maf is None:
        output_maf = maf_path.replace(".maf", "_mutsig.maf")

    output_maf = os.path.abspath(output_maf)

    res = ro.r(f"""
        library(maftools)

        maf <- read.maf("{maf_path}")

        msg <- capture.output(
            maf2 <- prepareMutSig(maf, fn = "{output_maf}")
        )

        list(
            message = paste(msg, collapse="\\n"),
            out = "{output_maf}"
        )
    """)

    return (
        "🧬 MutSig preparation finished\n\n"
        f"{res.rx2('message')[0]}\n\n"
        f"📄 Output MAF: {res.rx2('out')[0]}"
    )
    
@mcp.tool()
def plot_tmb(
    maf_path: str,
    captureSize: float = 50,
    logScale: bool = True,
    output_dir: str = "outputs",
    img_width: int = 2600,
    img_height: int = 2000
) -> Image:
    """
    Estimates Tumor Mutation Burden per megabase.
    """
    import os
    os.makedirs(output_dir, exist_ok=True)

    if not os.path.exists(maf_path):
        raise FileNotFoundError(maf_path)

    out_png = os.path.abspath(os.path.join(output_dir, "tmb.png"))

    ro.r(f"""
        library(maftools)

        maf <- read.maf("{maf_path}")

        png("{out_png}", width={img_width}, height={img_height}, res=300)

        tmb(
            maf = maf,
            captureSize = {captureSize},
            logScale = {"TRUE" if logScale else "FALSE"}
        )

        dev.off()
    """)

    return Image(path=out_png)

@mcp.tool()
def plot_vaf_compare(
    maf1_path: str,
    maf2_path: str,
    output_dir: str = "outputs",
    genes: list[str] | None = None,
    top: int = 5,
    vafCol1: str | None = None,
    vafCol2: str | None = None,
    m1Name: str = "M1",
    m2Name: str = "M2",
    cols: list[str] | None = None,
    sigvals: bool = True,
    nrows: int | None = None,
    ncols: int | None = None,
    img_width: int = 2600,
    img_height: int = 1800
) -> Image:
    """
    Compare VAF distributions between two cohorts.
    """
    import os
    os.makedirs(output_dir, exist_ok=True)

    def r_vec(x):
        return "NULL" if (x is None or len(x) == 0) else "c(" + ",".join(f'"{i}"' for i in x) + ")"

    def load_maf(path, var):
        return f'{var} <- readRDS("{path}")' if path.endswith(".rds") \
            else f'{var} <- maftools::read.maf("{path}")'

    out_png = os.path.abspath(os.path.join(output_dir, "vaf_compare.png"))

    ro.r(f"""
        library(maftools)

        {load_maf(maf1_path, "m1")}
        {load_maf(maf2_path, "m2")}

        png("{out_png}", width={img_width}, height={img_height}, res=300)

        vafCompare(
            m1 = m1,
            m2 = m2,
            genes = {r_vec(genes)},
            top = {top},
            vafCol1 = {"NULL" if vafCol1 is None else f'"{vafCol1}"'},
            vafCol2 = {"NULL" if vafCol2 is None else f'"{vafCol2}"'},
            m1Name = "{m1Name}",
            m2Name = "{m2Name}",
            cols = {r_vec(cols)},
            sigvals = {"TRUE" if sigvals else "FALSE"},
            nrows = {"NULL" if nrows is None else nrows},
            ncols = {"NULL" if ncols is None else ncols}
        )

        dev.off()
    """)

    return Image(path=out_png)


# ========= Internal validation utility =========

class _RScriptCaptured(Exception):
    """Internal control-flow signal used to stop a dry-run after ro.r is captured."""


def _mcp_tool_names_from_source() -> set[str]:
    source = inspect.getsource(inspect.getmodule(_mcp_tool_names_from_source))
    names: set[str] = set()
    current_decorated = False

    for line in source.splitlines():
        stripped = line.strip()
        if stripped == "@mcp.tool()":
            current_decorated = True
            continue
        if current_decorated and stripped.startswith("def "):
            name = stripped.split("def ", 1)[1].split("(", 1)[0]
            if name != "export_r_script":
                names.add(name)
            current_decorated = False
        elif stripped and not stripped.startswith("@"):
            current_decorated = False

    return names


def _bind_tool_parameters(tool_func: Any, user_parameters: Dict[str, Any] | None) -> Dict[str, Any]:
    signature = inspect.signature(tool_func)
    provided = dict(user_parameters or {})
    unknown = sorted(set(provided) - set(signature.parameters))
    if unknown:
        raise ValueError(
            f"Unknown parameter(s) for {tool_func.__name__}: {', '.join(unknown)}"
        )

    bound = signature.bind_partial(**provided)
    bound.apply_defaults()

    missing = [
        name
        for name, param in signature.parameters.items()
        if name not in bound.arguments and param.default is inspect.Parameter.empty
    ]
    if missing:
        raise ValueError(
            f"Missing required parameter(s) for {tool_func.__name__}: {', '.join(missing)}"
        )

    return dict(bound.arguments)


def _unwrap_fastmcp_tool(tool_obj: Any) -> Any:
    return getattr(tool_obj, "fn", tool_obj)


def _capture_tool_r_script(tool_func: Any, effective_parameters: Dict[str, Any]) -> str:
    captured: list[str] = []
    original_r = ro.r

    def capture_r(script: str) -> None:
        captured.append(str(script))
        raise _RScriptCaptured()

    ro.r = capture_r
    try:
        tool_func(**effective_parameters)
    except _RScriptCaptured:
        pass
    finally:
        ro.r = original_r

    if not captured:
        raise RuntimeError(
            f"No R code was captured for {tool_func.__name__}. "
            "The tool may have returned before calling ro.r, or it may not be an R-backed tool."
        )

    return textwrap.dedent(captured[0]).strip() + "\n"


def _detect_underlying_r_function(r_script: str) -> str:
    priority = [
        "annovarToMaf", "merge_mafs", "getSampleSummary",
        "plotmafSummary", "oncoplot", "titv", "plotTiTv", "plotVaf",
        "math.score", "lollipopPlot", "rainfallPlot", "tcgaCompare",
        "tcga_load", "pcawg_load", "coOncoplot", "coBarplot",
        "lollipopPlot2", "mafCompare", "forestPlot", "trinucleotideMatrix",
        "estimateSignatures", "plotCophenetic", "extractSignatures",
        "compareSignatures", "plotSignatures", "clinicalEnrichment",
        "plotEnrichmentResults", "signatureEnrichment", "drugInteractions",
        "filterMaf", "subsetMaf", "genesToBarcodes", "genotypeMatrix",
        "getClinicalData", "getFields", "getGeneSummary", "tcga_gistic_load",
        "gisticBubblePlot", "gisticChromPlot", "gisticOncoPlot",
        "inferHeterogeneity", "mutCountMatrix", "oncodrive",
        "plotOncodrive", "pathways", "plotPathways", "pfamDomains",
        "plotApobecDiff", "mafSurvGroup", "plotCBSsegments",
        "prepareMutSig", "tmb", "vafCompare",
    ]

    calls = re.findall(r"(?:(maftools|TCGAmutations|PCAWGmutations|TCGAgistic)::)?([A-Za-z.][A-Za-z0-9_.]*)\s*\(", r_script)
    seen: dict[str, str] = {}
    for namespace, name in calls:
        seen.setdefault(name, f"{namespace}::{name}" if namespace else f"maftools::{name}")

    for name in priority:
        if name in seen:
            return seen[name]

    ignored = {
        "library", "suppressPackageStartupMessages", "png", "pdf", "dev.off",
        "readRDS", "saveRDS", "write.table", "read.table", "paste", "paste0",
        "ifelse", "length", "list", "c", "is.null", "nrow", "colnames",
        "stop", "tryCatch", "conditionMessage", "unique", "print", "sink",
        "read.maf",
    }
    for _, name in calls:
        if name not in ignored:
            return f"maftools::{name}"

    return "Unable to determine from captured R script"


@mcp.tool()
def export_r_script(
    tool_name: str,
    parameters: Dict[str, Any] | None = None,
    output_dir: str = "outputs/r_scripts",
    script_basename: str | None = None
) -> str:
    """
    Export the R code generated by an existing Maftools-MCP tool without executing R.

    This internal validation utility captures the actual ro.r(...) script assembled by
    the selected MCP tool after applying the same Python-side parameter defaults and
    conversion logic used during normal MCP execution.
    """
    tool_names = _mcp_tool_names_from_source()
    if tool_name not in tool_names:
        return (
            f"❌ Unknown analytical MCP tool: {tool_name}\n"
            "Note: export_r_script is an internal validation utility and is not included "
            "in the analytical tool inventory."
        )

    tool_obj = globals().get(tool_name)
    if tool_obj is None:
        return f"❌ Tool function not found in server globals: {tool_name}"
    tool_func = _unwrap_fastmcp_tool(tool_obj)

    try:
        effective_parameters = _bind_tool_parameters(tool_func, parameters)
        r_script = _capture_tool_r_script(tool_func, effective_parameters)
    except Exception as exc:
        return f"❌ Failed to export R script for {tool_name}: {exc}"

    underlying = _detect_underlying_r_function(r_script)

    os.makedirs(output_dir, exist_ok=True)
    if script_basename is None:
        script_basename = f"{tool_name}_validation"
    if not script_basename.endswith(".R"):
        script_basename = f"{script_basename}.R"
    script_path = os.path.abspath(os.path.join(output_dir, script_basename))

    header = (
        "# Auto-exported by Maftools-MCP export_r_script for validation.\n"
        "# This script was captured from the existing MCP tool implementation.\n"
        f"# MCP tool: {tool_name}\n"
        f"# Underlying R/Maftools function: {underlying}\n"
        "# Effective MCP parameters:\n"
        + "\n".join(
            f"#   {name} = {json.dumps(value, ensure_ascii=False)}"
            for name, value in effective_parameters.items()
        )
        + "\n\n"
    )

    with open(script_path, "w") as handle:
        handle.write(header)
        handle.write(r_script)

    return (
        "✅ R validation script exported.\n"
        f"MCP tool name: {tool_name}\n"
        f"Underlying R/Maftools function: {underlying}\n"
        f"Exported .R script path: {script_path}\n"
        "Parameters written to script:\n"
        + json.dumps(effective_parameters, indent=2, ensure_ascii=False)
    )

# ========= main =========

def main():
    parser = argparse.ArgumentParser(description="MCP server for maftools")
    parser.add_argument("--transport", choices=["stdio", "http"], default="stdio", help="Transport type (stdio or http)")
    parser.add_argument("--host", default="127.0.0.1", help="Host for HTTP mode")
    parser.add_argument("--port", type=int, default=8000, help="Port for HTTP mode")
    parser.add_argument("--path", default="/mcp", help="Path for HTTP mode")
    args = parser.parse_args()

    if args.transport == "http":
        os.environ["FASTMCP_HOST"] = args.host
        os.environ["FASTMCP_PORT"] = str(args.port)
        os.environ["FASTMCP_PATH"] = args.path

        print(f"🌐 Running Streamable HTTP MCP server on http://{args.host}:{args.port}{args.path}")
        mcp.run(transport="streamable-http")

    else:
        print("🔌 Running STDIO MCP server (default mode)")
        mcp.run(transport="stdio")


if __name__ == "__main__":
    main()
