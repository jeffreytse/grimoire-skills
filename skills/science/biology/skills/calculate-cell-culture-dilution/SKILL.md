---
name: calculate-cell-culture-dilution
description: Use when performing serial dilutions, calculating cell plating density, determining colony forming units (CFU), or preparing drug concentration gradients for cell culture experiments.
source: Current Protocols in Cell Biology (Bonifacino et al.); ATCC Cell Culture Basics Guide; Freshney "Culture of Animal Cells" 7th ed. (2016)
tags: [cell-culture, serial-dilution, CFU, plating-density, cell-counting, laboratory-calculations]
---

# Calculate Cell Culture Dilution

Perform serial dilutions, calculate plating densities, determine CFU/mL from colony counts, and prepare concentration gradients accurately to produce reliable, reproducible cell culture experiments.

## Why This Is Best Practice

**Adopted by:** ATCC, DSMZ, and every quality-certified cell culture laboratory use standardized dilution and plating calculations as GLP requirements. Pharmaceutical companies conducting cell-based assays use validated dilution schemes per ICH Q2(R1) analytical validation guidelines.
**Impact:** Cell density at plating is the single most important variable controlling proliferation rate, morphology, and metabolic state in culture experiments. Freshney (2016) shows that cells seeded too densely undergo contact inhibition and differentiation; too sparsely, cells fail to condition the medium and may not proliferate. Serial dilution errors compound multiplicatively — a 2× error at step 1 of a 5-step dilution series produces a 32× final error. Systematic calculation eliminates these errors.

## Steps

### 1. Count cells accurately before dilution

Use a hemocytometer (manual) or automated counter (Countess, Vi-CELL):
- **Hemocytometer:** count cells in all 4 corner squares; include cells touching top/left lines, exclude bottom/right lines
- Calculate concentration:
```
Cells/mL = (total cells counted / number of squares) × 10,000 × dilution factor
```
- Typical: count at least 200 cells total for statistical validity
- If using trypan blue exclusion: count only clear (live) cells; viability = live/(live + dead) × 100%

Proceed only if viability ≥ 80%.

### 2. Calculate target dilution factor

To reach a target concentration from a stock:
```
C1 × V1 = C2 × V2
```
- C1 = current cell concentration (cells/mL)
- V1 = volume of stock needed
- C2 = target cell concentration
- V2 = total final volume

Example: dilute 2 × 10⁶ cells/mL stock to seed at 1 × 10⁵ cells/mL in 5 mL total:
```
V1 = (1 × 10⁵ × 5) / (2 × 10⁶) = 0.25 mL stock + 4.75 mL medium
```

### 3. Design serial dilutions for large dilution factors

When dilution factor > 100, use serial dilutions:
- Plan the dilution series to keep each step within 1:2 to 1:10 range (more accurate than 1:1000 in one step)
- Example: to make 1:1000 dilution: 1:10 → 1:10 → 1:10 (three sequential steps)
- Label each tube with dilution factor; change pipette tips between steps
- Most accurate: use 1:10 dilutions (transfer 100 µL into 900 µL diluent) with calibrated micropipettes

```
Final dilution = product of all individual dilution factors
1:10 × 1:10 × 1:10 = 1:1000
```

### 4. Calculate CFU/mL from plate counts

For microbial or yeast cultures:
```
CFU/mL = (number of colonies × dilution factor) / volume plated (mL)
```
- Count plates with 30-300 colonies (too few = statistically unreliable; too many = confluent)
- Average two or three plate replicates at the same dilution
- If no plate is in the 30-300 range: report as "TNTC" (too numerous to count) or "TFTC" (too few) and repeat with adjusted dilution

### 5. Prepare drug/reagent concentration gradients

For dose-response assays:
- **Log-scale dilutions:** most appropriate for biological systems (EC50 spans orders of magnitude); typical: 10-fold or 3.16-fold (half-log) dilutions
- Start from the highest concentration; dilute serially
- Include vehicle control (DMSO ≤0.1% final; ethanol ≤0.5%) at same volume as highest drug concentration
- Prepare in culture medium, not DMSO stocks, for the final working concentrations

### 6. Verify plate seeding uniformity

After plating:
- Mix cell suspension gently before each aliquot (cells settle quickly)
- Use multi-channel pipette for multi-well plates to reduce well-to-well variation
- Check for even distribution: inspect under microscope within 1 hour of seeding
- For 96-well plates: seed 10-15% extra volume; edge wells of 96-well plates have higher evaporation — use external wells for vehicle controls, not experimental conditions

## Common Mistakes

- **Not accounting for dilution factor in CFU calculation:** The dilution factor must be multiplied back to get the original concentration.
- **Pipetting errors compound in serial dilutions:** Use a fresh tip for each transfer; inaccurate pipetting at step 1 multiplies through all subsequent dilutions.
- **Seeding cells at non-logarithmic phase:** Cells passaged at >80% confluence carry metabolic stress into the experiment. Always passage at 70-80% and let cells recover 24h before use in assays.

## When NOT to Use

- Counting primary cells from heterogeneous tissue: flow cytometry or cell-type-specific counting (CD marker gating) is required to accurately quantify specific cell populations.
