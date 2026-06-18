---
name: calculate-error-propagation
description: Use when calculating how measurement uncertainties propagate through mathematical operations — computing combined uncertainty for sums, products, powers, and general functions using partial derivative methods or Monte Carlo propagation.
source: Taylor "An Introduction to Error Analysis" 2nd ed. (1997); JCGM 100:2008 "Guide to the Expression of Uncertainty in Measurement" (GUM); Hughes & Hase "Measurements and their Uncertainties" (2010)
tags: [error-analysis, uncertainty, measurement, error-propagation, statistics, experimental-physics, metrology]
---

# Calculate Error Propagation

Propagate measurement uncertainties through mathematical operations using partial derivative methods — quantifying the combined uncertainty of a calculated result from uncertainties in measured input quantities, following GUM methodology.

## Why This Is Best Practice

**Adopted by:** ISO/IEC Guide 98-3 (GUM) is the international standard for measurement uncertainty, adopted by BIPM, NIST, PTB, NPL, and all national metrology institutes. Every ISO 17025-accredited testing laboratory reports uncertainty following GUM. Scientific journals (APS, Nature, ACS) require uncertainty quantification for experimental results.
**Impact:** Taylor (1997) demonstrates that improper error propagation produces either overconfident results (understated uncertainty, leading to false precision) or uselessly conservative bounds (overstated uncertainty). The 2019 redefinition of the SI system (fixing exact values of physical constants) was predicated on uncertainty analyses from multiple independent metrology institutes using GUM methodology. Incompatible scientific results between laboratories are often traceable to different uncertainty quantification practices.

## Steps

### 1. Classify uncertainty type

Following GUM, two approaches to evaluating standard uncertainty:
- **Type A evaluation:** statistical method — calculate standard deviation s from n repeated measurements: u_A = s/√n (standard error of the mean)
- **Type B evaluation:** non-statistical method — use specification sheets, calibration certificates, previous experience, physical reasoning; for rectangular distribution (uniform between ±a): u_B = a/√3; for normal distribution: u_B = (stated ±value) / coverage factor k

**Coverage factor k:** relates standard uncertainty to expanded uncertainty U = k·u_c
- k=1: 68% confidence level (1σ for normal distribution)
- k=2: 95% confidence level (2σ); most commonly reported
- k=3: 99.7% confidence level

### 2. Propagate uncertainties for standard operations

For quantity q calculated from measured values x₁, x₂, ..., each with uncertainty δx₁, δx₂, ...:

**General formula (partial derivative method / GUM):**
```
u_c(q) = √[Σᵢ (∂q/∂xᵢ)² · u²(xᵢ)]
```
Valid when inputs are uncorrelated and uncertainties are small relative to the value.

**Addition/subtraction: q = x ± y**
```
u(q) = √[u(x)² + u(y)²]
```
Absolute uncertainties add in quadrature.

**Multiplication/division: q = x·y or q = x/y**
```
u(q)/q = √[(u(x)/x)² + (u(y)/y)²]
```
Relative (fractional) uncertainties add in quadrature.

**Power: q = xⁿ**
```
u(q)/q = |n| · u(x)/x
```
Relative uncertainty multiplies by the exponent magnitude.

**General function q = f(x, y):**
```
u(q) = √[(∂f/∂x)² · u(x)² + (∂f/∂y)² · u(y)²]
```

### 3. Work through a complete example

Density calculation: ρ = m/V, where V = L × W × H (rectangular block)

Measurements:
- m = 125.4 ± 0.2 g
- L = 5.12 ± 0.01 cm; W = 3.08 ± 0.01 cm; H = 2.54 ± 0.01 cm

Step 1: V = 5.12 × 3.08 × 2.54 = 40.09 cm³
Step 2: Relative uncertainty in V:
```
u(V)/V = √[(0.01/5.12)² + (0.01/3.08)² + (0.01/2.54)²]
       = √[(0.00195)² + (0.00325)² + (0.00394)²]
       = √[3.8×10⁻⁶ + 1.06×10⁻⁵ + 1.55×10⁻⁵] = 0.0053 = 0.53%
u(V) = 0.0053 × 40.09 = 0.21 cm³
```
Step 3: Relative uncertainty in ρ:
```
u(ρ)/ρ = √[(u(m)/m)² + (u(V)/V)²] = √[(0.2/125.4)² + (0.0053)²]
        = √[(0.00160)² + (0.00530)²] = 0.0055 = 0.55%
ρ = 125.4/40.09 = 3.128 g/cm³
u(ρ) = 0.0055 × 3.128 = 0.017 g/cm³
```

Report: ρ = 3.13 ± 0.02 g/cm³ (k=1, 68% confidence)

### 4. Handle correlated uncertainties

When inputs are correlated (e.g., same instrument used for two measurements):
```
u²_c(q) = Σᵢ (∂f/∂xᵢ)² u²(xᵢ) + 2 Σᵢ<j (∂f/∂xᵢ)(∂f/∂xⱼ) u(xᵢ,xⱼ)
```
Where u(xᵢ,xⱼ) = r(xᵢ,xⱼ) · u(xᵢ) · u(xⱼ) is the covariance and r is the correlation coefficient.

For perfectly correlated (r=+1) variables: errors ADD, not in quadrature — worst case for systematic bias.

### 5. Use Monte Carlo propagation for complex functions

When partial derivatives are difficult or inputs have non-Gaussian distributions:
```python
import numpy as np

# Monte Carlo uncertainty propagation
N = 100000
m_samples = np.random.normal(125.4, 0.2, N)
L_samples = np.random.normal(5.12, 0.01, N)
W_samples = np.random.normal(3.08, 0.01, N)
H_samples = np.random.normal(2.54, 0.01, N)

rho_samples = m_samples / (L_samples * W_samples * H_samples)
rho_mean = np.mean(rho_samples)
rho_std = np.std(rho_samples)    # standard uncertainty
rho_95 = np.percentile(rho_samples, [2.5, 97.5])  # 95% CI
```

Monte Carlo propagation is especially important when uncertainties are large relative to the value, or when the function is strongly nonlinear.

## Common Mistakes

- **Adding uncertainties linearly instead of in quadrature:** Linear addition (δq = δx + δy) overestimates uncertainty; quadrature sum (δq = √(δx² + δy²)) is correct for independent uncertainties.
- **Confusing absolute and relative uncertainty:** When multiplying, relative uncertainties combine. When adding, absolute uncertainties combine. Mixing these up produces large errors.
- **Ignoring the dominant uncertainty source:** Calculate the contribution of each input to total uncertainty; focus improvement effort on the dominant term. Reducing sub-dominant uncertainties by 2× changes the total by <10%.

## When NOT to Use

- Asymmetric uncertainties that are very large (>30% of the measured value): the linear approximation breaks down; use full Monte Carlo with the actual underlying distributions.
