---
name: apply-linear-algebra-methods
description: Use when solving systems of linear equations, decomposing matrices, analyzing transformations, or working with eigenvalues and eigenvectors in applied mathematics, data science, physics, or engineering contexts.
source: Strang "Introduction to Linear Algebra" 5th ed. (2016); Horn & Johnson "Matrix Analysis" 2nd ed. (2013); Golub & Van Loan "Matrix Computations" 4th ed. (2013)
tags: [linear-algebra, matrix-decomposition, eigenvalues, systems-of-equations, numerical-methods, data-science]
---

# Apply Linear Algebra Methods

Solve linear systems, decompose matrices, and compute eigenstructures using numerically stable algorithms — selecting the right decomposition for the problem structure (sparse, symmetric, overdetermined) and interpreting results in the application context.

## Why This Is Best Practice

**Adopted by:** Linear algebra is the computational foundation of NumPy/SciPy (Python), MATLAB, R, Julia, and every numerical computing library. Google's PageRank, PCA in data science, finite element analysis in engineering, quantum mechanics, and computer graphics all reduce to matrix operations. LAPACK (Linear Algebra PACKage) is the authoritative numerical library used by all major scientific software.
**Impact:** Strang (2016) is the most widely used undergraduate linear algebra textbook globally, with MIT OpenCourseWare making it freely accessible. The eigenvalue problem — and its numerical solution via QR algorithm — underlies Google PageRank, principal component analysis, and quantum mechanics. Golub & Van Loan (2013) quantify the backward stability properties of major algorithms: unstable methods (e.g., normal equations for least squares) amplify errors quadratically vs. numerically stable methods (QR decomposition).

## Steps

### 1. Identify the problem structure before choosing an algorithm

The correct algorithm depends on matrix properties:
- **Is A square and non-singular?** → Gaussian elimination with partial pivoting (LU decomposition)
- **Is A symmetric positive definite?** → Cholesky decomposition (2× faster than LU; used in Kalman filter, covariance matrices)
- **Is A overdetermined (more equations than unknowns)?** → Least squares via QR decomposition (NOT normal equations)
- **Do you need eigenvalues?** → QR algorithm (symmetric: use symmetric QR; general: use Schur decomposition)
- **Is A sparse?** → Sparse direct methods (UMFPACK, SuperLU) or iterative (Conjugate Gradient for SPD, GMRES for general)

Never use A⁻¹ explicitly to solve Ax=b — compute factorization and solve via back-substitution. Computing the inverse is 3× more expensive and numerically less stable.

### 2. Solve Ax = b (square system)

Standard approach: LU decomposition with partial pivoting:
```python
import numpy as np
# WRONG: x = np.linalg.inv(A) @ b  (never do this)
# RIGHT:
x = np.linalg.solve(A, b)  # uses LU under the hood
```

Check solution quality:
```python
residual = np.linalg.norm(A @ x - b) / np.linalg.norm(b)
# Should be < 1e-10 for well-conditioned A; larger → ill-conditioned
cond_A = np.linalg.cond(A)
# Condition number > 1e8 → result may have few accurate significant digits
```

### 3. Solve overdetermined system (least squares)

For Ax ≈ b with A ∈ ℝᵐˣⁿ, m > n (more data points than unknowns):
```python
# QR decomposition approach (numerically stable):
x, residuals, rank, sv = np.linalg.lstsq(A, b, rcond=None)

# Direct QR:
Q, R = np.linalg.qr(A)
x = np.linalg.solve(R, Q.T @ b)
```

Never use normal equations (Aᵀx = Aᵀb, solved as x = (AᵀA)⁻¹Aᵀb) — condition number squares, amplifying errors.

### 4. Compute eigendecomposition

For symmetric (Hermitian) matrix A = QΛQᵀ:
```python
eigenvalues, eigenvectors = np.linalg.eigh(A)  # eigh for symmetric (faster, real eigenvalues)
# eigenvalues sorted ascending; eigenvectors are columns of output
```

For general square matrix A = PDP⁻¹ (if diagonalizable):
```python
eigenvalues, eigenvectors = np.linalg.eig(A)
```

Check: verify Av ≈ λv for each eigenpair (A @ eigenvectors[:,i] ≈ eigenvalues[i] * eigenvectors[:,i]).

### 5. Apply Singular Value Decomposition (SVD)

SVD = the most generally applicable matrix decomposition: A = UΣVᵀ
```python
U, sigma, Vt = np.linalg.svd(A, full_matrices=False)  # economy SVD
```

Applications:
- **PCA:** principal components = columns of V; variance explained = σᵢ² / Σσⱼ²
- **Low-rank approximation:** truncate to k singular values (image compression, latent semantic indexing)
- **Pseudoinverse:** A⁺ = VΣ⁺Uᵀ (scipy.linalg.pinv uses this)
- **Rank determination:** rank = number of singular values above threshold (σ > max(m,n) × σ_max × ε_machine)

### 6. Interpret results in context

Always connect results back to the application:
- **Eigenvalues of covariance matrix:** variance explained per principal component
- **Condition number:** sensitivity of solution to perturbations (rule of thumb: condition number ~10^k → lose k digits of accuracy)
- **Residual norm:** fit quality of least squares solution
- **Singular values near zero:** near-rank-deficiency; solution is not unique or is poorly determined

## Common Mistakes

- **Using np.linalg.inv(A) to solve Ax=b:** Explicit matrix inversion is slower and less accurate than solve(). Reserve it for when the inverse itself is the output.
- **Using np.linalg.eig instead of eigh for symmetric matrices:** eig on symmetric matrices may return complex eigenvalues due to numerical noise; eigh guarantees real eigenvalues and is faster.
- **Ignoring the condition number:** A condition number of 10¹² means 12 digits of input precision produce 0 accurate digits in the output. Check cond(A) before trusting results.

## When NOT to Use

- Systems too large for dense methods: for n > ~10,000, use sparse or iterative solvers (scipy.sparse.linalg) — dense methods scale as O(n³) and run out of memory.
