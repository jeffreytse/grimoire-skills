---
name: design-titration-experiment
description: Use when designing an acid-base, redox, complexometric, or precipitation titration — including titrant selection, indicator choice, endpoint detection, and standardization of solutions for accurate quantitative analysis.
source: Harris "Quantitative Chemical Analysis" 9th ed. (2016); Skoog et al. "Fundamentals of Analytical Chemistry" 9th ed. (2014); IUPAC recommendations on titrimetric analysis
tags: [titration, analytical-chemistry, acid-base, redox, endpoint-detection, standardization, quantitative-analysis]
---

# Design Titration Experiment

Design an accurate titrimetric analysis by selecting the appropriate titration type, standardizing the titrant, choosing a suitable indicator or instrumental endpoint, and applying correct stoichiometry to calculate analyte concentration.

## Why This Is Best Practice

**Adopted by:** Titrimetric methods are the backbone of USP/EP pharmaceutical testing (acid value, base value, Karl Fischer moisture), food safety testing (acidity, vitamin C content), environmental monitoring (alkalinity, hardness), and industrial quality control. ISO 8655 governs pipette accuracy for titrimetry; ASTM publishes standardized titration methods for petroleum and polymer industries.
**Impact:** Harris (2016) demonstrates that a well-designed titration can achieve ±0.1% relative precision — among the most accurate of all analytical techniques. The primary failure modes (unstandardized titrant, wrong indicator, endpoint detection error) are all eliminated by systematic design. USP requires titrant standardization before use for all compendial titrations.

## Steps

### 1. Select the titration type

Match to the chemistry of the analyte:
- **Acid-base:** neutralization reaction; HCl (strong acid) or NaOH (strong base) titrant; use pH indicator or potentiometric endpoint
- **Redox:** oxidation-reduction; KMnO₄, Ce(IV), Na₂S₂O₃, or iodine titrant; use redox indicator or potentiometric endpoint
- **Complexometric (EDTA):** metal ion determination; EDTA disodium titrant; use metallochromic indicator (Eriochrome Black T) or potentiometric endpoint
- **Precipitation:** Ag⁺ for halides; argentometric titration; use Mohr, Fajans, or Volhard method
- **Non-aqueous:** for very weak acids/bases; acetic acid or acetonitrile solvent; use perchloric acid or tetrabutylammonium hydroxide titrant

### 2. Standardize the titrant

Every titrant must be standardized against a primary standard before use:
- **NaOH:** standardize against potassium hydrogen phthalate (KHP); MW = 204.23 g/mol; dry at 110°C for 2h
- **HCl:** standardize against anhydrous Na₂CO₃ or tris(hydroxymethyl)aminomethane (TRIS)
- **KMnO₄:** standardize against sodium oxalate (Na₂C₂O₄)
- **Na₂S₂O₃:** standardize against potassium iodate (KIO₃) via indirect iodometry
- **EDTA:** standardize against CaCO₃ primary standard

Calculation:
```
Concentration (M) = moles of primary standard / volume of titrant used (L)
Perform in triplicate; RSD of titrant concentration must be ≤0.1%
```

### 3. Select the indicator

Match indicator pKa to equivalence point pH (acid-base titrations):
| Titration type | Equivalence point pH | Suitable indicator |
|---|---|---|
| Strong acid / strong base | 7.0 | Phenolphthalein (8.2-10.0) or bromothymol blue |
| Weak acid / strong base | >7 (pH 8-9) | Phenolphthalein |
| Strong acid / weak base | <7 (pH 4-6) | Methyl red or methyl orange |
| Weak acid / weak base | Difficult; use potentiometry | — |

Indicator endpoint vs. equivalence point: indicator error is minimized when pKa(indicator) ≈ pH at equivalence point.

For redox: use starch indicator for iodometric titrations (blue→colorless endpoint); KMnO₄ is self-indicating (pink endpoint).

### 4. Plan the measurement procedure

Standard procedure for accurate titrimetry:
1. Rinse burette with titrant before filling (to prevent dilution)
2. Remove air bubble from burette tip before starting
3. Record initial volume to 0.01 mL precision (for a 50 mL Class A burette)
4. Add titrant rapidly to ~90% of expected endpoint, then dropwise near endpoint
5. Perform blank titration (same indicator, no analyte) — subtract blank volume
6. Perform minimum 3 replicates; accept if range ≤0.04 mL for a 50 mL burette

### 5. Calculate analyte concentration

General stoichiometry:
```
moles analyte = moles titrant × (stoichiometric ratio)
Concentration analyte (M) = moles analyte / volume analyte (L)
```

Example: titration of 25.00 mL unknown HCl with 0.1000 M NaOH; endpoint at 22.35 mL:
```
moles NaOH = 0.02235 L × 0.1000 mol/L = 2.235 × 10⁻³ mol
moles HCl = 2.235 × 10⁻³ mol (1:1 stoichiometry)
[HCl] = 2.235 × 10⁻³ mol / 0.02500 L = 0.08940 M
```

### 6. Evaluate uncertainty and report correctly

Report: mean ± standard deviation from triplicate; include standardization uncertainty in total uncertainty. Significant figures: limited by burette precision (±0.01 mL) and analyte mass precision.

## Common Mistakes

- **Using unstandardized NaOH:** NaOH absorbs CO₂ from air and moisture — concentration drifts within hours of preparation. Always standardize on the day of use.
- **Not subtracting the blank:** Indicator itself consumes a small amount of titrant. Blank correction is essential for high-accuracy work.
- **Stopping at the first permanent color change rather than the persistent endpoint:** For phenolphthalein: endpoint = first persistent pink lasting 30 seconds, not the first pink flash.

## When NOT to Use

- Mixture of analytes that react at similar potentials or pH values: use chromatography or selective electrodes for resolution before titration.
