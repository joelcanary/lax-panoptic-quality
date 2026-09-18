import Lax303562.PanopticQuality

/-!
---
title: The inclusion rule for a candidate prediction
type: theorem
---
A candidate prediction is included or not before the score is computed. Suppose
it will match some annotation with probability `p` and, when it does, with IoU
`j`. Whether it matches or not, the denominator rises by exactly `½`: a match
turns a false negative into a true positive (`n + 1`, `fn − 1`, net `+½`), a miss
adds a false positive (`+½`). The expected score after inclusion is therefore
the exact quotient `pqWithCandidate`.

The main statement is the inclusion rule: including the candidate raises the
expected Panoptic Quality if and only if its expected contribution `p · j`
exceeds half the current score. The remaining statements are the two directions
in the form in which a decision procedure uses them, and the same rule solved for
the match probability.
-/

namespace Lax303562.Candidate

open Lax303562.PanopticQuality

/-- The expected Panoptic Quality after including a candidate that matches with
probability `p` and, when it matches, with IoU `j`. -/
noncomputable def pqWithCandidate (s p j : ℝ) (n fp fn : ℕ) : ℝ :=
  (s + p * j) / (den n fp fn + 1 / 2)

/-- Including the candidate raises the expected score if and only if
`p · j > PQ / 2`. -/
axiom candidate_iff (s p j : ℝ) (n fp fn : ℕ) (hd : 0 < den n fp fn) :
    pq s n fp fn < pqWithCandidate s p j n fp fn ↔ pq s n fp fn / 2 < p * j

/-- Above the threshold the candidate raises the score. -/
axiom lt_of_above (s p j : ℝ) (n fp fn : ℕ) (hd : 0 < den n fp fn)
    (h : pq s n fp fn / 2 < p * j) : pq s n fp fn < pqWithCandidate s p j n fp fn

/-- At or below the threshold the candidate does not raise the score. -/
axiom le_of_below (s p j : ℝ) (n fp fn : ℕ) (hd : 0 < den n fp fn)
    (h : p * j ≤ pq s n fp fn / 2) : pqWithCandidate s p j n fp fn ≤ pq s n fp fn

/-- The rule solved for the match probability: for a positive IoU `j`, the
candidate raises the score if and only if `p > PQ / (2 j)`. -/
axiom equilibrium (s p j : ℝ) (n fp fn : ℕ) (hd : 0 < den n fp fn) (hj : 0 < j) :
    pq s n fp fn < pqWithCandidate s p j n fp fn ↔ pq s n fp fn / (2 * j) < p

end Lax303562.Candidate
