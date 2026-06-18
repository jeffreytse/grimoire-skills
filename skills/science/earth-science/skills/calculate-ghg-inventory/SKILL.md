---
name: calculate-ghg-inventory
description: Use when calculating the greenhouse gas (GHG) emissions of an activity, organization, product, or project — applying the GHG Protocol Corporate Standard or ISO 14064 to quantify Scope 1, 2, and 3 emissions in CO₂-equivalent units.
source: GHG Protocol Corporate Accounting and Reporting Standard (World Resources Institute, 2004); ISO 14064-1:2018; IPCC Sixth Assessment Report (AR6) Global Warming Potentials; EPA Emission Factors Hub
tags: [carbon-footprint, GHG-emissions, climate, sustainability, Scope-1-2-3, CO2-equivalent, lifecycle-assessment]
---

# Calculate GHG Inventory

Quantify greenhouse gas emissions using GHG Protocol methodology — inventorying Scope 1, 2, and 3 emission sources, applying correct global warming potential (GWP) factors, and expressing results in CO₂-equivalent (CO₂e) units with documented uncertainty.

## Why This Is Best Practice

**Adopted by:** GHG Protocol standards are used by >90% of Fortune 500 companies that report emissions and are required by CDP (Carbon Disclosure Project), TCFD (Task Force on Climate-related Financial Disclosures), and SEC climate disclosure rules (2024). ISO 14064-1 is the basis for third-party verification of corporate GHG inventories. The Science Based Targets initiative (SBTi) requires GHG Protocol-aligned inventories for target validation.
**Impact:** The IPCC AR6 (2021) quantified global warming potential (GWP₁₀₀) for all GHGs — the updated factors change total emissions estimates for industries using refrigerants, methane, or N₂O significantly vs. AR4 values. Organizations using wrong GWP values systematically misstate their footprint. Scope 3 emissions typically account for 70-90% of an organization's total impact — organizations reporting only Scope 1+2 miss the vast majority of their climate risk.

## Steps

### 1. Define scope and organizational boundary

Establish what is included before calculating anything:
- **Operational control approach:** include all emission sources you have operational control over (preferred for regulatory compliance)
- **Equity share approach:** include sources proportional to your equity share
- **Financial control approach:** include sources you have financial control over

Document included and excluded sources and the rationale for any exclusions.

### 2. Inventory emission sources by scope

**Scope 1 (direct emissions — sources you own or control):**
- Combustion of fuels in owned equipment (boilers, vehicles, furnaces, generators)
- Process emissions (industrial processes: cement calcination, steel making)
- Fugitive emissions (refrigerants leaking from HVAC/refrigeration; SF₆ from electrical equipment; methane from wastewater)

**Scope 2 (indirect — purchased energy):**
- Electricity consumption: report both market-based (using supplier emissions factors or RECs) and location-based (grid average)
- Purchased steam, heat, cooling

**Scope 3 (indirect — value chain):**
- Upstream: purchased goods and services, capital goods, waste, business travel, employee commuting
- Downstream: use of sold products, end-of-life treatment, investments

For most organizations, prioritize Scope 3 categories by screening estimation first; focus detailed calculation on categories >1% of estimated total.

### 3. Collect activity data

Activity data = the physical quantity of emission-generating activity:
- Fuel: liters, m³, or GJ consumed
- Electricity: kWh consumed
- Refrigerants: kg charged/leaked/disposed
- Materials: tonnes purchased or produced
- Travel: passenger-km or freight-tonne-km

Sources: utility bills, fuel purchase records, production logs, supplier data, financial spend data (for estimation).

### 4. Apply emission factors and GWP100

Emission factor converts activity data to CO₂e:
```
CO₂e emissions = Activity data × Emission factor × GWP₁₀₀(gas)
```

Use current GWP₁₀₀ from IPCC AR6 (2021):
- CO₂: 1 (reference)
- CH₄ (methane): 27.9 (AR6; was 25 in AR4)
- N₂O: 273 (AR6; was 298 in AR4)
- HFC-134a (refrigerant): 1,526
- SF₆: 25,200

Emission factor sources (hierarchical preference):
1. Supplier-specific factors (Scope 3 purchased goods)
2. National government factors (EPA, DEFRA, IEA)
3. Industry-average databases (ecoinvent, EcoInvent, SimaPro)

### 5. Sum and report by scope

```
Total Scope 1 = Σ(activity_i × EF_i × GWP_i) for all direct sources
Total Scope 2 = electricity consumption × grid EF (market-based or location-based)
Total Scope 3 = Σ(category subtotals)
Total footprint = Scope 1 + Scope 2 + Scope 3 (tCO₂e)
```

Report:
- Base year and reporting year
- Organizational and operational boundaries
- Emissions by scope (tCO₂e)
- Emission factor sources and GWP values used
- Estimation methods for data gaps
- Uncertainty assessment (typically ±10-30% for Scope 3)

### 6. Verify calculations with independent review

For external reporting: third-party verification against ISO 14064-3 limited or reasonable assurance standard. For internal use: cross-check Scope 1 against energy bills; Scope 2 against electricity bills; Scope 3 screening against spend-based estimates.

## Common Mistakes

- **Using outdated GWP values (AR4 instead of AR6):** Methane GWP shifted from 25 to 27.9 — a 12% difference that matters at scale.
- **Reporting only Scope 1 and 2:** For most product companies, Scope 3 (especially sold products and purchased materials) represents >70% of the real footprint. Partial reporting misleads stakeholders.
- **Double-counting in complex supply chains:** Scope 3 of your upstream supplier may overlap with your Scope 3 purchased goods. Document scope carefully to avoid double-counting.

## When NOT to Use

- Product-level lifecycle assessment (LCA): use ISO 14044 LCA methodology instead — it includes impact categories beyond GHG (water use, toxicity, eutrophication) and is required for Environmental Product Declarations (EPD).
