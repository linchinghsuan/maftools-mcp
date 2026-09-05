# ANNOVAR integration and manuscript configuration

The repository contains the author's ANNOVAR skill instructions and reference
Markdown. It excludes the ANNOVAR archive, executable Perl scripts, databases
and sample-level annotation outputs. Obtain ANNOVAR separately using the
[official registration/download instructions](https://annovar.openbioinformatics.org/en/latest/user-guide/download/).
The generic skill contains examples for other builds and database combinations;
the configuration below is the manuscript-specific record from Table S4.

| Item | Record |
|---|---|
| Archive date | 2025-03-03 |
| annotate_variation.pl metadata | `$Date: 2025-03-02 22:37:01 -0500` |
| table_annovar.pl metadata | `$Date: 2022-08-02 22:48:58 -0400` |
| Genome build | hg19 |
| Protocol / operation | refGene / g |
| Database files | hg19_refGene.txt, hg19_refGeneMrna.fa, hg19_refGeneVersion.txt |
| Flags | -buildver hg19 -protocol refGene -operation g -remove -polish -vcfinput -nastring . |

These records are not a conventional semantic ANNOVAR version. Database checksums
and a dated refGene database snapshot were not supplied in the version table;
filenames alone cannot prove identical database contents in a future download.

```bash
bash validation/annovar/run_annotation.sh \
  /path/to/annovar /path/to/humandb /path/to/input_vcfs /path/to/new_outputs
```

Then call `merge_annovar_to_maf` with the generated `*.hg19_multianno.txt` paths,
`refBuild="hg19"`, `table="refGene"`, `ens2hugo=true`, `sep="\t"` and
`sampleAnno=null`. The original command logs and exported merge/plot scripts
are in `validation/annovar/`. The wrapper above is newly supplied for portable
execution and does not replace those historical records.

## Transcript handling

Inspection of the locally installed **maftools 2.24.0** `annovarToMaf` implementation
shows that it uses the **first comma-separated entry** in `AAChange.refGene` to
extract transcript, exon, cDNA change and amino-acid change. It also selects the
first semicolon-separated gene/consequence entry at the corresponding parsing
steps. Maftools-MCP passes the annotation table to this function without adding
a canonical-transcript or MANE selection step. Thus multiple transcript entries
are not expanded into one independent MAF row per transcript by that parsing
step; the selected annotation depends on the input ordering. The original
multianno files should be retained in the private/archive data record so all
annotations remain available. This describes the observed pinned implementation,
not a promise about future maftools versions or a transcript priority at the
upstream ANNOVAR annotation stage.
