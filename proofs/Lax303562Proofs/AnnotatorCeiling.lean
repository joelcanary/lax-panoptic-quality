import Mathlib.Tactic
import Lax303562.AnnotatorCeiling

namespace Lax303562Proofs.AnnotatorCeiling

/--
---
conclusion: Lax303562.AnnotatorCeiling.ceiling_two_annotators
---
`tpA ≤ a`, `tpB ≤ m` and `a < b` give `tpA + tpB < m + (a + b)/2` with margin
`(b − a)/2`.
-/
theorem ceiling_two_annotators (m a b tpA tpB : ℕ)
    (hab : a < b) (hA : tpA ≤ a) (hB : tpB ≤ m) :
    ((tpA : ℝ) + tpB) < (m : ℝ) + ((a : ℝ) + b) / 2 := by
  have h1 : (tpA : ℝ) ≤ (a : ℝ) := by exact_mod_cast hA
  have h2 : (tpB : ℝ) ≤ (m : ℝ) := by exact_mod_cast hB
  have h3 : (a : ℝ) < (b : ℝ) := by exact_mod_cast hab
  linarith

/--
---
conclusion: Lax303562.AnnotatorCeiling.pq_lt_one_of_disagreement
---
Each matched IoU is at most `1`, so the numerator is at most the number of true
positives, which the previous statement bounds below the denominator.
-/
theorem pq_lt_one_of_disagreement (sA sB : ℝ) (m a b tpA tpB : ℕ)
    (hab : a < b) (hA : tpA ≤ a) (hB : tpB ≤ m)
    (hsA : sA ≤ tpA) (hsB : sB ≤ tpB) (hm : 0 < m) :
    (sA + sB) / ((m : ℝ) + ((a : ℝ) + b) / 2) < 1 := by
  have hden : (0 : ℝ) < (m : ℝ) + ((a : ℝ) + b) / 2 := by
    have : (0 : ℝ) < (m : ℝ) := by exact_mod_cast hm
    positivity
  rw [div_lt_one hden]
  have := ceiling_two_annotators m a b tpA tpB hab hA hB
  linarith

end Lax303562Proofs.AnnotatorCeiling
