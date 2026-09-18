import Lax303562.PanopticQuality

/-!
---
title: Duplicating a matched prediction under all-pairs accumulation
type: theorem
---
Some evaluators accumulate *every* (prediction, annotation) pair whose IoU clears
the threshold, rather than a one-to-one matching. Under that rule a second copy
of an already matched prediction, with IoU `v` against the same annotation, adds
`v` to the numerator and one true positive to the denominator, and creates no
false positive.

The first statement says exactly when this raises the score: if and only if `v`
exceeds the current Panoptic Quality. The second says that under one-to-one
matching the same copy cannot match (its annotation is taken), counts as a false
positive, and strictly lowers the score whenever there is anything to lose. The
third puts the two together: the same submission moves the metric in opposite
directions depending on the counting rule.

Hypotheses: `0 < den n fp fn` says that there is at least one prediction or
annotation, so the quotient is not the empty case.
-/

namespace Lax303562.Duplication

open Lax303562.PanopticQuality

/-- Under all-pairs accumulation, a duplicate with IoU `v` of an already matched
prediction raises the Panoptic Quality exactly when `v` is larger than the
current Panoptic Quality. -/
axiom dup_iff (s v : ℝ) (n fp fn : ℕ) (hd : 0 < den n fp fn) :
    pq s n fp fn < pq (s + v) (n + 1) fp fn ↔ pq s n fp fn < v

/-- Under one-to-one matching the duplicate is a false positive, and any false
positive strictly lowers a positive score. -/
axiom falsePositive_lt (s : ℝ) (n fp fn : ℕ) (hs : 0 < s) (hd : 0 < den n fp fn) :
    pq s n (fp + 1) fn < pq s n fp fn

/-- A duplicate better than the current score raises the metric under all-pairs
accumulation and lowers it under one-to-one matching. -/
axiom opposite_directions (s v : ℝ) (n fp fn : ℕ) (hs : 0 < s) (hd : 0 < den n fp fn)
    (hv : pq s n fp fn < v) :
    pq s n fp fn < pq (s + v) (n + 1) fp fn ∧ pq s n (fp + 1) fn < pq s n fp fn

end Lax303562.Duplication
