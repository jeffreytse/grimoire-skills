---
name: design-geological-survey
description: Use when planning a geological field survey — defining objectives, selecting mapping scale, designing sampling strategy, choosing measurement methods, and planning data collection for structural geology, stratigraphy, or mineral exploration.
source: Barnes & Lisle "Basic Geological Mapping" 5th ed. (2004); Compton "Manual of Field Geology" (1962, reprinted); USGS Field Techniques and Methods; Society of Economic Geologists (SEG) Exploration Guidelines
tags: [geological-survey, field-mapping, stratigraphy, structural-geology, mineral-exploration, sampling-design]
---

# Design Geological Survey

Plan a geological field survey by defining objectives, selecting appropriate mapping scale and methods, designing a systematic sampling strategy, and integrating remote sensing with ground-truth observations to produce reliable geological data.

## Why This Is Best Practice

**Adopted by:** USGS geological mapping programs, Geological Survey of Canada, BGS (British Geological Survey), and all major mining companies (Rio Tinto, BHP, Anglo American) use systematic geological survey design as the basis for mineral resource estimation. NI 43-101 (Canadian mineral disclosure standard) and JORC (Australian standard) require documented, systematic field data collection as a prerequisite for resource classification.
**Impact:** The difference between a systematic geological survey and ad hoc field observation is quantified by the 2019 CRIRSCO International Reporting Template: unsystematic data cannot be used for Inferred, Indicated, or Measured Resource categories. Barnes & Lisle (2004) demonstrate that mapping at inappropriate scale introduces structural interpretation errors that compound into formation-scale miscorrelations. A well-designed survey is the foundation of all downstream interpretations.

## Steps

### 1. Define objectives and select mapping scale

Before planning any fieldwork:
- **Objective A — regional geology:** 1:50,000 to 1:250,000 scale; characterize lithological units, major structures, contact relationships
- **Objective B — detailed structural/stratigraphic mapping:** 1:10,000 to 1:25,000; map faults, folds, sedimentary facies
- **Objective C — mineral exploration:** 1:1,000 to 1:10,000; alteration zones, ore controls, grade continuity
- **Objective D — engineering geology:** 1:500 to 1:5,000; geotechnical characterization for construction

Scale determines station spacing, time budget, and traverses required.

### 2. Review pre-existing data

Before fieldwork, compile:
- Published geological maps (USGS, BGS, national geological surveys)
- Satellite imagery (Google Earth, Sentinel-2, Landsat — 30m resolution; ASTER for spectral geology)
- Aerial photographs (stereo pairs for structural analysis)
- Airborne geophysics if available (aeromagnetics, gravity)
- Previous exploration reports and drillhole data

Use these to formulate working hypotheses and design traverses to test them. Never start fieldwork blind.

### 3. Design the traverse network

Systematic traverse design:
- **Grid traverses:** parallel lines at fixed spacing; appropriate for flat terrain; station spacing = 20-50% of smallest target feature
- **Topography-following traverses:** follow ridges/valleys; maximizes exposure; best for rugged terrain
- **Loop traverses:** return to starting point; allows closure check on structure/stratigraphy
- **Random walk:** inappropriate for systematic surveys — biases toward accessible terrain

Station spacing: at minimum, one observation per minimum mappable unit at the target scale. For 1:25,000 mapping: station every 100-250m on traverse.

### 4. Standardize field measurements and data recording

For each outcrop station, record systematically:
- **Location:** GPS coordinates (UTM or lat/lon), elevation; accuracy ≤5m horizontal
- **Lithology:** rock name, texture, grain size, color, mineralogy, alteration
- **Structural data:** strike and dip of all planar features (bedding, foliation, veins, faults) using Brunton/Clino compass; plunge and trend of linear features
- **Contact relationships:** conformable/unconformable; fault contact; gradational vs sharp
- **Samples:** oriented samples for petrography; channel samples for geochemistry; mark sample location on map

Use field notebooks + digital capture (Survey123, Fieldmove, Rockd) — digital backup required.

### 5. Design the sampling strategy

For geochemical surveys:
- **Stream sediment sampling:** one sample per 1-2 km² drainage catchment; identifies geochemical anomalies at regional scale
- **Soil sampling:** systematic grid; 50-200m spacing for target-scale survey; A/B/C horizon selection documented
- **Rock chip sampling:** 1-3 kg fresh rock samples across lithological contacts, mineralized zones, and alteration halos
- **Assay selection:** match elements to target mineralization (Au, Ag, Cu for porphyry; REE for carbonatite; Pb, Zn for VMS)

Chain of custody: numbered sample bags, field duplicate every 20th sample, blanks and standards for QA/QC.

### 6. Plan data integration and map compilation

After fieldwork:
- Enter all data into GIS (ArcGIS, QGIS, Leapfrog, Micromine)
- Produce geological map with legend, structural symbols, scale bar, north arrow
- Cross-sections perpendicular to strike at key locations
- Validate: do contact dips/strikes match map pattern via three-point problem? Do fold hinge lines intersect? Are faults consistent in sense of movement?

## Common Mistakes

- **Ignoring pre-existing data:** Re-mapping known geology wastes field time; review available maps before designing traverses.
- **Inconsistent structural measurements:** Compass-clinometer readings must use consistent conventions (right-hand rule or strike-dip azimuth); mixing conventions corrupts stereonet analysis.
- **Sampling only mineralized material:** Geochemical surveys require background + anomalous samples to define threshold values. Biased sampling inflates anomaly significance.

## When NOT to Use

- Subsurface geological characterization in covered terrain: drillhole programs with geophysical logging, seismic reflection/refraction, and core logging are required when outcrop is absent.
