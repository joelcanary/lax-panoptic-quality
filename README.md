# Panoptic Quality: exact rules for inclusion, removal and duplication, the sharpness of the matching threshold, and the annotator ceiling

**Lax Lean Archive record [`lax-303562`](https://laxarchive.org/lax-303562/)** — registered, permanent and citable.
Every statement in `concepts/` is proved in `proofs/` with no assumptions: **22 of 22 statements proved**,
rebuilt by the archive on its own machines against a pinned Mathlib before registration.

Panoptic Quality (Kirillov et al., 2019) scores an instance segmentation as the sum of the matched intersection-over-union values over $|TP| + \tfrac12|FP| + \tfrac12|FN|$. This submission treats the metric as a function of those four counts and proves the exact identities that govern how it moves when one prediction is added, removed, or duplicated.

The inclusion rule: a candidate that matches with probability $p$ and IoU $j$ raises the expected score if and only if $p\,j > \mathrm{PQ}/2$, because the denominator rises by exactly $\tfrac12$ whether the candidate matches or not. The removal rule is its mirror image, and the two are inverse. Under evaluators that accumulate every pair above the threshold instead of a one-to-one matching, a duplicate of a matched prediction with IoU $v$ raises the score if and only if $v > \mathrm{PQ}$, and no reweighting of false positives and false negatives removes this incentive; under one-to-one matching the same duplicate is a false positive and lowers the score exactly when false positives carry positive weight.

Two further statements concern the matching itself and the data. With the strict threshold $\mathrm{IoU} > \tfrac12$ a prediction matches at most one of any family of disjoint annotations, and the threshold is sharp: at $\tfrac12$ a prediction can tie with two. When two annotators of the same image disagree in their instance counts, the Panoptic Quality of any prediction scored against both is strictly below $1$, by a margin of half the disagreement.

All statements are elementary and their proofs are short; their value is that a competition, a benchmark, or a paper can cite the exact condition rather than an intuition. They were used to select the operating point of a solar-filament segmentation pipeline and to diagnose a metric-inflating evaluator.

## What is inside

| Concept | Type | Title | Proved / stated |
|---|---|---|---|
| `AnnotatorCeiling` | theorem | The ceiling imposed by two disagreeing annotators | 2 / 2 |
| `Candidate` | theorem | The inclusion rule for a candidate prediction | 4 / 4 |
| `Duplication` | theorem | Duplicating a matched prediction under all-pairs accumulation | 3 / 3 |
| `Matching` | theorem | Matching by intersection over union and the sharpness of the threshold ½ | 3 / 3 |
| `PanopticQuality` | definition | Panoptic Quality as a function of its four counts | 0 / 0 |
| `Removal` | theorem | The removal rule for a prediction already in the list | 4 / 4 |
| `WeightedFamily` | theorem | The duplication incentive survives every choice of error weights | 6 / 6 |

Each concept file states its results as `axiom`s beside a natural-language description
(that is the archive's format: statements are separated from proofs); the proof of each
one lives in `proofs/` and is checked by the Lean kernel. `build-output.json` is the
archive's own build record for this source commit.

## How to cite

In LaTeX, cite the record id: `\cite{lax-303562}`. The archive resolves it to the exact
statements and proofs, and a registered record cannot change under the citation
(a correction would be a new record that supersedes this one).

```bibtex
@misc{lax303562,
  author = {Cruz Cabrera, Joel},
  title = {Panoptic Quality: exact rules for inclusion, removal and duplication, the sharpness of the matching threshold, and the annotator ceiling},
  year = {2026},
  howpublished = {Lax Lean Archive, record lax-303562},
  url = {https://laxarchive.org/lax-303562/}
}
```

Author: Joel Cruz Cabrera, ORCID [0009-0005-4048-1237](https://orcid.org/0009-0005-4048-1237).

## Rebuilding it

```bash
npm install -g lax-archive
lax build          # Lean v4.33.0, Mathlib db584cd6d46c
```

The pins are in `manifest.yaml`; the archive's build of this commit
(`4db471d`) is recorded in `build-output.json`
(`archiveSha` `702c69945e88`).

## Related

- The four records and their live counts: https://kodamaseclabs.com/publications
- Used to choose the operating point of a solar-filament segmentation pipeline (IEEE Big Data Cup 2026) and to diagnose a metric-inflating evaluator.

## Use of AI

An AI tool (an agent running on the author's machine) wrote the Lean under the
author's direction; the author set the statements, reviewed every declaration
and checked the build before submitting. The archive then rebuilt everything
independently. What is proved is exactly what the kernel accepted, no more.

## License

Apache-2.0 (the archive's required license), see `LICENSE`.

<details><summary>BibTeX entries the record itself cites</summary>

```bibtex

```
</details>
