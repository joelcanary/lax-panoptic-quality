import Mathlib.Data.Finset.Card
import Mathlib.Data.Real.Basic

/-!
---
title: Matching by intersection over union and the sharpness of the threshold ½
type: theorem
---
Instances are finite sets of pixels. The intersection over union of two such sets
is the size of their intersection over the size of their union (with the
convention that the IoU of two empty sets is `0`). A prediction is matched to an
annotation when their IoU exceeds a threshold, and the published metric uses the
threshold `½` with a strict inequality.

The first statement is why this threshold makes the matching unambiguous on the
annotation side: distinct annotations of one image are disjoint, and no
prediction can exceed IoU `½` with two disjoint sets. The second statement shows
that the strictness is necessary: with `≥ ½` a prediction can tie the threshold
with two disjoint annotations. The third states both at once: `½` is the infimum
of the thresholds under which a prediction matches at most one annotation.
-/

namespace Lax303562.Matching

/-- Intersection over union of two finite sets; `0` when both are empty. -/
noncomputable def iou {α : Type*} [DecidableEq α] (X Y : Finset α) : ℝ :=
  ((X ∩ Y).card : ℝ) / ((X ∪ Y).card : ℝ)

/-- No prediction has IoU strictly above `½` with two disjoint annotations. -/
axiom matches_at_most_one {α : Type*} [DecidableEq α] (P A B : Finset α)
    (hAB : Disjoint A B) (hA : (1 : ℝ) / 2 < iou P A) (hB : (1 : ℝ) / 2 < iou P B) :
    False

/-- With the non-strict threshold `≥ ½` a prediction can tie with two disjoint
annotations. -/
axiom ties_at_half :
    ∃ (P A B : Finset ℕ), Disjoint A B ∧ (1 : ℝ) / 2 ≤ iou P A ∧ (1 : ℝ) / 2 ≤ iou P B

/-- The threshold `½` is sharp: strictly above it the matching is unambiguous,
and at `½` it is not. -/
axiom threshold_sharp :
    (∀ (P A B : Finset ℕ), Disjoint A B → (1 : ℝ) / 2 < iou P A →
        (1 : ℝ) / 2 < iou P B → False)
    ∧ ¬ (∀ (P A B : Finset ℕ), Disjoint A B → (1 : ℝ) / 2 ≤ iou P A →
        (1 : ℝ) / 2 ≤ iou P B → False)

end Lax303562.Matching
