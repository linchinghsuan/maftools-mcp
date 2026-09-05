# Recorded environment and installation pins

Versions below come from `Supplementary_Data_packages_version.docx` and were
cross-checked against the available local validation installation on 2026-09-05.
This observation confirms the present installation, not the identity of every
past run. Historical run-level environment captures were not available for all runs.

| Component | Recorded version |
|---|---|
| Maftools-MCP package | 0.1.0 |
| Python | 3.11.5 |
| FastMCP | 2.13.2.dev10+b3bce0c |
| FastMCP commit | b3bce0c2312444f50863a9887fc3d46917bd8f71 |
| MCP Python package | 1.20.0 |
| rpy2 | 3.6.4 |
| rpy2-rinterface / rpy2-robjects | 3.6.3 / 3.6.3 |
| FastAPI / uvicorn / pydantic | 0.121.0 / 0.38.0 / 2.12.3 |
| R | 4.5.1 |
| maftools | 2.24.0 |
| data.table | 1.18.4 |
| BiocManager | 1.30.27 |
| TCGAmutations | 0.4.0 |
| TCGAgistic / PCAWGmutations | 0.0.0.9000 / 0.0.0.9000 |
| BSgenome | 1.76.0 |

`environment/python-requirements.lock.txt` captures Python dependency versions.
`environment/r-runtime-lock.tsv` captures the dependency closure needed by the
runtime and hg19 workflow, with explicit download versions and GitHub commits.
`observed-r-packages.tsv` is the wider local installation inventory, including
packages that are not runtime dependencies. The installer does not claim that a
new installation was used for the historical paper experiments.

TCGA/PCAWG package commits recorded from installed DESCRIPTION metadata:

- TCGAmutations: `3474e3412cfa1490db4a84db57e4a732480990a9`
- TCGAgistic: `adf0782554c2d7916169cf81f69d19247047b7eb`
- PCAWGmutations: `803ecdfd1aeb06358c3c5ba98559f79d69d5b83e`

The supplied Dockerfile uses floating dependency installation. An unchanged copy
is preserved as `environment/historical/Dockerfile.unpinned`; the root Dockerfile
adapts only its COPY paths. The original two-line requirements file is preserved
as `environment/docker-requirements.original.txt`. At the author's request the
existing packaged image is retained; a trial replacement build was stopped and
no replacement image was completed or published. The local environment locks
are separate from the existing container's environment.

Bioconductor 3.21 is the release recorded in installed package metadata and
[supports R 4.5](https://bioconductor.org/news/bioc_3_21_release/).

## Existing image discrepancy

Local image observed on 2026-09-05:

`lin97/maftools-mcp@sha256:2e3be5b768c9f77cbe942207025987fc4d39d4cc7a39563ea0fc159de9cf1b4b`

Tag: `v.1.1.0`; platform: Linux arm64. Its observed Python 3.11.16, FastMCP 4.0.2,
rpy2 3.6.7, R 4.5.0 and maftools 2.26.0 **differ** from the recorded environment.
Its `server.py` hash matches the source included here. The observed
digest is provenance information, not a paper-image endorsement or verification
of current remote registry availability. Machine-readable details are in
`environment/observed-docker-image.json`.

## Complete existing-container package check

Read directly from the existing image; no rebuild performed.

| Component | Container version |
|---|---|
| Python | 3.11.16 |
| FastMCP | 4.0.2 |
| MCP Python package | 2.1.1 |
| rpy2 | 3.6.7 |
| rpy2-rinterface | 3.6.6 |
| rpy2-robjects | 3.6.5 |
| FastAPI | not installed as a Python distribution |
| uvicorn | 0.52.4 |
| pydantic | 2.13.5 |
| R | 4.5.0 |
| maftools | 2.26.0 |
| data.table | 1.18.6.1 |
| BiocManager | 1.30.27 |
| TCGAmutations | 0.4.0 |
| TCGAgistic | 0.0.0.9000 |
| PCAWGmutations | 0.0.0.9000 |
| BSgenome | 1.78.0 |

Maftools-MCP is copied into the image as server.py rather than installed as a
Python distribution, so package metadata does not establish a container package
version. Docker tag v.1.1.0 and local package version 0.1.0 are distinct identifiers.
