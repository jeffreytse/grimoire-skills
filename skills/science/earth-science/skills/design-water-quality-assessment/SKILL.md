---
name: design-water-quality-assessment
description: Use when designing a water quality monitoring or assessment program — for drinking water, surface water, groundwater, or wastewater — including parameter selection, sampling design, analytical methods, and regulatory compliance evaluation.
source: APHA "Standard Methods for the Examination of Water and Wastewater" 23rd ed. (2017); WHO Guidelines for Drinking-water Quality 4th ed. (2017); EPA 40 CFR Part 136 (analytical methods); ISO 5667 (water sampling standards)
tags: [water-quality, environmental-monitoring, sampling-design, drinking-water, groundwater, regulatory-compliance]
---

# Design Water Quality Assessment

Design a rigorous water quality monitoring program by defining the assessment objective, selecting relevant parameters with regulatory context, applying standardized sampling protocols, and ensuring analytical method compliance and data quality objectives.

## Why This Is Best Practice

**Adopted by:** EPA (Clean Water Act monitoring), WHO (drinking water guidelines), EU Water Framework Directive, and every major water utility follow standardized water quality assessment protocols. ISO 5667 defines international water sampling standards; APHA Standard Methods is the definitive reference for analytical methods accepted by US regulatory agencies.
**Impact:** WHO (2017) attributes >2 billion cases of diarrheal disease annually to contaminated drinking water — waterborne illness is the consequence of inadequate water quality assessment. EPA data shows that >40% of US surface waters are impaired (NWQS non-attainment) — identified through standardized monitoring. Sampling design errors (insufficient frequency, improper preservation, wrong container material) systematically bias analytical results and produce non-actionable or misleading water quality data.

## Steps

### 1. Define the assessment objective

Before selecting parameters:
- **Drinking water compliance:** compare against MCLs (Maximum Contaminant Levels) — WHO, EPA, or national standards
- **Ecological assessment:** characterize biological, chemical, and physical condition of a water body
- **Pollution source investigation:** identify and characterize a specific contaminant source
- **Groundwater baseline:** establish pre-development geochemical baseline for environmental impact assessment
- **Wastewater effluent characterization:** characterize discharge for permit compliance (NPDES in US)

The objective determines: parameters, frequency, spatial design, and regulatory framework.

### 2. Select parameters by objective

**Physical parameters (always include):**
- Temperature, pH, dissolved oxygen (DO), electrical conductivity (EC), turbidity

**Chemical parameters by concern:**
- Nutrients: total nitrogen (TN), total phosphorus (TP), nitrate (NO₃⁻), ammonia (NH₃)
- Metals: As, Cd, Pb, Hg, Cr(VI), Fe, Mn — match to land use (agricultural, industrial, mining)
- Organics: BOD, COD, TOC; priority pollutants (VOCs, PAHs, pesticides) if suspected
- Anions: F⁻, SO₄²⁻, Cl⁻ (salinity indicators); alkalinity, hardness
- Emerging contaminants: PFAS, pharmaceuticals, microplastics (if risk-based)

**Microbiological parameters (drinking water):**
- Total coliforms, E. coli (fecal indicator); Cryptosporidium and Giardia for surface water sources

### 3. Design the sampling network

Spatial design:
- **Reference sites:** unimpacted sites upstream or in comparable catchments — establish natural baseline
- **Impact sites:** downstream of suspected sources, at discharge points
- **Compliance monitoring:** fixed stations mandated by permit or regulation

Temporal design:
- **Grab samples:** single point in time; for parameters that change rapidly (DO, temperature) or for compliance spot checks
- **Composite samples:** multiple sub-samples composited over time or space; for parameters where average is more meaningful (BOD, nutrient loads)
- **Continuous monitoring:** sensors (DO, pH, temperature, EC, turbidity); captures diurnal variation and events; required for real-time early warning

Minimum sampling frequency for trend detection: monthly for surface water; quarterly for groundwater; daily for critical compliance monitoring.

### 4. Apply standardized sampling protocols

ISO 5667 / EPA sampling requirements:
- **Container material:** use correct container per parameter (glass for organics/metals; HDPE for inorganics; sterile containers for microbiology)
- **Preservation:** HNO₃ (metals); H₂SO₄ (nutrients); no preservation (field parameters); 4°C (BOD, COD); sodium thiosulfate (chlorinated water for microbiology)
- **Hold times:** analyze within hold time (metals 6 months in acid; E. coli 6 hours; nitrate 48 hours)
- **Field blanks and duplicates:** minimum 1 field duplicate per 20 samples; travel blank for VOC analysis
- **Chain of custody:** signed and documented from collection to analysis

In-situ field measurements (temperature, pH, DO, conductivity): measure before disturbing the sample; calibrate instruments before each sampling event.

### 5. Specify analytical methods

Use EPA-approved or ISO-equivalent methods for regulatory compliance:
- Metals: EPA Method 200.7 (ICP-OES), 200.8 (ICP-MS); 245.1 (mercury)
- Nutrients: EPA 353.2 (nitrate/nitrite), 365.1 (phosphorus)
- BOD: SM 5210B; COD: SM 5220D
- Microbiology: EPA Method 1604 (E. coli / total coliform membrane filtration)
- PFAS: EPA Method 533 or 537.1

Non-approved methods require method validation per SW-846 Chapter 1 before use in regulatory submissions.

### 6. Evaluate results against standards

Compare to:
- **WHO drinking water guidelines** (health-based guideline values)
- **EPA MCLs** (legally enforceable for public water systems)
- **EPA/EU water quality criteria** (aquatic life, recreation, human health)
- **Site-specific reference conditions** (if ecological assessment)

Report: concentrations with units, detection limits, method used, comparison to applicable standards, exceedances flagged.

## Common Mistakes

- **Collecting samples without proper preservation or exceeding hold times:** Results are non-compliant and must be flagged or rejected. Preservation errors are the most common cause of analytical QA/QC failures.
- **Sampling only during low-flow (dry weather):** Many contaminants (pathogens, sediment-bound metals, nutrients) are highest during storm events. Assessment without wet-weather sampling underestimates loads.
- **Insufficient spatial coverage to identify the pollution source:** A single downstream station characterizes impact but cannot identify the source. Include upstream reference stations and potential source-area stations.

## When NOT to Use

- Complex mixture toxicity assessment: whole effluent toxicity (WET) testing with bioassays (Ceriodaphnia, fathead minnow) is required when chemical parameters alone cannot predict ecological impacts.
