import Mathlib.Tactic
import Lax303562.Removal

namespace Lax303562Proofs.Removal

open Lax303562.PanopticQuality Lax303562.Removal

/--
---
conclusion: Lax303562.Removal.removal_iff
---
The remaining denominator `D − ½` is positive by hypothesis; clearing both gives
`s · (D − ½) < (s − p j) · D`, i.e. `p j < s / (2D)`.
-/
theorem removal_iff (s p j : ℝ) (n fp fn : ℕ) (hd : 1 / 2 < den n fp fn) :
    pq s n fp fn < pqWithoutPrediction s p j n fp fn ↔ p * j < pq s n fp fn / 2 := by
  have hd0 : (0 : ℝ) < den n fp fn := by linarith
  have hd2 : (0 : ℝ) < den n fp fn - 1 / 2 := by linarith
  unfold pqWithoutPrediction pq
  rw [div_lt_div_iff₀ hd0 hd2, div_div,
      lt_div_iff₀ (by positivity : (0:ℝ) < den n fp fn * 2)]
  constructor
  · intro h; nlinarith
  · intro h; nlinarith

/--
---
conclusion: Lax303562.Removal.lt_of_below
---
-/
theorem lt_of_below (s p j : ℝ) (n fp fn : ℕ) (hd : 1 / 2 < den n fp fn)
    (h : p * j < pq s n fp fn / 2) : pq s n fp fn < pqWithoutPrediction s p j n fp fn :=
  (removal_iff s p j n fp fn hd).mpr h

/--
---
conclusion: Lax303562.Removal.le_of_above
---
-/
theorem le_of_above (s p j : ℝ) (n fp fn : ℕ) (hd : 1 / 2 < den n fp fn)
    (h : pq s n fp fn / 2 ≤ p * j) : pqWithoutPrediction s p j n fp fn ≤ pq s n fp fn := by
  rw [← not_lt]
  intro hc
  exact absurd ((removal_iff s p j n fp fn hd).mp hc) (not_lt.mpr h)

/--
---
conclusion: Lax303562.Removal.removal_inverts_inclusion
---
-/
theorem removal_inverts_inclusion (s p j : ℝ) (n fp fn : ℕ) :
    (s + p * j - p * j) / (den n fp fn + 1 / 2 - 1 / 2) = pq s n fp fn := by
  unfold pq; ring_nf

end Lax303562Proofs.Removal
