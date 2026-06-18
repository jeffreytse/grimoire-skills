---
name: design-biodiversity-survey
description: Use when planning a field biodiversity monitoring survey — designing sampling strategy, site selection, species identification methods, and data recording protocols to produce repeatable, statistically valid biodiversity assessments.
source: Krebs "Ecological Methodology" 2nd ed. (1999); Magurran "Measuring Biological Diversity" (2004); GBIF Data Quality Framework (2021); IUCN Survey Methods for Plants and Animals
tags: [biodiversity, ecology, field-survey, species-monitoring, conservation, ecological-assessment]
---

# Design Biodiversity Survey

Design a repeatable field biodiversity survey by selecting appropriate sampling strategy, site layout, identification methods, and data recording protocols to produce statistically valid species richness and abundance estimates.

## Why This Is Best Practice

**Adopted by:** Biodiversity survey methodology is standardized by IUCN (International Union for Conservation of Nature), Global Biodiversity Information Facility (GBIF), and national natural history agencies (US Fish & Wildlife Service, Natural England, CSIRO). The Convention on Biological Diversity (CBD) requires standardized monitoring protocols for reporting under the Kunming-Montreal Global Biodiversity Framework. Academic ecology uses Krebs and Magurran's frameworks for calculating biodiversity indices.
**Impact:** A poorly designed survey produces data that cannot be replicated, compared to other sites, or used to detect change over time. The most common errors — insufficient plot size, non-random site selection, and inconsistent species identification — systematically bias estimates of richness and abundance. A correctly designed survey produces defensible, publishable data that can detect 10–20% population changes over multi-year monitoring programs.

## Steps

### 1. Define survey objectives and target taxa

Before designing the protocol, clarify:
- **Purpose:** baseline inventory, trend monitoring, impact assessment, or restoration evaluation?
- **Target taxa:** plants, birds, invertebrates, mammals, fungi, or all? Different taxa require different methods
- **Resolution:** species-level identification, genus-level, or functional groups?
- **Temporal scope:** single visit, seasonal, annual, multi-year?

Scope determines method — surveying breeding birds requires visit timing aligned with breeding season; surveying amphibians requires night surveys during breeding; plant surveys should cover peak phenological diversity.

### 2. Select the sampling strategy

**Three main approaches:**

**Complete census (systematic):** record every individual in the defined area; feasible only in small, well-defined areas with high surveyor capacity.

**Transect surveys:** walk defined lines of set length; record species in a belt of defined width on each side.
- Standard: 2m belt transect for plants; variable width transect (VWT) for birds; 50m point count for birds
- Best for: elongated habitats, comparative monitoring across sites

**Quadrat sampling:** randomly placed plots of fixed area; count all species within.
- Standard quadrat sizes: 1 m² (herbs), 10 m² (shrubs), 100 m² (trees)
- Number of quadrats: determined by species-area curve; sample until the curve flattens (species accumulation)
- Random placement: use random number tables or GPS coordinates to eliminate observer bias in plot selection

**N=20 minimum:** fewer than 20 sampling units produces unreliable diversity estimates for most habitats.

### 3. Design the site layout

- Stratify by habitat type: survey grassland, woodland edge, and wetland separately (lumping biases richness estimates)
- Mark permanent transect endpoints or quadrat corners with GPS coordinates for repeatability
- Photograph the vegetation structure at each plot (visual reference for future surveyors)
- Buffer zones: maintain consistent distance from habitat edges to avoid edge-effect bias

### 4. Standardize identification and recording protocol

**Species identification standards:**
- Specify the minimum identification standard: all species to species level, or uncertain IDs recorded to genus with a photo voucher?
- Photograph every uncertain identification; attach to the data record
- For invertebrates and plants: collect voucher specimens (where legally permitted) for post-survey confirmation
- Use standardized taxonomic databases: GBIF, iNaturalist, or ITIS for consistent nomenclature

**Data recording:**
- Minimum data per record: species name, number of individuals (or % cover for plants), GPS location (±5m), date and time, observer name, method, weather conditions
- Use standardized field forms (paper or digital: iNaturalist, Survey123, KoBoToolbox) — no free-text descriptions
- Record observer effort: time spent, area covered, number of observers — enables density calculations

### 5. Calculate appropriate diversity indices

From the collected data, calculate:
- **Species richness (S):** total number of species recorded
- **Shannon-Wiener Index (H'):** accounts for both richness and evenness; H' = -Σ(pi × ln pi); higher = more diverse
- **Simpson's Index (D):** probability that two randomly chosen individuals are different species; D = 1 - Σ(ni(ni-1)/N(N-1))
- **Species accumulation curves:** plot cumulative species vs. sampling effort; curve should begin to flatten (plateau) if coverage is sufficient

If the accumulation curve has not flattened, the survey is under-sampled — increase sampling intensity before drawing conclusions about total richness.

### 6. Plan for repeatability

For monitoring to detect change:
- Document complete methodology in a protocol document
- Save GPS waypoints, quadrat corners, transect routes to a shared repository
- Standardize survey timing (same week each year, same time of day)
- Calibrate observers: use standardized training, inter-rater reliability tests between observers before deploying on independent plots

Change detection requires at least 3 repeat surveys to calculate trends; 5+ surveys for statistical power.

## Common Mistakes

- **Non-random plot placement:** Placing plots in "good-looking" areas inflates richness estimates. Use GPS-random placement.
- **Single-visit surveys called "comprehensive":** Species detectability varies with season, weather, and phenology. A single visit misses 40–60% of species in most taxa. Report as "minimum estimate" if based on one visit.
- **Using different protocols across sites:** Comparing sites surveyed with different methods, quadrat sizes, or effort levels is methodologically invalid. Standardize before comparing.

## When NOT to Use

- Rapid assessment for non-scientific communication: for public engagement or general awareness (school nature walks, community surveys), informal observation without statistical rigor is appropriate. Reserve the formal protocol for data that will inform management decisions or publications.
