---
name: design-circuit-experiment
description: Use when designing an experimental circuit — applying Ohm's law, Kirchhoff's laws, Thevenin/Norton equivalents, and RC/RL/RLC transient analysis to select components, calculate expected behavior, and plan measurements safely.
source: Hayt & Kemmerly "Engineering Circuit Analysis" 8th ed. (2012); Sedra & Smith "Microelectronic Circuits" 7th ed. (2015); Horowitz & Hill "The Art of Electronics" 3rd ed. (2015)
tags: [circuit-design, electronics, Ohm's-law, Kirchhoff, RC-circuit, Thevenin, experimental-physics]
---

# Design Circuit Experiment

Design a circuit experiment by applying Kirchhoff's laws to analyze the network, selecting components with appropriate ratings, computing transient and steady-state behavior, and planning measurement strategy with safety considerations.

## Why This Is Best Practice

**Adopted by:** IEEE standards govern circuit design practices in all electrical engineering applications. NIST and NBS trace resistance, voltage, and current measurement standards. Horowitz & Hill (2015) — the most-cited electronics reference for working physicists and engineers — explicitly teaches systematic circuit analysis before breadboarding. IPC (Association Connecting Electronics Industries) standards govern PCB design for commercial electronics.
**Impact:** Horowitz & Hill (2015) demonstrate that the most common experimental circuit failures (blown components, oscillation, incorrect measurements) are prevented by pre-experiment analysis rather than trial-and-error. Ohm's law and Kirchhoff's laws are the analytical foundation — designing without them produces unpredictable behavior, overloaded components, and measurement artifacts that contaminate data.

## Steps

### 1. Define the circuit objective and identify the topology

State clearly:
- What is the circuit supposed to do? (amplify, filter, convert, switch, measure)
- What are the input and output requirements? (voltage range, current, frequency, impedance)
- What power supply is available? (voltage, current capacity, AC or DC)

Identify the topology before calculating component values:
- **Voltage divider:** two resistors; output = fraction of input voltage
- **RC low-pass filter:** resistor + capacitor; attenuates high frequencies
- **Bridge circuit (Wheatstone):** four resistors; measures small resistance changes
- **Inverting amplifier (op-amp):** gain = −Rf/Rin
- **Series/parallel RLC:** resonant circuits; frequency-selective behavior

### 2. Apply Kirchhoff's Laws to analyze the network

**KVL (Kirchhoff's Voltage Law):** sum of voltages around any closed loop = 0
```
Σ V_drops = Σ V_rises   (around any closed loop)
```

**KCL (Kirchhoff's Current Law):** sum of currents at any node = 0
```
Σ I_in = Σ I_out   (at any node)
```

**Systematic mesh analysis procedure:**
1. Assign mesh currents (clockwise convention)
2. Write KVL for each mesh
3. Solve the system of equations for mesh currents
4. Calculate voltages from currents using V = IR

For n independent loops: n equations with n unknowns.

### 3. Calculate steady-state behavior

**Resistive networks:**
```python
# Ohm's Law: V = I × R
# Series resistors: R_total = R1 + R2 + ... + Rn
# Parallel resistors: 1/R_total = 1/R1 + 1/R2 + ... + 1/Rn

# Voltage divider
V_out = V_in × R2 / (R1 + R2)

# Current divider
I1 = I_total × R2 / (R1 + R2)
```

**Thevenin equivalent (simplify any linear circuit seen from 2 terminals):**
1. Vth = open-circuit voltage at terminals
2. Rth = resistance seen at terminals with all sources killed (V_sources → short; I_sources → open)
3. Equivalent circuit: Vth in series with Rth

Norton equivalent: In = Vth/Rth in parallel with Rth.

### 4. Analyze RC/RL/RLC transient behavior

**First-order RC circuit (step input Vs applied at t=0):**
```
vc(t) = Vs + (v0 − Vs) × e^(−t/τ)
τ = RC  (time constant)
```
At t=τ: vc = Vs + 0.368(v0−Vs); at t=5τ: circuit is within 1% of final value.

**First-order RL circuit:**
```
i(t) = i_final + (i0 − i_final) × e^(−t/τ)
τ = L/R
```

**Second-order RLC series circuit:**
Natural frequency: ωn = 1/√(LC)
Damping ratio: ζ = R/(2√(L/C))

Response types:
- ζ > 1: overdamped (no oscillation)
- ζ = 1: critically damped (fastest non-oscillatory)
- ζ < 1: underdamped (oscillates at ωd = ωn√(1−ζ²))

### 5. Select components with appropriate ratings

**Resistors:**
- Power rating P = I²R = V²/R; select rating ≥ 2× maximum expected dissipation
- 1/4W for low-power signal circuits; 1W, 5W, 10W for power applications
- Tolerance: 1% (E96 series) for precision; 5% (E24) for general use

**Capacitors:**
- Voltage rating ≥ 2× maximum voltage in circuit
- Electrolytic (polarized): large capacitance (1µF-10,000µF); low voltage rating; one direction only
- Ceramic: small capacitance (1pF-10µF); high frequency; non-polarized

**Fuses and protection:**
- Always include a fuse rated just above maximum expected current; protects against shorts

### 6. Plan the measurement strategy

Before powering the circuit:
- Calculate expected voltages and currents at key nodes — know what you should measure
- Multimeter probing: check power supply voltage first; then ground reference before signal nodes
- Oscilloscope: set trigger, time base, and voltage scale based on expected waveform
- Current measurement: insert ammeter in series (low-impedance); do not connect in parallel (short circuit)
- Safety check: are there any nodes with >50V that could cause electric shock? (50V is the threshold of physiological concern for DC)

## Common Mistakes

- **Forgetting to include the load in the voltage divider calculation:** A voltage divider's output voltage assumes no load; when a load R_L is connected, it forms a parallel combination with R2 that changes V_out significantly unless R_L >> R2.
- **Exceeding the power rating of resistors:** Resistors run hot or burn out when their power dissipation exceeds rating. Calculate P = V²/R for every resistor in the design.
- **Connecting electrolytic capacitors with reversed polarity:** Electrolytic capacitors are polarized; reverse polarity causes rapid deterioration and potential explosion at high voltages.

## When NOT to Use

- RF circuits above ~100 MHz: lumped circuit element analysis (Kirchhoff's laws) breaks down when component size approaches the wavelength; use distributed element analysis, transmission line theory, and S-parameter design methods.
