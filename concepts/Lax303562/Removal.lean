import Lax303562.PanopticQuality

/-!
---
title: The removal rule for a prediction already in the list
type: theorem
---
The mirror image of the inclusion rule. A prediction already in the list
contributes `p · j` to the numerator (probability `p` of being matched, IoU `j`
when it is) and exactly `½` to the denominator in both cases: removing a matched
one turns a true positive into a false negative (net `−½`), removing an unmatched
one deletes a false positive (`−½`). The score after removal is the exact
quotient `pqWithoutPrediction`.

Removing the prediction raises the Panoptic Quality if and only if its
contribution is below half the current score. The hypothesis `½ < den n fp fn`
says that something remains after the removal, so the new denominator is
positive. The last statement closes the circuit with `Candidate`: removing what
inclusion added returns the original score.
-/

namespace Lax303562.Removal

open Lax303562.PanopticQuality

/-- The Panoptic Quality after removing a prediction that contributed `p · j` to
the numerator and `½` to the denominator. -/
noncomputable def pqWithoutPrediction (s p j : ℝ) (n fp fn : ℕ) : ℝ :=
  (s - p * j) / (den n fp fn - 1 / 2)

/-- Removing the prediction raises the score if and only if `p · j < PQ / 2`. -/
axiom removal_iff (s p j : ℝ) (n fp fn : ℕ) (hd : 1 / 2 < den n fp fn) :
    pq s n fp fn < pqWithoutPrediction s p j n fp fn ↔ p * j < pq s n fp fn / 2

/-- Below the threshold, removal raises the score. -/
axiom lt_of_below (s p j : ℝ) (n fp fn : ℕ) (hd : 1 / 2 < den n fp fn)
    (h : p * j < pq s n fp fn / 2) : pq s n fp fn < pqWithoutPrediction s p j n fp fn

/-- At or above the threshold, removal does not raise the score. -/
axiom le_of_above (s p j : ℝ) (n fp fn : ℕ) (hd : 1 / 2 < den n fp fn)
    (h : pq s n fp fn / 2 ≤ p * j) : pqWithoutPrediction s p j n fp fn ≤ pq s n fp fn

/-- Inclusion followed by removal of the same prediction returns the original
score. -/
axiom removal_inverts_inclusion (s p j : ℝ) (n fp fn : ℕ) :
    (s + p * j - p * j) / (den n fp fn + 1 / 2 - 1 / 2) = pq s n fp fn

end Lax303562.Removal
