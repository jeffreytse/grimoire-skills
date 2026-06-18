---
name: design-numerical-simulation
description: Use when designing a numerical simulation — including Monte Carlo, finite difference, finite element, or agent-based models — specifying convergence criteria, uncertainty quantification, validation strategy, and computational resource requirements.
source: Press et al. "Numerical Recipes" 3rd ed. (2007); Law "Simulation Modeling and Analysis" 5th ed. (2015); Saltelli et al. "Global Sensitivity Analysis" (2008); Oberkampf & Roy "Verification and Validation in Scientific Computing" (2010)
tags: [numerical-simulation, Monte-Carlo, finite-element, convergence, uncertainty-quantification, validation]
---

# Design Numerical Simulation

Design a rigorous numerical simulation by defining the mathematical model, selecting the discretization or sampling method, specifying convergence criteria, quantifying uncertainty through sensitivity analysis, and validating results against analytical benchmarks or experimental data.

## Why This Is Best Practice

**Adopted by:** NASA, DOE national laboratories, ESA, and every major engineering company use formal Verification and Validation (V&V) frameworks for numerical simulations. ASME V&V 10 (structural mechanics), V&V 20 (fluid mechanics), and AIAA G-077A (aeronautics) are the authoritative standards. The FDA's "Assessing the Credibility of Computational Modeling and Simulation" (2023) requires V&V for medical device simulations.
**Impact:** Oberkampf & Roy (2010) demonstrate that simulation errors can be classified as verification errors (solving the equations wrong) vs. validation errors (solving the wrong equations) — a distinction that is critical for corrective action. The Space Shuttle Challenger and Columbia accidents were partly attributable to computational model failures that were not adequately validated. Quantifying simulation uncertainty (via sensitivity analysis and uncertainty propagation) is what separates credible simulations from false-precision tools.

## Steps

### 1. Define the mathematical model explicitly

Before writing any code:
- State governing equations: ODEs, PDEs, discrete maps, stochastic processes
- Specify physical parameters, units, and value ranges
- State all modeling assumptions explicitly (e.g., incompressible flow, elastic material, homogeneous mixing)
- Identify model limitations: what phenomena does the model exclude?

**Separation of concerns:** the mathematical model (what physics/system you're modeling) is distinct from the numerical method (how you solve it). Keep both explicit.

### 2. Select the simulation method

Match method to problem type:
- **Monte Carlo (MC):** sampling-based; for high-dimensional integrals, stochastic processes, uncertainty quantification; error ∝ 1/√N (slow convergence)
- **Quasi-Monte Carlo (QMC):** Halton, Sobol sequences instead of random; error ∝ 1/N (faster for smooth integrands)
- **Finite Difference Method (FDM):** discretize PDEs on a structured grid; simple to implement; best for regular geometries
- **Finite Element Method (FEM):** unstructured mesh; handles complex geometry; standard for structural mechanics (FEniCS, COMSOL, ANSYS)
- **Finite Volume Method (FVM):** conservative by construction; preferred for fluid dynamics (OpenFOAM)
- **Agent-Based Models (ABM):** individual-level rules produce population-level behavior; for complex systems (epidemics, social dynamics, ecosystems)

### 3. Set discretization parameters and convergence criteria

For spatial/temporal discretization:
- **Grid/time-step refinement study:** run simulation at 3 resolution levels (coarse, medium, fine); check convergence
- **Richardson extrapolation:** estimate exact solution from two resolutions:
  ```
  f_exact ≈ f_fine + (f_fine − f_medium) / (r^p − 1)
  where r = mesh refinement ratio, p = formal order of accuracy
  ```
- **Accept convergence when:** relative change between levels < tolerance (e.g., 1% for engineering; 0.1% for scientific)

For Monte Carlo:
- **N samples needed for target standard error:** SE = σ/√N → N = (σ/SE)²
- Run pilot simulation (N=100) to estimate σ; then compute required N for target SE
- Typical: N=10,000 for 1% SE; N=1,000,000 for 0.1% SE

### 4. Conduct verification

Verification = "solving the equations correctly"
- **Code verification:** test against method-of-manufactured-solutions (MMS) — construct a problem with exact analytical solution and verify code reproduces it at the expected convergence rate
- **Calculation verification:** confirm round-off error, discretization error, and iteration error are all within tolerance
- **Unit tests:** test individual components (integrators, boundary conditions, constitutive models) against simple known cases

### 5. Quantify uncertainty (UQ) and sensitivity

Distinguish two types:
- **Aleatory uncertainty:** inherent randomness in the system (model this with probability distributions)
- **Epistemic uncertainty:** parameter uncertainty from lack of knowledge (quantify via sensitivity analysis)

**Sensitivity analysis methods:**
- **Local (one-at-a-time):** perturb each parameter ±10%, measure output change; fast but misses interactions
- **Global (Sobol indices):** variance-based; correctly quantifies main effect and total effect; use SALib (Python) or R sensitivity package
- **Monte Carlo UQ:** propagate parameter distributions through model; report output distribution, not point estimate

Sobol first-order index Sᵢ: fraction of output variance attributable to parameter i.
Sobol total index Tᵢ: includes all interactions involving parameter i.

### 6. Validate against experimental data or analytical benchmarks

Validation = "solving the right equations"
- Compare simulation output to independent experimental measurements (not data used to calibrate the model)
- Use appropriate statistical comparison: not just visual inspection — compute residuals, RMSE, bias, and confidence intervals
- Report validation metrics clearly: "model predicts X within ±Y% of measurements across test cases A, B, C"
- Identify and acknowledge invalid regimes: where does the model fail?

## Common Mistakes

- **Running at one resolution only:** Without a mesh/step-size convergence study, simulation accuracy is unknown. Results may look plausible and be completely wrong.
- **Using the same data for calibration and validation:** Calibrated parameters will fit the calibration data by construction. Validation must use an independent dataset.
- **Reporting point estimates without uncertainty:** All simulations have uncertainty from parameters, discretization, and model form. Reporting only a point estimate implies false precision.

## When NOT to Use

- Physical intuition and analytical estimates suffice: if a back-of-envelope calculation or dimensional analysis gives sufficient accuracy for the decision, the overhead of a full numerical simulation is unwarranted.
