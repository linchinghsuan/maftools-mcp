# Maftools-MCP

Maftools-MCP exposes R maftools analyses through the Model Context Protocol (MCP).
An MCP-compatible client can translate a natural-language request into calls for
mutation summaries, oncoplots, cohort comparisons, mutation signatures, clinical
enrichment, survival analyses, and copy-number visualization.

The server includes the **59 tools counted in the manuscript**, plus the
`export_r_script` validation utility: **60 registered tools in total**. See the
[complete tool reference](docs/tools.md) for inputs, defaults, outputs and
underlying R functions. R code is executed through rpy2. ANNOVAR annotation is an
optional external workflow; the server's conversion tool consumes annotated
multianno files, not unannotated VCFs.

## Installation

The recorded validation environment uses Python **3.11.5**, R **4.5.1**, maftools
**2.24.0**, rpy2 **3.6.4**, and FastMCP commit
`b3bce0c2312444f50863a9887fc3d46917bd8f71`
(`2.13.2.dev10+b3bce0c`). Install these Python and R versions first, then run from
the repository root:

```bash
python3.11 -m venv .venv
source .venv/bin/activate
export RPY2_CFFI_MODE=ABI
Rscript environment/install.R
export R_LIBS_USER="$PWD/environment/library"
python -m pip install -r requirements.txt
python -m pip install --no-deps .
python scripts/check_environment.py
Rscript environment/check.R
python scripts/smoke_test.py
```

R packages may require a compiler and development libraries; the Dockerfile lists
the Linux system dependencies. The R installer uses explicit package versions and
GitHub commits, installs into `environment/library`, and fails if an exact source
is unavailable. It includes the hg19 genome package for trinucleotide analyses,
which makes the full installation substantially larger than the server source.
The Python lock is a captured environment snapshot, without local editable paths.

## Start the server

```bash
maftools-mcp --transport stdio
```

Example client configuration, replacing the paths with your installation:

```json
{
  "mcpServers": {
    "maftools-mcp": {
      "command": "/absolute/path/to/repository/.venv/bin/maftools-mcp",
      "args": ["--transport", "stdio"],
      "env": {
        "RPY2_CFFI_MODE": "ABI",
        "R_LIBS_USER": "/absolute/path/to/repository/environment/library"
      }
    }
  }
}
```

For a client supporting Streamable HTTP:

```bash
maftools-mcp --transport http --host 127.0.0.1 --port 8000 --path /mcp
```

Connect the client to `http://127.0.0.1:8000/mcp`. The supplied launcher keeps
startup messages off the stdio protocol channel and explicitly applies HTTP
settings. The analytical `server.py` is preserved from the supplied source.

## Basic example

After connecting your client, use an absolute server-visible path:

> Use Maftools-MCP to summarize `/absolute/path/to/repository/examples/data/synthetic.maf`,
> then generate an oncoplot of the top 3 genes in `/absolute/path/to/outputs`.
> Export the R script for the final oncoplot call with the same parameters.

For direct tool invocation, the oncoplot arguments are:

```json
{
  "maf_path": "/absolute/path/to/repository/examples/data/synthetic.maf",
  "output_dir": "/absolute/path/to/outputs",
  "top": 3
}
```

The six-row example is synthetic and was not used in the paper. Manuscript
[use-case prompt summaries](examples/use_case_prompts.md) and
[Stage 2 original prompts](validation/stage2/prompts.tsv) are included separately.

## Docker

The author already provides `lin97/maftools-mcp:v.1.1.0`. The existing local image
has this recorded immutable reference:

```bash
docker run --rm -i -v "$PWD:/work" \
  lin97/maftools-mcp@sha256:2e3be5b768c9f77cbe942207025987fc4d39d4cc7a39563ea0fc159de9cf1b4b
```

Use `/work/...` paths for mounted files. This image was observed as Linux arm64;
remote registry availability and other platforms were not verified during this
preparation. The checked-in Dockerfile preserves the supplied recipe, with only
its two COPY paths adapted to the repository layout. Its original floating
requirements are retained separately in `environment/docker-requirements.original.txt`.
It is supplied for transparency; no new image was built or published here.

**The existing image and recorded local manuscript environment differ in package
versions. Their server.py source hashes match.** See [environment.md](docs/environment.md).
The Python and R version locks in this repository target the recorded local
validation environment; they do not describe the existing Docker image.
The relationship between that image and the paper release must be stated
accurately before a paper tag is assigned. See [release status](docs/release.md).

## Validation and data

[Validation instructions](validation/README.md) describe the included historical
scripts, prompt tables, reports and repeatability records. Supplementary Tables
S1–S4 are preserved as received, with TSV exports for searching. No new execution
is represented as a historical manuscript result.

Patient-level input files, ANNOVAR software/databases, full execution logs and
large intermediate outputs are not distributed here. The
[data manifest](validation/data_manifest.tsv) records supplied input filenames,
sizes and SHA-256 hashes. Exact manuscript reruns require access to those inputs;
the source archive alone does not establish redistribution rights or a public
download source. See [ANNOVAR configuration](docs/annovar.md).

## License

Maftools-MCP code is available under the [MIT License](LICENSE). R, maftools,
ANNOVAR and other dependencies retain their own licenses. This repository does
not grant redistribution rights for third-party datasets or ANNOVAR assets.
