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

Download the Maftools-MCP Docker image:

```bash
docker pull lin97/maftools-mcp:v.1.1.0
```

For setup instructions, MCP client configuration, and usage examples, see the
[Maftools-MCP tutorial](http://tardis.cgu.edu.tw/maftools-mcp/).


## License

Maftools-MCP code is available under the [MIT License](LICENSE). R, maftools,
ANNOVAR and other dependencies retain their own licenses. This repository does
not grant redistribution rights for third-party datasets or ANNOVAR assets.
