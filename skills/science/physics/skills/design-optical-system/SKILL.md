---
name: design-optical-system
description: Use when designing an optical system — including lenses, mirrors, apertures, and detectors — applying geometric optics (ray tracing), the thin lens equation, aberration analysis, and diffraction limits to achieve target imaging performance.
source: Hecht "Optics" 5th ed. (2017); Smith "Modern Optical Engineering" 4th ed. (2007); Saleh & Teich "Fundamentals of Photonics" 3rd ed. (2019); Born & Wolf "Principles of Optics" 7th ed. (1999)
tags: [optics, lens-design, ray-tracing, diffraction, aberration, imaging-systems, photonics]
---

# Design Optical System

Design an optical system by applying geometric optics for ray tracing, the thin lens equation for image location, f-number and numerical aperture for light collection, and diffraction limit for resolution — then identifying dominant aberrations and their mitigation.

## Why This Is Best Practice

**Adopted by:** Optical engineering (Zemax, Code V, OpticStudio) uses systematic ray tracing and aberration analysis as the design workflow for every commercial optical product from camera lenses to telescopes, microscopes, and laser systems. NASA uses optical system design for space telescopes (Hubble, James Webb). FDA requires optical coherence tomography (OCT) and fundus camera optics to be designed to specified imaging performance benchmarks.
**Impact:** Smith (2007) demonstrated that systematic geometric optics analysis — applied before fabrication — reduces design iteration cycles from years to weeks. James Webb Space Telescope's mirror segments were designed using aberration theory to achieve diffraction-limited performance at mid-IR wavelengths across a 6.5m primary mirror. An optical system designed without aberration analysis produces a prototype that is systematically blurred or distorted — requiring expensive redesign.

## Steps

### 1. Define the system requirements

Before any optical calculation:
- **Field of view (FOV):** full angle subtended by the scene
- **Working distance:** distance from front element to object
- **Magnification:** image size / object size
- **Wavelength range:** determines coating requirements, detector selection, chromatic aberration
- **Resolution requirement:** line pairs/mm (for imaging) or angular resolution (for telescopes)
- **Aperture requirement:** light collection (astronomy, low-light) or depth of field control (photography)

### 2. Apply the thin lens equation for image location

For a single thin lens with focal length f:
```
1/f = 1/do + 1/di
```
Where:
- do = object distance (positive for real object)
- di = image distance (positive for real image on far side of lens)
- f > 0: converging lens; f < 0: diverging lens

Lateral magnification:
```
m = −di/do
```
Negative m = inverted image; |m| < 1 = minified; |m| > 1 = magnified.

**Lensmaker's equation** (relating f to lens geometry):
```
1/f = (n−1)[1/R₁ − 1/R₂]
```
Where n = refractive index, R₁, R₂ = radii of curvature (sign convention: positive if center of curvature is to the right).

### 3. Calculate f-number, NA, and light collection

**F-number (f/#):** controls depth of field and diffraction limit
```
f/# = f / D
```
Where D = entrance pupil diameter. Small f/# (fast lens) = more light, shallower depth of field.

**Numerical Aperture (NA):** for objectives and fiber optics
```
NA = n · sin(θ)
```
Where θ = half-angle of maximum cone of light, n = medium refractive index. NA = 1.0 in air (theoretical max); oil immersion objectives reach NA = 1.4.

Light collection efficiency ∝ 1/(f/#)² or ∝ NA².

### 4. Calculate diffraction-limited resolution

The Rayleigh criterion (minimum resolvable separation):
```
r = 1.22 · λ / D = 0.61 · λ / NA   (for circular aperture)
```

For telescopes (angular resolution):
```
θ_Rayleigh = 1.22 · λ / D   (radians)
```

Example: 200mm telescope aperture at λ=550nm:
```
θ = 1.22 × 550×10⁻⁹ / 0.200 = 3.36×10⁻⁶ rad = 0.69 arcseconds
```

This is the theoretical limit — any real system performs at or above this limit, never below.

For camera sensors: verify pixel size matches diffraction-limited spot size (pixel ≤ Airy disk diameter / 2 to avoid spatial aliasing).

### 5. Identify and mitigate aberrations

**Aberrations** are deviations from ideal imaging — seven primary Seidel aberrations:
| Aberration | Symptom | Mitigation |
|-----------|---------|-----------|
| Spherical | Blur circle at all field positions | Aspherical surfaces, lens splitting |
| Coma | Comet-shaped blur at off-axis | Aplanatic design |
| Astigmatism | Different focus in tangential/sagittal planes | Correct ratio of radii |
| Field curvature | Focus at center ≠ edge | Field flattener element |
| Distortion | Non-uniform magnification | Symmetric doublet arrangement |
| Chromatic (axial) | Different focus for different wavelengths | Achromatic doublet (crown + flint glass) |
| Lateral chromatic | Color fringing at edges | Apochromat (3 elements) |

Rule of thumb: spherical aberration dominates for large apertures; chromatic aberration dominates for broadband systems.

### 6. Trace rays through multi-element systems using matrix optics

For sequential multi-element systems, use the ABCD transfer matrix:
- **Refraction at surface:** M = [[1, 0], [−P, 1]] where P = (n₂−n₁)/R
- **Propagation distance d:** M = [[1, d], [0, 1]]
- **System matrix:** M_total = Mₙ × ... × M₂ × M₁

```python
import numpy as np
def propagate(d):
    return np.array([[1, d], [0, 1]])

def refract(P):  # P = (n2-n1)/R
    return np.array([[1, 0], [-P, 1]])

# System matrix
M = refract(P2) @ propagate(d) @ refract(P1)
```

EFL (effective focal length) = −1/M[1,0] when the system is in air on both sides.

## Common Mistakes

- **Ignoring chromatic aberration for broadband systems:** A single glass lens has Abbe number that determines chromatic splitting. For white light, use an achromatic doublet (two glasses with different dispersion).
- **Setting detector pixel size much smaller than the diffraction limit:** Pixels smaller than the Airy disk don't improve resolution (oversampling); they increase data rate without information gain.
- **Designing for only the on-axis performance:** Real-world systems must image across a field of view; off-axis aberrations (coma, astigmatism) are typically larger than on-axis aberrations.

## When NOT to Use

- Wave optics systems (holography, interferometry, coherent fiber): geometric optics (ray tracing) is an approximation that fails when diffraction and interference are the primary phenomena of interest.
