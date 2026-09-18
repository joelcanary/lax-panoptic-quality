import Mathlib.Tactic
import Lax303562.WeightedFamily

namespace Lax303562Proofs.WeightedFamily

open Lax303562.PanopticQuality Lax303562.WeightedFamily

/-- One more matched pair raises the weighted denominator by exactly `1`, whatever
the weights: they only touch `fp` and `fn`. -/
lemma wden_succ (a b : ℝ) (n fp fn : ℕ) :
    wden a b (n + 1) fp fn = wden a b n fp fn + 1 := by
  unfold wden; push_cast; ring

/-- One more false positive raises the weighted denominator by `a`. -/
lemma wden_fp (a b : ℝ) (n fp fn : ℕ) :
    wden a b n (fp + 1) fn = wden a b n fp fn + a := by
  unfold wden; push_cast; ring

/--
---
conclusion: Lax303562.WeightedFamily.dup_iff
---
The same computation as for Panoptic Quality: the weights never enter, because a
duplicate creates no false positive and no false negative.
-/
theorem dup_iff (a b s v : ℝ) (n fp fn : ℕ) (hd : 0 < wden a b n fp fn) :
    wm a b s n fp fn < wm a b (s + v) (n + 1) fp fn ↔ wm a b s n fp fn < v := by
  have hd1 : (0 : ℝ) < wden a b n fp fn + 1 := by linarith
  unfold wm
  rw [wden_succ, div_lt_div_iff₀ hd hd1, div_lt_iff₀ hd]
  constructor
  · intro h; nlinarith
  · intro h; nlinarith

/--
---
conclusion: Lax303562.WeightedFamily.no_weights_remove_incentive
---
-/
theorem no_weights_remove_incentive (s v : ℝ) (n fp fn : ℕ) :
    ∀ a b : ℝ, 0 < wden a b n fp fn → wm a b s n fp fn < v →
      wm a b s n fp fn < wm a b (s + v) (n + 1) fp fn := by
  intro a b hd hv
  exact (dup_iff a b s v n fp fn hd).mpr hv

/--
---
conclusion: Lax303562.WeightedFamily.falsePositive_lt
---
-/
theorem falsePositive_lt (a b s : ℝ) (n fp fn : ℕ) (ha : 0 < a) (hs : 0 < s)
    (hd : 0 < wden a b n fp fn) :
    wm a b s n (fp + 1) fn < wm a b s n fp fn := by
  have hd2 : (0 : ℝ) < wden a b n fp fn + a := by linarith
  unfold wm
  rw [wden_fp, div_lt_div_iff₀ hd2 hd]
  nlinarith

/--
---
conclusion: Lax303562.WeightedFamily.falsePositive_eq_of_zero_weight
---
-/
theorem falsePositive_eq_of_zero_weight (b s : ℝ) (n fp fn : ℕ) :
    wm 0 b s n (fp + 1) fn = wm 0 b s n fp fn := by
  unfold wm
  rw [wden_fp, add_zero]

/--
---
conclusion: Lax303562.WeightedFamily.opposite_directions
---
-/
theorem opposite_directions (a b s v : ℝ) (n fp fn : ℕ)
    (ha : 0 < a) (hs : 0 < s) (hd : 0 < wden a b n fp fn)
    (hv : wm a b s n fp fn < v) :
    wm a b s n fp fn < wm a b (s + v) (n + 1) fp fn ∧
      wm a b s n (fp + 1) fn < wm a b s n fp fn :=
  ⟨(dup_iff a b s v n fp fn hd).mpr hv, falsePositive_lt a b s n fp fn ha hs hd⟩

/--
---
conclusion: Lax303562.WeightedFamily.pq_eq_wm_half
---
-/
theorem pq_eq_wm_half (s : ℝ) (n fp fn : ℕ) :
    pq s n fp fn = wm (1 / 2) (1 / 2) s n fp fn := by
  unfold pq wm den wden
  congr 1
  ring

end Lax303562Proofs.WeightedFamily
