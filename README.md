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

The packaged Docker image is available from Docker Hub:

```bash
docker pull lin97/maftools-mcp:v.1.1.0
```

For an immutable image reference, use the recorded digest:

```bash
docker pull lin97/maftools-mcp@sha256:d7dc8ed2ea12c1a9ee9e60a4f304ab056a53e5cfa1d4780871603ed875ef2b86
```

For setup instructions, MCP client configuration, and usage examples, see the
[Maftools-MCP tutorial](http://tardis.cgu.edu.tw/maftools-mcp/).

## Code Availability

The Maftools-MCP source code is publicly available in this GitHub repository:

<https://github.com/linchinghsuan/maftools-mcp>

The Python MCP server source is located in [`src/maftools_mcp/`](src/maftools_mcp/).
The repository also includes the complete tool reference, machine-readable tool
schema, and curated validation materials in [`docs/`](docs/) and
[`validation/`](validation/).

The packaged environment is documented in
[`docs/environment.md`](docs/environment.md), including the Docker image digest
and the observed Python, R, maftools, and ANNOVAR workflow versions. The
machine-readable image record is available at
[`environment/observed-docker-image.json`](environment/observed-docker-image.json).

### Validation materials

The validation directory contains the detailed records supporting the
Supplementary Tables. The corresponding materials are organized as follows:

| Supplementary table | Validation materials |
|---|---|
| Supplementary Table S1 | [`validation/Stage_1_mcp_inspector/`](validation/Stage_1_mcp_inspector/) and [`validation/Stage_2_LLM_validation/`](validation/Stage_2_LLM_validation/) contain the detailed MCP Inspector and LLM validation records. |
| Supplementary Table S2 | [`validation/Use-case_evaluation/repeated_run/`](validation/Use-case_evaluation/repeated_run/) contains the repeated-run evaluation materials. |
| Supplementary Table S3 | [`validation/ANNOVAR_skill+maftools-mcp/`](validation/ANNOVAR_skill+maftools-mcp/) contains the ANNOVAR skill and Maftools-MCP evaluation materials. |
| Supplementary Table S4 | [`validation/Use-case_evaluation/prompt_robustness/`](validation/Use-case_evaluation/prompt_robustness/) contains the prompt-robustness evaluation materials. |

These directories include the relevant inputs, execution records, generated
outputs, comparison files, scripts, and figures where available. The validation
materials are provided for review and provenance; ANNOVAR itself and restricted
third-party data or databases are not redistributed.


## Citation

Ching-Hsuan Lin, Chi-Ching Lee, Sin-Hong Shih, Cheng-Chi Yang, Mu-Yun Xu,
Yuan-Ming Yeh, Po-Jung Huang. Maftools-MCP: A Model Context Protocol–enabled
Framework for LLM–driven Somatic Mutation Analysis. *Bioinformatics Advances*.
2026; vbag336. [https://doi.org/10.1093/bioadv/vbag336](https://doi.org/10.1093/bioadv/vbag336)

## License

Maftools-MCP code is available under the [MIT License](LICENSE). R, maftools,
ANNOVAR and other dependencies retain their own licenses. This repository does
not grant redistribution rights for third-party datasets or ANNOVAR assets.
