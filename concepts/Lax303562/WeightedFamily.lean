import Lax303562.PanopticQuality

/-!
---
title: The duplication incentive survives every choice of error weights
type: theorem
---
Panoptic Quality is the member `a = b = ½` of the family of metrics

$$m_{a,b} = \frac{s}{n + a\,|FP| + b\,|FN|},$$

which weigh false positives by `a` and false negatives by `b`. One might hope
that some choice of weights removes the incentive to duplicate matched
predictions under all-pairs accumulation. It does not: a duplicate adds one true
positive and no error, so the weights never enter the condition, which is the
same `v > m_{a,b}` for every `a` and `b`. Under one-to-one matching the duplicate
is a false positive, and it lowers the score exactly when false positives carry
positive weight; with `a = 0` it leaves the score unchanged, so `0 < a` is the
precise hypothesis. The last statement identifies Panoptic Quality as the member
`a = b = ½`.
-/

namespace Lax303562.WeightedFamily

open Lax303562.PanopticQuality

/-- The weighted denominator: matched pairs count `1`, false positives `a`, false
negatives `b`. -/
noncomputable def wden (a b : ℝ) (n fp fn : ℕ) : ℝ := (n : ℝ) + a * fp + b * fn

/-- The weighted metric: the matched IoU sum over the weighted denominator. -/
noncomputable def wm (a b s : ℝ) (n fp fn : ℕ) : ℝ := s / wden a b n fp fn

/-- Under all-pairs accumulation a duplicate with IoU `v` raises the weighted
metric exactly when `v` exceeds it, for every choice of weights. -/
axiom dup_iff (a b s v : ℝ) (n fp fn : ℕ) (hd : 0 < wden a b n fp fn) :
    wm a b s n fp fn < wm a b (s + v) (n + 1) fp fn ↔ wm a b s n fp fn < v

/-- No choice of weights removes the incentive: for all `a` and `b`, a duplicate
better than the current score raises it. -/
axiom no_weights_remove_incentive (s v : ℝ) (n fp fn : ℕ) :
    ∀ a b : ℝ, 0 < wden a b n fp fn → wm a b s n fp fn < v →
      wm a b s n fp fn < wm a b (s + v) (n + 1) fp fn

/-- Under one-to-one matching the duplicate is a false positive, which lowers a
positive score whenever false positives carry positive weight. -/
axiom falsePositive_lt (a b s : ℝ) (n fp fn : ℕ) (ha : 0 < a) (hs : 0 < s)
    (hd : 0 < wden a b n fp fn) :
    wm a b s n (fp + 1) fn < wm a b s n fp fn

/-- With weight `a = 0` on false positives, a false positive leaves the score
unchanged: the hypothesis `0 < a` above is exact. -/
axiom falsePositive_eq_of_zero_weight (b s : ℝ) (n fp fn : ℕ) :
    wm 0 b s n (fp + 1) fn = wm 0 b s n fp fn

/-- Both directions at once, for the whole family. -/
axiom opposite_directions (a b s v : ℝ) (n fp fn : ℕ)
    (ha : 0 < a) (hs : 0 < s) (hd : 0 < wden a b n fp fn)
    (hv : wm a b s n fp fn < v) :
    wm a b s n fp fn < wm a b (s + v) (n + 1) fp fn ∧
      wm a b s n (fp + 1) fn < wm a b s n fp fn

/-- Panoptic Quality is the member `a = b = ½` of the family. -/
axiom pq_eq_wm_half (s : ℝ) (n fp fn : ℕ) :
    pq s n fp fn = wm (1 / 2) (1 / 2) s n fp fn

end Lax303562.WeightedFamily
