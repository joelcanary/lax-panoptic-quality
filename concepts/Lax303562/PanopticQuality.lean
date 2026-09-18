import Mathlib.Data.Real.Basic

/-!
---
title: Panoptic Quality as a function of its four counts
type: definition
---
The *Panoptic Quality* of an instance segmentation (Kirillov et al., 2019) scores
a set of predicted instances against a set of annotated instances. Predictions and
annotations are matched by intersection over union; a matched pair is a *true
positive*, an unmatched prediction a *false positive*, an unmatched annotation a
*false negative*. The metric is

$$\mathrm{PQ} = \frac{\sum_{\text{matched pairs}} \mathrm{IoU}}{|TP| + \tfrac12 |FP| + \tfrac12 |FN|}.$$

Everything in this submission is a statement about this quotient as a function of
four numbers: the sum `s` of the matched IoUs, the number `n` of matched pairs,
and the counts `fp` and `fn` of false positives and false negatives. How the
matching is produced is a separate question, treated in `Matching`.

The denominator is defined on its own because every result below is an exact
statement about how it moves when one count changes.
-/

namespace Lax303562.PanopticQuality

/-- The denominator of Panoptic Quality: matched pairs count `1`, unmatched
predictions and unmatched annotations count `½` each. -/
noncomputable def den (n fp fn : ℕ) : ℝ := (n : ℝ) + (fp + fn) / 2

/-- Panoptic Quality: the sum `s` of the matched IoUs over the denominator. -/
noncomputable def pq (s : ℝ) (n fp fn : ℕ) : ℝ := s / den n fp fn

end Lax303562.PanopticQuality
