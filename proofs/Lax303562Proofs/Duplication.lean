import Mathlib.Tactic
import Lax303562.Duplication

namespace Lax303562Proofs.Duplication

open Lax303562.PanopticQuality

/-- One more matched pair raises the denominator by exactly `1`. -/
lemma den_succ (n fp fn : ℕ) : den (n + 1) fp fn = den n fp fn + 1 := by
  unfold den; push_cast; ring

/-- One more false positive raises the denominator by exactly `½`. -/
lemma den_fp (n fp fn : ℕ) : den n (fp + 1) fn = den n fp fn + 1 / 2 := by
  unfold den; push_cast; ring

/--
---
conclusion: Lax303562.Duplication.dup_iff
---
Clearing the two positive denominators turns the comparison of quotients into
`s · (D + 1) < (s + v) · D`, i.e. `s < v · D`, which is `s / D < v`.
-/
theorem dup_iff (s v : ℝ) (n fp fn : ℕ) (hd : 0 < den n fp fn) :
    pq s n fp fn < pq (s + v) (n + 1) fp fn ↔ pq s n fp fn < v := by
  have hd1 : (0 : ℝ) < den n fp fn + 1 := by linarith
  unfold pq
  rw [den_succ, div_lt_div_iff₀ hd hd1, div_lt_iff₀ hd]
  constructor
  · intro h; nlinarith
  · intro h; nlinarith

/--
---
conclusion: Lax303562.Duplication.falsePositive_lt
---
The numerator is unchanged and the denominator grows by `½`.
-/
theorem falsePositive_lt (s : ℝ) (n fp fn : ℕ) (hs : 0 < s) (hd : 0 < den n fp fn) :
    pq s n (fp + 1) fn < pq s n fp fn := by
  have hd2 : (0 : ℝ) < den n fp fn + 1 / 2 := by linarith
  unfold pq
  rw [den_fp, div_lt_div_iff₀ hd2 hd]
  nlinarith

/--
---
conclusion: Lax303562.Duplication.opposite_directions
---
-/
theorem opposite_directions (s v : ℝ) (n fp fn : ℕ) (hs : 0 < s) (hd : 0 < den n fp fn)
    (hv : pq s n fp fn < v) :
    pq s n fp fn < pq (s + v) (n + 1) fp fn ∧ pq s n (fp + 1) fn < pq s n fp fn :=
  ⟨(dup_iff s v n fp fn hd).mpr hv, falsePositive_lt s n fp fn hs hd⟩

end Lax303562Proofs.Duplication
