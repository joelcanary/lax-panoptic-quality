import Mathlib.Tactic
import Lax303562.Matching

namespace Lax303562Proofs.Matching

open Finset Lax303562.Matching

/-- Overlapping more than half with `A` forces the overlap to cover more than half
of `P`. -/
lemma card_inter_gt_of_iou {α : Type*} [DecidableEq α] (P A : Finset α)
    (h : (1 : ℝ) / 2 < iou P A) :
    (P.card : ℝ) < 2 * ((P ∩ A).card : ℝ) := by
  unfold iou at h
  have hu : (0 : ℝ) < ((P ∪ A).card : ℝ) := by
    rcases Nat.eq_zero_or_pos (P ∪ A).card with h0 | hpos
    · rw [h0] at h; norm_num at h
    · exact_mod_cast hpos
  have hle : (P.card : ℝ) ≤ ((P ∪ A).card : ℝ) := by
    exact_mod_cast card_le_card subset_union_left
  rw [div_lt_div_iff₀ (by norm_num : (0:ℝ) < 2) hu] at h
  linarith

/--
---
conclusion: Lax303562.Matching.matches_at_most_one
---
If `P` overlapped more than half with each of two disjoint sets, the two
overlaps, which are disjoint subsets of `P`, would together exceed `P`.
-/
theorem matches_at_most_one {α : Type*} [DecidableEq α] (P A B : Finset α)
    (hAB : Disjoint A B) (hA : (1 : ℝ) / 2 < iou P A) (hB : (1 : ℝ) / 2 < iou P B) :
    False := by
  have hpa := card_inter_gt_of_iou P A hA
  have hpb := card_inter_gt_of_iou P B hB
  have hdis : Disjoint (P ∩ A) (P ∩ B) :=
    (hAB.mono inter_subset_right inter_subset_right)
  have hsub : (P ∩ A) ∪ (P ∩ B) ⊆ P := union_subset inter_subset_left inter_subset_left
  have hcard : ((P ∩ A).card : ℝ) + ((P ∩ B).card : ℝ) ≤ (P.card : ℝ) := by
    have : (P ∩ A).card + (P ∩ B).card = ((P ∩ A) ∪ (P ∩ B)).card :=
      (card_union_of_disjoint hdis).symm
    have h2 : ((P ∩ A) ∪ (P ∩ B)).card ≤ P.card := card_le_card hsub
    exact_mod_cast this ▸ h2
  linarith

/-- The witness: a two-element set has IoU exactly `½` with a four-element
superset. -/
lemma iou_witness : iou ({1, 2} : Finset ℕ) ({1, 2, 3, 4} : Finset ℕ) = 1 / 2 := by
  unfold iou
  norm_num [Finset.inter_comm]

/--
---
conclusion: Lax303562.Matching.ties_at_half
---
`P = {1,2,3,4}` has IoU exactly `½` with `A = {1,2}` and with `B = {3,4}`.
-/
theorem ties_at_half :
    ∃ (P A B : Finset ℕ), Disjoint A B ∧ (1 : ℝ) / 2 ≤ iou P A ∧ (1 : ℝ) / 2 ≤ iou P B := by
  refine ⟨{1, 2, 3, 4}, {1, 2}, {3, 4}, by decide, ?_, ?_⟩
  · rw [show iou ({1,2,3,4} : Finset ℕ) {1,2} = iou ({1,2} : Finset ℕ) {1,2,3,4} by
      unfold iou; rw [Finset.inter_comm, Finset.union_comm]]
    rw [iou_witness]
  · rw [show iou ({1,2,3,4} : Finset ℕ) {3,4} = 1 / 2 by
      unfold iou; norm_num]

/--
---
conclusion: Lax303562.Matching.threshold_sharp
---
-/
theorem threshold_sharp :
    (∀ (P A B : Finset ℕ), Disjoint A B → (1 : ℝ) / 2 < iou P A →
        (1 : ℝ) / 2 < iou P B → False)
    ∧ ¬ (∀ (P A B : Finset ℕ), Disjoint A B → (1 : ℝ) / 2 ≤ iou P A →
        (1 : ℝ) / 2 ≤ iou P B → False) := by
  refine ⟨fun P A B hAB hA hB => matches_at_most_one P A B hAB hA hB, ?_⟩
  intro h
  obtain ⟨P, A, B, hAB, hA, hB⟩ := ties_at_half
  exact h P A B hAB hA hB

end Lax303562Proofs.Matching
