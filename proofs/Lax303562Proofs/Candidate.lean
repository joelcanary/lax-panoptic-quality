import Mathlib.Tactic
import Lax303562.Candidate

namespace Lax303562Proofs.Candidate

open Lax303562.PanopticQuality Lax303562.Candidate

/--
---
conclusion: Lax303562.Candidate.candidate_iff
---
Both denominators are positive; clearing them gives `s · (D + ½) < (s + p j) · D`,
i.e. `s / (2D) < p j`.
-/
theorem candidate_iff (s p j : ℝ) (n fp fn : ℕ) (hd : 0 < den n fp fn) :
    pq s n fp fn < pqWithCandidate s p j n fp fn ↔ pq s n fp fn / 2 < p * j := by
  have hd2 : (0 : ℝ) < den n fp fn + 1 / 2 := by linarith
  unfold pqWithCandidate pq
  rw [div_lt_div_iff₀ hd hd2, div_div,
      div_lt_iff₀ (by positivity : (0:ℝ) < den n fp fn * 2)]
  constructor
  · intro h; nlinarith
  · intro h; nlinarith

/--
---
conclusion: Lax303562.Candidate.lt_of_above
---
-/
theorem lt_of_above (s p j : ℝ) (n fp fn : ℕ) (hd : 0 < den n fp fn)
    (h : pq s n fp fn / 2 < p * j) : pq s n fp fn < pqWithCandidate s p j n fp fn :=
  (candidate_iff s p j n fp fn hd).mpr h

/--
---
conclusion: Lax303562.Candidate.le_of_below
---
-/
theorem le_of_below (s p j : ℝ) (n fp fn : ℕ) (hd : 0 < den n fp fn)
    (h : p * j ≤ pq s n fp fn / 2) : pqWithCandidate s p j n fp fn ≤ pq s n fp fn := by
  rw [← not_lt]
  intro hc
  exact absurd ((candidate_iff s p j n fp fn hd).mp hc) (not_lt.mpr h)

/--
---
conclusion: Lax303562.Candidate.equilibrium
---
Divide the inclusion rule by the positive IoU `j`.
-/
theorem equilibrium (s p j : ℝ) (n fp fn : ℕ) (hd : 0 < den n fp fn) (hj : 0 < j) :
    pq s n fp fn < pqWithCandidate s p j n fp fn ↔ pq s n fp fn / (2 * j) < p := by
  rw [candidate_iff s p j n fp fn hd,
      div_lt_iff₀ (by norm_num : (0:ℝ) < 2),
      div_lt_iff₀ (by positivity : (0:ℝ) < 2 * j)]
  constructor
  · intro h; nlinarith
  · intro h; nlinarith

end Lax303562Proofs.Candidate
