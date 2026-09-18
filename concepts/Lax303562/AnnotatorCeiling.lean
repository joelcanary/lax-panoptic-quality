import Lax303562.PanopticQuality

/-!
---
title: The ceiling imposed by two disagreeing annotators
type: theorem
---
When the same image is annotated twice, with `a` and `b` instances, a prediction
with `m` instances can be scored against both. Its true positives against the
first annotator are at most `a`, and against the second at most `m`. If the
annotators disagree in their counts, `a < b`, the total number of true positives
stays strictly below the combined denominator `m + (a + b)/2`, by a margin of
`(b − a)/2`: half the disagreement.

Since each matched IoU is at most `1`, the combined numerator is at most the
number of true positives, so the combined Panoptic Quality is strictly below `1`
for every prediction. The ceiling is set by the annotators, not by the model.
-/

namespace Lax303562.AnnotatorCeiling

/-- With `a < b` annotated instances and `m` predicted ones, the true positives
against both annotators are strictly fewer than the combined denominator. -/
axiom ceiling_two_annotators (m a b tpA tpB : ℕ)
    (hab : a < b) (hA : tpA ≤ a) (hB : tpB ≤ m) :
    ((tpA : ℝ) + tpB) < (m : ℝ) + ((a : ℝ) + b) / 2

/-- The combined Panoptic Quality against two disagreeing annotators is strictly
below `1`, whatever the prediction. -/
axiom pq_lt_one_of_disagreement (sA sB : ℝ) (m a b tpA tpB : ℕ)
    (hab : a < b) (hA : tpA ≤ a) (hB : tpB ≤ m)
    (hsA : sA ≤ tpA) (hsB : sB ≤ tpB) (hm : 0 < m) :
    (sA + sB) / ((m : ℝ) + ((a : ℝ) + b) / 2) < 1

end Lax303562.AnnotatorCeiling
