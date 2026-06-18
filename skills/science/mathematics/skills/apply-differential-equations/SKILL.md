---
name: apply-differential-equations
description: Use when modeling or solving differential equations — classifying ODE/PDE type, selecting analytical or numerical solution methods, validating solutions, and interpreting the physical or mathematical meaning of the result.
source: Strogatz "Nonlinear Dynamics and Chaos" 2nd ed. (2014); Boyce & DiPrima "Elementary Differential Equations" 11th ed. (2017); Hairer et al. "Solving Ordinary Differential Equations" (1993); Burden & Faires "Numerical Analysis" 10th ed. (2016)
tags: [differential-equations, ODE, PDE, numerical-methods, dynamical-systems, mathematical-modeling]
---

# Apply Differential Equations

Classify, solve, and validate differential equations — choosing between analytical solutions (exact, separation of variables, integrating factor) and numerical methods (RK4, stiff solvers, finite difference/element) appropriate to the problem structure and stiffness.

## Why This Is Best Practice

**Adopted by:** Differential equations model virtually all physical, biological, chemical, and engineering systems. Newton's laws, Maxwell's equations, Schrödinger equation, Navier-Stokes, the SIR epidemic model, Black-Scholes option pricing, and population dynamics are all differential equations. MATLAB ODE Suite, SciPy's solve_ivp, and Mathematica NDSolve are the standard numerical tools used in research and industry worldwide.
**Impact:** Strogatz (2014) demonstrates that even qualitative analysis of ODEs (phase portraits, stability analysis) reveals system behavior without solving explicitly — a method used in epidemiology (epidemic thresholds), neuroscience (neural firing patterns), and climate modeling (tipping points). Hairer et al. (1993) showed that choosing the wrong solver for a stiff ODE (e.g., explicit RK4 on a stiff chemical kinetics problem) produces exponentially growing errors and requires time steps 1000× smaller than the implicit alternative.

## Steps

### 1. Classify the differential equation

Before solving, identify the type — it determines the solution method:

**Ordinary Differential Equations (ODE):** one independent variable (usually time t)
- **Order:** highest derivative present (1st order: dy/dt = f(t,y); 2nd order: y'' + p(t)y' + q(t)y = g(t))
- **Linearity:** linear if y and all derivatives appear to the first power; nonlinear otherwise
- **Autonomy:** autonomous if f does not depend explicitly on t (dy/dt = f(y))

**Partial Differential Equations (PDE):** multiple independent variables
- **Elliptic** (Laplace, Poisson): equilibrium problems; no time dependence
- **Parabolic** (Heat equation): diffusion; marching in time
- **Hyperbolic** (Wave equation): wave propagation; second-order in both space and time

**Stiffness:** system is stiff if it contains time scales that differ by orders of magnitude; stiff systems require implicit solvers.

### 2. Apply analytical solution methods

**1st order ODE (dy/dt = f(t,y)):**
- **Separable:** if f(t,y) = g(t)h(y) → separate variables: dy/h(y) = g(t)dt; integrate both sides
- **Linear 1st order:** y' + P(t)y = Q(t) → use integrating factor μ(t) = e^∫P(t)dt
  - Solution: y = (1/μ) [∫μQ dt + C]
- **Exact equations:** M(x,y)dx + N(x,y)dy = 0 with ∂M/∂y = ∂N/∂x → exists F(x,y) = C

**Linear 2nd order with constant coefficients (ay'' + by' + cy = g(t)):**
- Characteristic equation: ar² + br + c = 0
- Roots:
  - Two real distinct: y = C₁e^(r₁t) + C₂e^(r₂t)
  - Repeated real root: y = (C₁ + C₂t)e^(rt)
  - Complex conjugate r = α ± βi: y = e^(αt)[C₁cos(βt) + C₂sin(βt)]
- Particular solution for non-homogeneous: method of undetermined coefficients (polynomial, exponential, sinusoidal forcing) or variation of parameters

**Laplace transform** (for IVP with forcing): transform to algebraic equation in s-domain; solve; inverse transform.

### 3. Select the numerical solver

For numerical solution, solver selection depends on problem type:

| Problem type | Recommended solver | Notes |
|-------------|-------------------|-------|
| Non-stiff ODE | RK45 (scipy default) | Runge-Kutta 4-5, explicit |
| Stiff ODE | Radau, BDF | Implicit; required for stiff problems |
| Highly stiff (chemistry) | LSODA (auto-detects stiffness) | Switches between Adams (non-stiff) and BDF |
| Oscillatory (Hamiltonian) | Symplectic integrator | Preserves energy; long-time accuracy |
| PDE (elliptic) | Finite element (FEniCS, FEniCSx) | — |
| PDE (time-marching) | Finite difference, method of lines | — |

```python
from scipy.integrate import solve_ivp

def f(t, y):
    return [-y[0] + y[1], -100*y[1]]  # stiff system

sol = solve_ivp(f, t_span=[0, 10], y0=[1, 0],
                method='Radau',  # or 'BDF' for stiff
                dense_output=True, rtol=1e-8, atol=1e-10)
```

### 4. Set tolerance and step size

- **Relative tolerance (rtol):** controls relative error; rtol=1e-6 means ~6 significant figures
- **Absolute tolerance (atol):** controls error for near-zero values; set to ~10× smaller than smallest meaningful value
- Never use rtol > 1e-3 for any published scientific computation
- Default tolerances (rtol=1e-3) are for quick checks only

Verify solution quality: halve the step size (or tighten tolerances) and check if solution changes meaningfully.

### 5. Conduct qualitative/stability analysis

For autonomous systems dy/dt = f(y), without solving explicitly:
- **Fixed points:** solve f(y*) = 0
- **Linearization:** compute Jacobian J = ∂f/∂y at each fixed point
- **Stability:** eigenvalues of J determine type:
  - All Re(λ) < 0: stable node/spiral (attracting)
  - Any Re(λ) > 0: unstable (repelling)
  - Re(λ) = 0: center or limit cycle (requires nonlinear analysis)

Phase portrait analysis reveals long-term behavior without numerical integration.

### 6. Validate the solution

For analytical solutions: verify by differentiating and substituting back into the ODE. Check initial/boundary conditions.

For numerical solutions:
- Compute at two different tolerances; compare solutions
- Compare with known analytical solution for simple limits
- Check conservation laws (energy, mass) if applicable
- Plot solution and residual; check for oscillations or drift

## Common Mistakes

- **Using explicit RK4 on a stiff system:** Step size must be smaller than 1/max_eigenvalue(Jacobian). For stiff problems (eigenvalue ratio 1:10⁶), RK4 requires millions of tiny steps where an implicit solver takes hundreds.
- **Not checking uniqueness:** Without Lipschitz continuity of f, existence and uniqueness are not guaranteed. Blow-up solutions and non-uniqueness occur in finite time for some nonlinear ODEs.
- **Confusing general solution with particular solution:** The general solution contains integration constants (C₁, C₂). Apply initial conditions last, after finding the general form.

## When NOT to Use

- Fractional-order differential equations (modeling anomalous diffusion, viscoelasticity): require specialized fractional calculus solvers; standard ODE integrators cannot handle fractional derivatives.
