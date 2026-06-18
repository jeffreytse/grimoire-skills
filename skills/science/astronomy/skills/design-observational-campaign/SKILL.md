---
name: design-observational-campaign
description: Use when planning an astronomical observing campaign — selecting target list, scheduling observations around constraints (sky brightness, airmass, telescope time), estimating exposure times, and designing a data quality assurance strategy.
source: Kitchin "Astrophysical Techniques" 6th ed. (2013); Howell "Handbook of CCD Astronomy" 2nd ed. (2006); ESO Phase 2 Proposal Guidelines; NOAO Observing Guide
tags: [observational-astronomy, observing-campaign, exposure-time, airmass, CCD-astronomy, telescope-scheduling]
---

# Design Observational Campaign

Plan an observing campaign by scheduling targets within sky and telescope constraints, calculating required exposure times for target signal-to-noise, designing calibration frames, and building a contingency plan for variable conditions.

## Why This Is Best Practice

**Adopted by:** ESO (European Southern Observatory), NOAO, STScI (Hubble Space Telescope), and all major observatories use formal Phase 1 (proposal) and Phase 2 (scheduling) observation planning frameworks. ALMA requires detailed observing parameter justification including expected sensitivity, angular resolution, and atmospheric constraint specification. Gemini, Keck, and VLT all enforce systematic observation design as a prerequisite for time allocation.
**Impact:** Howell (2006) demonstrates that exposure time calculation is the single most important pre-observation step — an under-exposed observation is useless (insufficient S/N to detect the target), while over-exposure wastes precious telescope time and saturates the detector. Proper scheduling to minimize airmass maximizes data quality; Kitchin (2013) shows that observing at airmass 2.0 (30° elevation) rather than 1.0 (zenith) increases sky background by a factor of 2 and attenuates signal by a further factor of ~2-3 due to increased atmospheric extinction.

## Steps

### 1. Define the science case and observational requirements

Before any scheduling:
- **What are you measuring?** Photometric brightness, spectrum, polarization, astrometry, timing
- **What signal-to-noise ratio (S/N) is required?** Photometry: S/N ≥ 50-100 for 1-2% precision; spectroscopy: S/N ≥ 20 per resolution element for line detection
- **What resolution is required?** Angular (arcsec), spectral (R = λ/Δλ), temporal (cadence in s/min/days)
- **What are the critical constraints?** Moon phase (dark/grey/bright time), seeing requirement (FWHM ≤ 0.7"?), time sensitivity (transient event, orbital phase coverage)

### 2. Calculate required exposure time (signal-to-noise budget)

For CCD photometry, the signal-to-noise ratio is:
```
S/N = N_star / √(N_star + n_pix × (N_sky + N_dark + N_read²/G²))
```
Where:
- N_star = star photons detected per second × exposure time
- N_sky = sky background photons per pixel per second × exposure time
- N_dark = dark current (e⁻/pixel/sec) × exposure time
- N_read = readout noise (e⁻ RMS per pixel)
- n_pix = number of pixels in the aperture
- G = gain (e⁻/ADU)

**Simplified for bright-sky-background-limited case:**
```
t_exp ≈ (S/N)² × N_sky / N_star²
```

Estimate N_star using the instrument's quantum efficiency, filter transmission, and magnitude of the target (convert to flux using Vega or AB zero-points).

Use ESO Exposure Time Calculator (ETC), SIGNAL (CFHT), or ITC tools for your telescope/instrument — always use the official ETC before proposing.

### 3. Compile the target list and prioritize

For each target, record:
- Coordinates (RA, Dec, J2000)
- Magnitude in relevant band(s)
- Size (for extended objects — impacts sky subtraction annulus)
- Time-critical constraints (transit timing, orbital phase, outburst activity)
- Minimum required sky conditions (seeing, transparency)

Prioritize targets:
1. Time-critical (transient, eclipse, conjunction) — schedule first
2. Sky-condition-sensitive (faint, small angular size) — schedule in best seeing windows
3. Bright calibrators — can observe in any conditions

### 4. Schedule to minimize airmass and sky brightness

**Airmass X = sec(z)** where z is the zenith angle:
- X = 1.0: at zenith (best; minimum extinction and seeing)
- X = 1.41: 45° altitude
- X = 2.0: 30° altitude (acceptable; atmospheric extinction ≈ 0.6 mag worse than zenith)
- X > 2.5: generally not scientifically useful (high extinction, poor seeing)

**Rule:** observe each target within 30° of the meridian (minimum airmass point), but not closer than 1h before or after transit for safety.

**Moon avoidance:**
- Dark time: moon below horizon or illumination < 30%
- Grey time: moon illumination 30-70%
- Bright time: moon illumination > 70%
- Angular separation from moon: ≥ 20° absolute minimum; ≥ 45° for faint blue objects (Rayleigh scattering from moon)

Use Stellarium, pyephem, astropy, or online visibility tools (e.g., ESO Visibility Tool) to schedule.

### 5. Plan calibration frames

For every science observation, acquire:
- **Bias frames:** minimum 10-20; captures readout pattern and electronic offset; take at beginning and end of night
- **Dark frames:** match exposure time to science exposures; required if dark current is non-negligible (>10 e⁻/pixel/hr)
- **Flat fields:** minimum 10 per filter used; sky flats (at dusk/dawn) or dome flats; flat-field correction removes pixel-to-pixel QE variation and vignetting
- **Standard star observations:** photometric standards from Landolt or Smith (SDSS) catalog; observe at 2-3 different airmasses to solve for extinction coefficient; acquire within 30 min of science target observations

### 6. Build contingency and backup plans

Observing conditions are variable:
- **Backup targets:** prepare a list of brighter/larger targets observable in poor seeing or thin clouds; sort by target brightness and sky area
- **Abort criteria:** define minimum acceptable conditions before starting (e.g., seeing > 1.5" → abort spectroscopy, switch to imaging; thin clouds → abort photometric standard observations)
- **Recovery plan:** if interrupted mid-sequence, document at what orbital phase / cadence point you stopped; partial sequences are still scientifically useful for most programs

## Common Mistakes

- **Not accounting for overheads (readout, slew, telescope setup):** Only ~60-75% of allocated time is "on-sky shutter-open" time for typical programs. Plan realistic exposure counts accounting for 3-5 min overheads per target.
- **Scheduling targets at high airmass because they fit the time slot:** A target at airmass 3.0 may produce data too poor to analyze. Better to skip and revisit the next night than take useless data.
- **Observing photometric standards only at one airmass:** Solving for extinction requires standards at two or more airmass values. A single airmass observation cannot determine the extinction coefficient.

## When NOT to Use

- Space-based telescopes with fixed scheduling windows: HST, Chandra, JWST proposals follow different (proposal-driven) scheduling frameworks managed by STScI/CXC with dedicated scheduling software.
