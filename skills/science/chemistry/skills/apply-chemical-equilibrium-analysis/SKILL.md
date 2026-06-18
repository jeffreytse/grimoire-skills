---
name: apply-chemical-equilibrium-analysis
description: Use when analyzing chemical equilibria — calculating equilibrium constants, predicting reaction direction using Q vs K, solving for equilibrium concentrations using ICE tables, and applying Le Chatelier's principle to manipulate equilibrium position.
source: Chang & Goldsby "Chemistry" 12th ed. (2016); Atkins & de Paula "Physical Chemistry" 10th ed. (2014); NIST Chemical Thermodynamics Database
tags: [chemical-equilibrium, thermodynamics, ICE-table, Le-Chatelier, equilibrium-constant, reaction-kinetics]
---

# Apply Chemical Equilibrium Analysis

Analyze and predict chemical equilibria by calculating equilibrium constants, determining reaction direction from Q vs K comparison, solving ICE table problems for equilibrium concentrations, and applying Le Chatelier's principle to predict system response to perturbations.

## Why This Is Best Practice

**Adopted by:** Chemical equilibrium analysis is foundational to industrial process optimization (Haber-Bosch for ammonia, Contact process for sulfuric acid), pharmaceutical formulation stability, environmental chemistry (buffering, solubility), and biochemistry (enzyme kinetics, Henderson-Hasselbalch). IUPAC defines equilibrium constants and their thermodynamic basis; NIST maintains the authoritative database of thermodynamic data for equilibrium calculations.
**Impact:** The Haber-Bosch process — which feeds ~50% of Earth's population — was optimized using equilibrium analysis. Fritz Haber's recognition that high pressure favors NH₃ formation (Le Chatelier) while high temperature increases rate (Arrhenius) led to the compromise conditions (200 atm, 450°C) used industrially. Pharmaceutical formulation relies on equilibrium analysis for pH stability, solubility prediction, and buffer design — failures cause drug precipitation, reduced bioavailability, and stability failures.

## Steps

### 1. Write the balanced equilibrium expression

For any reaction: aA + bB ⇌ cC + dD

Equilibrium constant expression:
```
Kc = [C]^c [D]^d / [A]^a [B]^b
```
Rules:
- Include only species in solution or gas phase — pure solids and pure liquids omitted (activity = 1)
- For gas-phase equilibria: use partial pressures → Kp
- Relationship: Kp = Kc(RT)^Δn  where Δn = moles gas products − moles gas reactants

### 2. Determine K from thermodynamic data

If K is not tabulated, calculate from standard Gibbs free energy:
```
ΔG°rxn = Σ ΔGf°(products) − Σ ΔGf°(reactants)
K = e^(−ΔG°rxn / RT)
```
Where R = 8.314 J/mol·K and T in Kelvin.

Or combine known equilibria:
```
Hess's law for K: if reaction = reaction 1 + reaction 2:
K = K₁ × K₂
If reaction is reversed: K_new = 1/K_old
If reaction is multiplied by n: K_new = K^n
```

### 3. Compare Q to K to predict reaction direction

Reaction quotient Q has the same form as K but uses initial concentrations:
```
Q < K: reaction proceeds forward (toward products)
Q > K: reaction proceeds reverse (toward reactants)
Q = K: system is at equilibrium
```

This is the first calculation to perform before setting up an ICE table — it confirms the direction of progress.

### 4. Solve for equilibrium concentrations using ICE tables

ICE = Initial, Change, Equilibrium

| Species | A | B | C | D |
|---------|---|---|---|---|
| Initial | [A]₀ | [B]₀ | [C]₀ | [D]₀ |
| Change | −ax | −bx | +cx | +dx |
| Equilibrium | [A]₀−ax | [B]₀−bx | [C]₀+cx | [D]₀+dx |

Substitute equilibrium row into K expression; solve for x.

**Simplification:** if K is very small (<10⁻³) and initial concentrations are large, the 5% approximation applies:
```
Assume x << [A]₀: [A]₀ − ax ≈ [A]₀
Check: x/[A]₀ < 0.05 → approximation valid; if >0.05, solve quadratic exactly
```

### 5. Apply Le Chatelier's principle to shift equilibrium

Predict system response to perturbations:
- **Increase concentration of reactant:** equilibrium shifts right (toward products)
- **Increase concentration of product:** equilibrium shifts left (toward reactants)
- **Increase pressure (gas-phase):** shifts toward side with fewer moles of gas
- **Increase temperature:** shifts toward endothermic direction (increases K for endothermic; decreases K for exothermic)
- **Add catalyst:** does NOT shift equilibrium; only increases rate of reaching equilibrium

Note: temperature changes K value itself; other perturbations shift position but not K.

### 6. Apply to common equilibrium types

**Acid-base (Ka, Kb):**
```
pH = pKa + log([A⁻]/[HA])  (Henderson-Hasselbalch)
Buffer capacity maximum at pH = pKa ± 1
```

**Solubility (Ksp):**
```
For AB: Ksp = [A⁺][B⁻]
Common ion effect: adding A⁺ decreases solubility of AB (Q > Ksp → precipitation)
```

**Complex formation (Kf):**
```
Large Kf (>10⁶): nearly complete complexation at stoichiometric amounts
```

## Common Mistakes

- **Including pure liquids or solids in the K expression:** Water (in aqueous solution) and solid precipitates have activity = 1 and are excluded from K.
- **Confusing K and Q:** K is the equilibrium constant (fixed at given T); Q is calculated from current concentrations and determines direction of progress.
- **Not checking the 5% approximation:** If x/[A]₀ > 5%, the simplification is invalid and the quadratic must be solved exactly.

## When NOT to Use

- Systems far from equilibrium with fast kinetics: kinetics (not thermodynamics) determines the outcome — equilibrium analysis predicts final state but not whether it will be reached in a practical timeframe.
