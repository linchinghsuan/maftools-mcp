# Paper release status

This is a local publication preparation, not a published GitHub release. The
suggested tag is `v0.1.0-paper`, consistent with package version 0.1.0; no tag,
remote URL or commit has been invented. `paper-release.json` records unset
fields explicitly as null.

Before assigning the fixed paper release:

1. Confirm that the included source snapshot is the intended manuscript version.
   The SHA-256 is recorded in `paper-release.json`; it matches the existing
   Docker image's server.py snapshot.
2. Use the existing author-packaged Docker image and its recorded digest.
   Clarify its role relative to the local validation environment and reconcile the
   environment version differences before identifying it as the paper environment.
3. Confirm public input sources/access instructions and any allowed small
   validation datasets. Supply missing full run prompts and annotation database
   checksums if exact replay is claimed.
4. Publish this repository to the chosen public GitHub repository, record its
   commit, and create the fixed paper tag/release from that verified commit.
   Reference the tag and image digest in the manuscript.

The existing `v.1.1.0` Docker image is retained as requested. Its observed software
versions differ from the recorded local environment; server.py hashes match. This
difference is documented rather than silently treating the environments as identical.

The source, MIT license, tool documentation and curated validation records can
be reviewed now. See `PACKAGING_REPORT.md` for checks actually performed during
this preparation and outstanding limitations.
