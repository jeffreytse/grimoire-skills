---
name: design-optimization-problem
description: Use when formulating and solving an optimization problem — defining the objective function, constraints, variable types, and selecting an appropriate solver for linear, nonlinear, integer, or stochastic programming.
source: Boyd & Vandenberghe "Convex Optimization" (2004, free online); Nocedal & Wright "Numerical Optimization" 2nd ed. (2006); Bertsekas "Nonlinear Programming" 3rd ed. (2016)
tags: [optimization, linear-programming, convex-optimization, integer-programming, objective-function, operations-research]
---

# Design Optimization Problem

Formulate an optimization problem correctly — defining decision variables, objective function, and constraints — then select an appropriate solver based on problem class (LP, QP, NLP, MIP) to find solutions efficiently and reliably.

## Why This Is Best Practice

**Adopted by:** Optimization is the mathematical engine behind supply chain management (logistics companies: UPS, Amazon), financial portfolio optimization (Markowitz model, BlackRock), machine learning (gradient descent), engineering design (aerospace, automotive), and power grid dispatch (every electrical utility). Gurobi, CPLEX, and MOSEK are the gold-standard commercial solvers; GLPK, HiGHS, and SciPy are free alternatives.
**Impact:** Boyd & Vandenberghe (2004) demonstrated that convex optimization problems can be solved globally and efficiently — the key insight is that convexity identification determines whether a globally optimal solution is achievable or only a local optimum. An incorrectly formulated problem (non-convex when convex reformulation exists) can increase solve time from seconds to hours or produce local optima mistaken for global solutions.

## Steps

### 1. Define decision variables explicitly

Before writing the objective or constraints:
- List all variables the optimizer controls: x₁, x₂, ..., xₙ
- Specify type for each variable:
  - **Continuous (real-valued):** most efficient to optimize
  - **Integer:** introduces combinatorial complexity (NP-hard in general)
  - **Binary (0/1):** for yes/no decisions; subset of integer
- Specify bounds: lower and upper limits (l ≤ x ≤ u); explicit bounds help solvers dramatically

### 2. Formulate the objective function

Standard form: minimize f(x) [maximization: multiply by −1]

Write f(x) explicitly in terms of decision variables:
- **Linear:** f(x) = cᵀx → use LP solver
- **Quadratic:** f(x) = ½xᵀQx + cᵀx → QP solver (if Q is PSD; convex)
- **General nonlinear:** f(x) → NLP solver; check convexity
- **Multiple objectives:** weighted sum (add weights w₁f₁ + w₂f₂) or Pareto optimization

Check convexity of f(x): if Hessian ∇²f is positive semidefinite for all x → convex (global minimum guaranteed).

### 3. Formulate constraints

Three types:
- **Equality:** g(x) = 0 (reduces degrees of freedom by 1 per constraint)
- **Inequality:** h(x) ≤ 0 (feasible set is the region satisfying all inequalities)
- **Bound constraints:** l ≤ x ≤ u (always prefer to encode as bounds, not inequality constraints — solvers handle bounds directly)

Write constraints mathematically; verify units are consistent. Check feasibility: does a feasible point exist? (Empty feasible set = infeasible problem.)

### 4. Classify the problem and select solver

| Problem class | Objective | Constraints | Solver |
|--------------|-----------|-------------|--------|
| LP (Linear Programming) | Linear | Linear | HiGHS, Gurobi, GLPK |
| QP (Quadratic Programming) | Quadratic | Linear | Gurobi, OSQP, quadprog |
| SOCP (Second-Order Cone) | Convex | SOC constraints | MOSEK, SCS, ECOS |
| SDP (Semidefinite) | Linear | PSD constraint | MOSEK, SCS |
| NLP (Nonlinear, convex) | Convex nonlinear | Any | IPOPT, SNOPT |
| NLP (nonconvex) | Nonconvex | Any | IPOPT (local), Basin-Hopping, Differential Evolution |
| MIP (Mixed Integer) | Linear/quadratic | Linear + integer | Gurobi, CPLEX, HiGHS |

**Rule:** always try to reformulate as a convex problem before accepting a nonconvex formulation — convex problems have global optima and scale to thousands of variables.

### 5. Solve and verify the result

```python
# Example: LP with scipy
from scipy.optimize import linprog
result = linprog(c, A_ub=A, b_ub=b, bounds=bounds, method='highs')
print(result.status, result.fun, result.x)

# Example: convex QP with CVXPY
import cvxpy as cp
x = cp.Variable(n)
objective = cp.Minimize(0.5 * cp.quad_form(x, Q) + c.T @ x)
constraints = [A @ x <= b, x >= 0]
prob = cp.Problem(objective, constraints)
prob.solve()
```

Verification checklist:
- Status: check solver status = "Optimal" (not "Infeasible" or "Unbounded")
- Feasibility: verify all constraints satisfied at solution x*
- Objective value: is f(x*) reasonable given domain knowledge?
- Sensitivity: run with ±10% perturbation to parameters — is solution stable?

### 6. Interpret dual variables and sensitivity

For LP/QP, dual variables (shadow prices) quantify the value of relaxing each constraint by 1 unit:
- Dual variable λᵢ for constraint i: if λᵢ > 0, constraint i is binding — relaxing it improves objective by λᵢ per unit
- Reduced costs: identify which currently-zero variables would enter the basis if their cost changed

This analysis guides which constraints are most valuable to relax in practice.

## Common Mistakes

- **Nonconvex formulation when convex reformulation exists:** x/y (ratio) is nonconvex; but for y > 0, can often reformulate as SOCP or use epigraph form. Spend time on reformulation before invoking nonconvex solver.
- **Too many binary variables:** MIP complexity is exponential in the number of binary variables. Fewer binaries + tighter LP relaxation = dramatically faster solve.
- **No warm start for repeated similar problems:** Most solvers accept an initial guess; warm-starting from a nearby problem's solution reduces solve time 10×+ for online optimization.

## When NOT to Use

- Stochastic optimization where uncertainty is the main challenge: use stochastic programming (two-stage LP, scenario trees) or robust optimization frameworks instead of solving a single deterministic instance.
