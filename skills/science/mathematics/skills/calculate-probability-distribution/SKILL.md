---
name: calculate-probability-distribution
description: Use when working with probability distributions — identifying the correct distribution for a phenomenon, computing probabilities and quantiles, fitting distributions to data, and checking distributional assumptions statistically.
source: DeGroot & Schervish "Probability and Statistics" 4th ed. (2012); Casella & Berger "Statistical Inference" 2nd ed. (2002); Johnson et al. "Univariate Discrete Distributions" 3rd ed. (2005)
tags: [probability, statistics, distribution-fitting, hypothesis-testing, Bayesian, quantiles, random-variables]
---

# Calculate Probability Distribution

Identify and apply the correct probability distribution for a phenomenon — computing probabilities, fitting parameters from data, and validating distributional assumptions with goodness-of-fit tests — to support reliable probabilistic inference and simulation.

## Why This Is Best Practice

**Adopted by:** Actuarial science (loss distributions), reliability engineering (lifetime distributions), queueing theory (arrival processes), machine learning (likelihood functions), Bayesian inference (prior/posterior), and risk management all depend on correct probability distribution selection. SOA (Society of Actuaries) and CAS (Casualty Actuarial Society) exams test distribution fitting as a core competency. SciPy, R, and MATLAB provide standardized implementations of >100 distributions.
**Impact:** Misidentifying the distribution for a phenomenon leads to incorrect probability estimates. DeGroot & Schervish (2012) demonstrate that the difference between normal and heavy-tailed (e.g., Cauchy) distribution assumptions produces probability estimates that differ by orders of magnitude in the tails — precisely where risk decisions are made. Fitting a normal distribution to financial returns (which are leptokurtic) underestimates tail risk (Black Swan events) catastrophically.

## Steps

### 1. Match distribution type to the phenomenon

Select distribution family based on the variable's nature:

**Discrete distributions:**
| Phenomenon | Distribution | Parameters |
|-----------|-------------|------------|
| Binary outcome (success/failure) | Bernoulli | p |
| Count of successes in n trials | Binomial | n, p |
| Count until first success | Geometric | p |
| Count of rare events in interval | Poisson | λ |
| Count of successes without replacement | Hypergeometric | N, K, n |

**Continuous distributions:**
| Phenomenon | Distribution | Parameters |
|-----------|-------------|------------|
| Symmetric bell-shaped (Central Limit Theorem) | Normal (Gaussian) | μ, σ |
| Positively skewed, right-tailed | Log-normal, Gamma, Weibull | — |
| Uniform random selection | Uniform | a, b |
| Time between Poisson events | Exponential | λ |
| Lifetime / reliability modeling | Weibull | k, λ |
| Heavy-tailed extreme values | Pareto, GEV | α, x_min |
| Proportions (bounded 0,1) | Beta | α, β |

### 2. Compute key probabilities and quantiles

**For a Normal distribution X ~ N(μ, σ²):**
```python
from scipy import stats
dist = stats.norm(loc=mu, scale=sigma)
prob = dist.cdf(x)           # P(X ≤ x)
prob_range = dist.cdf(b) - dist.cdf(a)  # P(a ≤ X ≤ b)
x_q = dist.ppf(q)            # quantile: P(X ≤ x_q) = q
```

**For discrete distributions (Binomial):**
```python
dist = stats.binom(n=n, p=p)
prob_exact = dist.pmf(k)     # P(X = k)
prob_at_most = dist.cdf(k)   # P(X ≤ k)
```

**Key quantiles:**
- q = 0.95 → 95th percentile (one-sided 5% significance threshold)
- q = 0.975 → 97.5th percentile (two-sided 5% significance: ±1.96σ for Normal)
- q = 0.999 → 99.9th percentile (1-in-1000 event)

### 3. Fit distribution parameters from data

**Maximum Likelihood Estimation (MLE) — the standard approach:**
```python
import numpy as np
from scipy import stats

data = np.array([...])

# Fit normal distribution (returns mu_hat, sigma_hat)
mu_hat, sigma_hat = stats.norm.fit(data)

# Fit exponential distribution
loc_hat, scale_hat = stats.expon.fit(data, floc=0)  # fix location at 0
lambda_hat = 1 / scale_hat  # rate parameter

# Compare multiple candidate distributions
for dist_name in ['norm', 'lognorm', 'expon', 'gamma', 'weibull_min']:
    dist = getattr(stats, dist_name)
    params = dist.fit(data)
    ks_stat, ks_p = stats.kstest(data, dist_name, args=params)
    print(f"{dist_name}: KS p-value = {ks_p:.4f}")
```

**Method of Moments:** equate sample moments (mean, variance) to theoretical moments; less efficient than MLE but useful as starting value.

### 4. Validate distributional assumptions

Always verify fit before using in downstream analysis:

**Graphical tests:**
- Q-Q plot: plot sample quantiles vs. theoretical quantiles; points on the diagonal line = good fit; systematic deviations indicate wrong distribution family
- Histogram + fitted PDF overlay: visual assessment of fit

**Statistical goodness-of-fit tests:**
- **Kolmogorov-Smirnov (KS) test:** compares empirical vs. theoretical CDF; non-parametric; sensitive to the center of distribution
- **Anderson-Darling test:** like KS but more sensitive to tails; preferred for reliability/risk applications
- **Chi-squared goodness-of-fit:** for discrete distributions; requires adequate counts per bin (expected > 5)

P-value > 0.05 → insufficient evidence to reject the distribution (not proof it is correct).

### 5. Work with joint and conditional distributions

For two random variables X, Y:
```
Joint: f(x, y) = probability density at (x, y)
Marginal: f_X(x) = ∫ f(x, y) dy
Conditional: f(y|x) = f(x, y) / f_X(x)
Independence: f(x, y) = f_X(x) × f_Y(y)
```

Covariance and correlation:
```
Cov(X, Y) = E[(X-μX)(Y-μY)]
ρ = Cov(X,Y) / (σX σY) ∈ [−1, +1]
```

### 6. Apply the Central Limit Theorem where appropriate

For sample mean X̄ of n i.i.d. random variables with mean μ and variance σ²:
```
X̄ ~ N(μ, σ²/n)  approximately, for large n (typically n ≥ 30)
```
This justifies normal-approximation methods and confidence intervals for population means regardless of the underlying distribution.

## Common Mistakes

- **Assuming normality without checking:** Test with Q-Q plot and Anderson-Darling before using normal-theory inference. Heavy-tailed data (financial, insurance claims) produces intervals and p-values that are systematically wrong under normality.
- **Fitting many distributions and choosing the best-fitting without correction:** Multiple testing inflates false discovery rate. Use AIC/BIC for model selection when fitting many distributions to the same data.
- **Confusing the Poisson and Binomial for large n:** For n large and p small, Binomial(n,p) ≈ Poisson(np). The approximation holds well when n > 100 and np < 10.

## When NOT to Use

- Multivariate data with complex dependencies: use copulas or multivariate distributions (MVN, Dirichlet) rather than independent univariate fits — marginal fit correctness does not imply joint distribution fit.
