---
name: design-seismic-hazard-assessment
description: Use when conducting a seismic hazard assessment for engineering design, land use planning, or risk management — including probabilistic seismic hazard analysis (PSHA), ground motion characterization, site amplification, and communication of hazard to decision-makers.
source: McGuire "Seismic Hazard and Risk Analysis" (2004, EERI); Cornell (1968) "Engineering Seismic Risk Analysis" (BSSA); Kramer "Geotechnical Earthquake Engineering" (1996); ASCE 7-22 Seismic Design Standard
tags: [seismic-hazard, PSHA, earthquake-engineering, ground-motion, risk-assessment, structural-engineering]
---

# Design Seismic Hazard Assessment

Conduct a probabilistic seismic hazard analysis (PSHA) by characterizing seismic sources, selecting ground motion prediction equations, computing hazard curves, and translating hazard to design-level ground motions with appropriate site-specific amplification.

## Why This Is Best Practice

**Adopted by:** USGS National Seismic Hazard Maps (the basis for US building codes), ASCE 7 seismic design standard, Eurocode 8 (European seismic design), IBC (International Building Code), and nuclear regulatory agencies worldwide (IAEA SSG-9, NRC RG 1.165) use PSHA as the standard methodology. The PEER NGA-West2 and NGA-East ground motion databases represent the global state of practice for ground motion prediction.
**Impact:** Cornell (1968) introduced PSHA as a unified framework for quantifying earthquake hazard — it replaced deterministic maximum credible earthquake (MCE) methods that systematically over- or under-designed structures by ignoring earthquake recurrence. PSHA has since been validated by comparison of predicted vs. observed ground motions in major earthquakes (Northridge 1994, Kobe 1995, Christchurch 2011). Building codes based on PSHA have demonstrably reduced structural collapse rates.

## Steps

### 1. Define the hazard analysis scope and return period

Before any technical work:
- **Return period (RP):** reciprocal of annual probability of exceedance
  - Life safety (typical building): 2% in 50 years = 2,475-year RP
  - Collapse prevention: 10% in 50 years = 475-year RP
  - Critical infrastructure (dams, nuclear): 10,000-year RP or higher
- **Ground motion parameter:** Peak Ground Acceleration (PGA), Spectral Acceleration Sa(T) at structural period T
- **Site reference condition:** reference rock (Vs30 = 760 m/s) or site-specific soil profile

### 2. Characterize seismic sources

Identify all earthquake sources that could affect the site:
- **Area sources:** distributed seismicity not associated with specific mapped faults; use historical catalog
- **Fault sources:** identified active faults with geological slip rates (from paleoseismology, geodesy)

For each source:
- Maximum magnitude (Mmax): from empirical scaling relations (Wells & Coppersmith 1994: Mmax from fault area)
- Recurrence model: Gutenberg-Richter (magnitude-frequency) or characteristic earthquake model
- Annual rate of exceedance for each magnitude bin

Use USGS Quaternary Fault and Fold Database and peer-reviewed fault studies.

### 3. Select ground motion prediction equations (GMPEs)

GMPEs predict ground motion intensity (Sa, PGA) as a function of magnitude, distance, and site conditions:
- NGA-West2 models (for active crustal regions): Boore-Stewart-Seyhan-Atkinson (BSSA14), Campbell-Bozorgnia (CB14), Chiou-Youngs (CY14)
- NGA-East (for stable continental regions, e.g., eastern US, Australia)
- Use logic tree weighting across multiple GMPEs to capture epistemic uncertainty

Selection criteria: match the tectonic environment (active crustal, subduction zone, stable continental), magnitude range, and distance range relevant to the site.

### 4. Compute the hazard integral

PSHA combines source characterization and GMPEs via numerical integration:
```
λ(Z > z) = Σᵢ νᵢ ∫∫ P(Z > z | m, r) f_M(m) f_R(r) dm dr
```
Where:
- λ(Z > z) = annual rate of exceeding ground motion level z
- νᵢ = annual rate of earthquakes on source i
- P(Z > z | m, r) = probability of exceeding z given magnitude m and distance r (from GMPE)

Software: OpenQuake (free, open-source, global standard); HAZ45; EZ-FRISK.

Output: hazard curve (annual probability of exceedance vs. ground motion level); disaggregation (which magnitude-distance bins dominate the hazard at the target return period).

### 5. Apply site amplification (site response)

Site-specific amplification modifies reference rock hazard to site soil conditions:
- **Code-based amplification factors (ASCE 7):** Fa and Fv based on Vs30; appropriate for standard design
- **Site response analysis:** required for critical facilities; 1D equivalent-linear (SHAKE, DEEPSOIL) or nonlinear; input: Vs profile from downhole testing, borehole shear wave measurement

Apply amplification factors to reference rock spectra to obtain site-specific design spectra.

### 6. Communicate hazard to decision-makers

Translate PSHA output to actionable design parameters:
- **Design response spectrum:** Sa(T) at spectral periods 0.2s, 1.0s, and key structural periods
- **PGA for geotechnical hazard:** liquefaction, slope stability, fault rupture hazard
- **Hazard curve:** plot for decision-makers to understand probability vs. ground motion trade-off
- **Uncertainty ranges:** epistemic (logic tree) and aleatory (randomness inherent in earthquake process)

Report: hazard methodology, source model, GMPEs selected with weights, site parameters, target return periods, resulting spectra with comparison to code values.

## Common Mistakes

- **Using only one GMPE:** Single GMPE underestimates epistemic uncertainty. Logic tree with ≥3 models is the minimum standard.
- **Ignoring near-field fault sources:** Distant area source hazard is rarely controlling. Identify all mapped active faults within 100 km and assess rupture scenarios explicitly.
- **Confusing return period with design life:** A 475-year return period earthquake does not occur "every 475 years." It is a 10% probability of exceedance in 50 years — a statement about annual probability, not recurrence interval.

## When NOT to Use

- Sites where active fault surface rupture is the primary hazard: fault avoidance setback zones (per California Alquist-Priolo Act or equivalent) address surface rupture separately from ground shaking hazard.
