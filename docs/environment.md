# Recorded container environment and ANNOVAR workflow

The following table records the environment used by the packaged
`lin97/maftools-mcp:v.1.1.0` Docker image and the associated ANNOVAR workflow.
The software versions are observations from the existing image; no replacement
image was rebuilt or published during this preparation.

| Category | Software / resource | Version / identifier | Description |
|---|---|---|---|
| Container | Docker image | `lin97/maftools-mcp:v.1.1.0` | Maftools-MCP Docker image |
| Container | Docker image digest | `sha256:d7dc8ed2ea12c1a9ee9e60a4f304ab056a53e5cfa1d4780871603ed875ef2b86` | Docker image identifier |
| Software | Python | `3.11.16` | Python runtime |
| Software | FastMCP | `4.0.2` | Model Context Protocol server framework |
| Software | rpy2 | `3.6.7` | Python–R interface |
| Software | R | `4.5.0` | R environment |
| R package | maftools | `2.26.0` | Somatic mutation analysis |
| R package | data.table | `1.18.6.1` | Data processing |
| R package | BiocManager | `1.30.27` | Bioconductor package management |
| Reference data package | TCGAmutations | `0.4.0` | TCGA mutation data |
| Reference data package | TCGAgistic | `0.0.0.9000` | TCGA GISTIC data |
| Reference data package | PCAWGmutations | `0.0.0.9000` | PCAWG mutation data |
| R package | BSgenome | `1.78.0` | Genome sequence infrastructure |
| External software | ANNOVAR | `2025-03-02` | Variant annotation; installed separately |
| Annotation database version | hg19 refGene database | `2021-10-19` | ANNOVAR database distribution date: 2021-10-19; underlying UCSC data update: 2020-08-17. |
| Annotation setting | Gene annotation | `refGene` | Gene-based annotation using the hg19 refGene database |
| Annotation setting | Transcript/exon ordering | `-exonsort` | Ordering rule used when multiple transcript annotations are reported. |
| Reference workflow | Direct ANNOVAR command | `convert2annovar.pl -includeinfo -allsample -withfreq -format vcf4 <input.vcf> → table_annovar.pl <input.avinput> <humandb/> -buildver hg19 -protocol refGene -operation g -remove -polish -nastring . -thread 4 -outfile <prefix> -otherinfo → annotate_variation.pl -exonsort -nofirstcodondel` | Reference commands recorded in the ANNOVAR logs: VCF conversion followed by hg19/refGene gene-based annotation, with `-exonsort` and `-nofirstcodondel` passed to `annotate_variation.pl` by `table_annovar.pl`. |
| MAF conversion setting | Transcript handling during MAF conversion | `First AAChange.refGene entry` | For variants with multiple `AAChange.refGene` entries, MAF conversion uses the first entry for the transcript, exon, cDNA-change, and amino-acid-change fields, without additional transcript prioritization. |

## Provenance and repository environment files

The image digest and observed package versions are also stored in
`environment/observed-docker-image.json`. The image was observed on
2026-09-24, runs on Linux `arm64`, and its included `server.py` hash matches
the source snapshot in this repository.

The repository records the packaged image as the authoritative environment;
local/paper lock files and installation scripts are not distributed here.
The root `Dockerfile` is retained as historical source context and is not
claimed to reproduce the existing image byte-for-byte.

ANNOVAR and its annotation databases are external resources. This repository
does not redistribute ANNOVAR or the `humandb` database files; the table above
records the versions and settings used by the reference workflow.
