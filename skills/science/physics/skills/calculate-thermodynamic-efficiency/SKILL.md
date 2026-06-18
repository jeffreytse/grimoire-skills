---
name: calculate-thermodynamic-efficiency
description: Use when analyzing the thermodynamic efficiency of heat engines, refrigerators, power cycles, or chemical processes — applying the first and second laws of thermodynamics, Carnot efficiency, entropy analysis, and exergy to identify losses and optimization targets.
source: Çengel & Boles "Thermodynamics: An Engineering Approach" 8th ed. (2015); Moran et al. "Fundamentals of Engineering Thermodynamics" 8th ed. (2018); Bejan "Advanced Engineering Thermodynamics" 4th ed. (2016)
tags: [thermodynamics, efficiency, Carnot, heat-engine, entropy, exergy, energy-conversion, engineering]
---

# Calculate Thermodynamic Efficiency

Analyze thermodynamic efficiency of heat engines, power cycles, and thermal systems by applying first and second law analysis — computing Carnot efficiency bounds, actual cycle efficiency, entropy generation, and exergy destruction to identify where losses occur.

## Why This Is Best Practice

**Adopted by:** Every power plant, refrigeration system, and chemical process is designed and analyzed using thermodynamic cycle analysis. ASHRAE (American Society of Heating, Refrigerating and Air-Conditioning Engineers) standards require thermodynamic efficiency analysis for HVAC system certification. The DOE uses exergy analysis to identify where US industrial energy use is most inefficient (DOE Bandwidth Studies).
**Impact:** Çengel & Boles (2015) demonstrate that the Carnot efficiency sets an inviolable upper bound — any claimed efficiency exceeding the Carnot limit for the temperature ratio is physically impossible and indicates an error. Real power plant efficiencies are 30-50% of the Carnot limit; identifying where the remaining 50-70% is lost requires second law (entropy/exergy) analysis. Bejan (2016) established exergy analysis as the tool that reveals the location, magnitude, and source of irreversibilities — giving engineers a clear optimization target.

## Steps

### 1. Define the system boundary and state the problem

Before any calculation:
- Identify: working fluid, heat source temperature (TH), heat sink temperature (TL)
- State: is this a heat engine (work output) or heat pump/refrigerator (work input)?
- Define: steady-state or transient? Open or closed system?
- List: all energy interactions crossing the system boundary

### 2. Apply the first law (energy balance)

**First Law: energy is conserved**

For a cycle (net change in stored energy = 0):
```
W_net = Q_H − Q_L     (heat engine)
Q_H = W_net + Q_L     (heat pump)
```

For a process (steady-flow open system):
```
Q̇ − Ẇ = ṁ[(h₂ − h₁) + ½(V₂² − V₁²) + g(z₂ − z₁)]
```
Where h = specific enthalpy (from steam tables, ideal gas relations, or refrigerant charts).

### 3. Calculate Carnot efficiency (theoretical maximum)

The Carnot efficiency is the upper bound for any heat engine operating between TH and TL (temperatures must be in Kelvin):
```
η_Carnot = 1 − TL/TH
```

For a refrigerator or heat pump (COP — Coefficient of Performance):
```
COP_Carnot,R = TL / (TH − TL)    (refrigerator: heat removed per unit work)
COP_Carnot,HP = TH / (TH − TL)   (heat pump: heat delivered per unit work)
```

Example: steam power plant with boiler at 600°C and condenser at 40°C:
```
η_Carnot = 1 − (40+273)/(600+273) = 1 − 313/873 = 0.642 = 64.2%
```
Actual plant efficiency of 35-40% is 54-62% of Carnot maximum — identifying where the remaining loss occurs requires second law analysis.

### 4. Analyze the actual cycle (Rankine, Brayton, Otto, Diesel)

**Rankine cycle (steam power):**
```
η_thermal = W_net / Q_H = (W_turbine − W_pump) / Q_boiler
η_thermal = [(h₁ − h₂) − (h₄ − h₃)] / (h₁ − h₄)
```
Read h values from steam tables at the relevant T,P states.

**Isentropic efficiency of turbine/compressor:**
```
η_turbine = W_actual / W_isentropic = (h₁ − h₂a) / (h₁ − h₂s)
η_compressor = W_isentropic / W_actual = (h₂s − h₁) / (h₂a − h₁)
```

Typical isentropic efficiencies: turbine 85-92%; compressor 75-85%.

### 5. Apply the second law — entropy and irreversibility

**Entropy balance for a closed system:**
```
S₂ − S₁ = ∫(δQ/T) + S_gen
```
Where S_gen ≥ 0 (equality for reversible; strict inequality for irreversible).

**Entropy generation for a process:**
```
Ṡ_gen = ṁ(s₂ − s₁) − Q̇/T_boundary ≥ 0
```

Sources of entropy generation (irreversibilities):
- Heat transfer across finite temperature difference
- Fluid friction (pressure drops)
- Mixing of streams at different temperatures/compositions
- Chemical reactions far from equilibrium

### 6. Conduct exergy analysis to locate losses

Exergy = maximum useful work extractable relative to environment (T₀, P₀):
```
Exergy of a stream: ex = (h − h₀) − T₀(s − s₀)
Exergy destruction: Ẋ_destroyed = T₀ · Ṡ_gen  (Gouy-Stodola theorem)
```

Exergy efficiency (second-law efficiency):
```
η_II = Exergy output / Exergy input = 1 − (Ẋ_destroyed / Ẋ_input)
```

Exergy analysis reveals which component loses the most work potential — the one with largest Ẋ_destroyed is the priority for engineering improvement.

## Common Mistakes

- **Using Celsius instead of Kelvin in Carnot formula:** η = 1 − TL/TH requires absolute temperatures. Using Celsius gives physically meaningless and incorrect results.
- **Confusing thermal efficiency and second-law efficiency:** A device with 90% first-law efficiency (very little heat loss) can have 10% second-law efficiency (enormous irreversibilities from mixing or friction).
- **Treating reversible efficiency as achievable:** Carnot and isentropic processes are ideal references — no real device achieves them. Always compare real vs. Carnot to assess performance.

## When NOT to Use

- Non-equilibrium thermodynamics (coupled transport processes, biological systems): equilibrium thermodynamics applies to quasi-static processes; for systems far from equilibrium, use irreversible thermodynamics (Onsager coefficients, entropy production rate density).
