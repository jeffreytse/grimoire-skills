---
name: design-spectroscopic-analysis
description: Use when selecting and designing a spectroscopic analysis method (UV-Vis, IR, NMR, MS, or Raman) — including method selection, sample preparation, calibration, data interpretation, and reporting for structural identification or quantitation.
source: Silverstein et al. "Spectrometric Identification of Organic Compounds" 8th ed. (2014); Skoog et al. "Principles of Instrumental Analysis" 7th ed. (2018); Pavia et al. "Introduction to Spectroscopy" 5th ed. (2015)
tags: [spectroscopy, NMR, IR, UV-Vis, mass-spectrometry, structural-identification, analytical-chemistry]
---

# Design Spectroscopic Analysis

Select and apply the correct spectroscopic technique — UV-Vis, IR, NMR, or MS — and design the measurement protocol with appropriate calibration, sample preparation, and interpretation framework to answer structural or quantitative questions reliably.

## Why This Is Best Practice

**Adopted by:** ICH Q6A (pharmaceutical specifications) mandates IR and/or NMR for identity confirmation of drug substances. FDA 21 CFR Part 211 requires spectroscopic identification of raw materials before use. ACS journals require complete spectroscopic data for all new compounds (¹H NMR, ¹³C NMR, MS, and IR for novel organic compounds).
**Impact:** Silverstein et al. (2014) is the definitive reference for spectroscopic structure determination — the staged multi-technique approach it describes (IR → MS → NMR) resolves structural ambiguity that any single technique cannot. The combination of NMR + HRMS is the current gold standard for establishing structure of organic compounds, used in >90% of synthetic chemistry publications.

## Steps

### 1. Select the technique for the question

Match technique to analytical goal:
| Goal | Primary technique | Secondary |
|------|------------------|-----------|
| Functional group identification | IR | Raman |
| Molecular weight determination | MS (ESI or EI) | — |
| Detailed structure (connectivity) | ¹H and ¹³C NMR | COSY, HSQC, HMBC |
| Quantitation of chromophore | UV-Vis | Fluorescence |
| Purity of pharmaceutical | ¹H NMR (qNMR) | HPLC-UV |
| Structural confirmation of new compound | NMR + HRMS + IR | — |
| Elemental formula confirmation | High-resolution MS (HRMS) | — |

### 2. Prepare the sample appropriately

**NMR sample prep:**
- Dissolve 5-20 mg in 0.6 mL deuterated solvent (CDCl₃, d₆-DMSO, D₂O) in NMR tube
- Use high-purity solvents (99.9% D); remove paramagnetic impurities (filter through Celite if needed)
- Target: singlet solvent peak, no significant signal from dissolved solids (turbidity = problem)

**IR sample prep:**
- Neat liquid: smear between two KBr or NaCl plates
- Solid: KBr pellet (1 mg analyte : 100 mg KBr, dry at 110°C) or ATR-FTIR (direct, no prep)
- ATR-FTIR: preferred for rapid analysis; requires good contact with the crystal

**UV-Vis sample prep:**
- Dissolve in transparent solvent at appropriate concentration (typically 10-50 µM for ε~10,000-100,000)
- Use matched quartz cuvettes (glass absorbs UV <340 nm)
- Run blank (solvent only) before sample

**MS sample prep:**
- ESI-MS: dissolve in MeOH/water with 0.1% formic acid (for [M+H]⁺) or NH₄OAc (for [M+NH₄]⁺)
- EI-MS: volatile compound; direct insertion probe or GC inlet
- Concentration: 0.1-1 µg/mL for ESI; more for EI

### 3. Interpret spectral data systematically

**IR interpretation workflow:**
1. Identify broad OH/NH (3200-3600 cm⁻¹) or sharp C-H (2800-3000 cm⁻¹)
2. Carbonyl region (1650-1850 cm⁻¹): aldehyde, ketone, ester, carboxylic acid, amide — each has characteristic position
3. Fingerprint region (600-1500 cm⁻¹): match to reference spectra; do not interpret peak-by-peak

**NMR interpretation workflow:**
1. Count peaks (number of chemically distinct environments)
2. Assign integration (proton count)
3. Identify splitting patterns (n+1 rule for first-order systems)
4. Assign chemical shifts to functional groups:
   - δ 0-3 ppm: alkyl H
   - δ 4-6 ppm: allylic, O-CH
   - δ 6-9 ppm: aromatic H
   - δ 9-10 ppm: aldehyde
   - δ 10-13 ppm: carboxylic acid OH

**MS interpretation:**
- Identify [M+H]⁺, [M+Na]⁺, [M+K]⁺ ions
- HRMS: calculate molecular formula from exact mass (NIST Mass Bank or mzCloud)
- Fragmentation pattern: base peak, loss of 17 (OH), 18 (H₂O), 28 (CO), 44 (CO₂)

### 4. Calibrate for quantitative measurements

**UV-Vis quantitation (Beer-Lambert):**
```
A = ε × b × c
Where: A = absorbance, ε = molar absorptivity (L/mol·cm), b = path length (cm), c = concentration (mol/L)
```
- Build calibration curve from 5-6 standards spanning expected sample range
- Linear range: A = 0.1-1.0 (>1.0 deviates from Beer-Lambert)
- Use R² > 0.999 as acceptance criterion

**qNMR (quantitative ¹H NMR):**
- Use internal standard (dimethyl sulfone, maleic acid) with known mass and distinct signal
- Relaxation delay ≥ 5× longest T₁ (typically 30-60 s) for accurate integration

## Common Mistakes

- **Running NMR without TMS reference or lock:** Chemical shifts reported without reference are ambiguous. Use residual solvent peak as internal reference (CDCl₃: 7.26 ppm for ¹H, 77.16 ppm for ¹³C).
- **Interpreting UV-Vis above A=1.0:** Above A=1.0, Beer-Lambert law often fails due to refractive index effects. Always verify linearity.
- **Reporting nominal MS instead of HRMS for new compounds:** Nominal MS (unit resolution) cannot distinguish C₁₆H₂₄O from C₁₇H₂₈ (both MW 248). HRMS is required for molecular formula confirmation.

## When NOT to Use

- Trace-level environmental or forensic analysis: GC-MS/LC-MS/MS with matrix-matched calibration and certified reference materials is required for regulated quantitation at ppb/ppt levels.
