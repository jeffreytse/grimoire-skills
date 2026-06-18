---
name: design-pcr-experiment
description: Use when designing a polymerase chain reaction experiment — including primer design, thermal cycling conditions, control selection, and troubleshooting strategy to amplify a specific DNA or RNA target reliably.
source: Mullis et al. (1986) "Specific Enzymatic Amplification of DNA" (Cold Spring Harb Symp Quant Biol); Lorenz (2012) "Polymerase Chain Reaction: Basic Protocol Plus Troubleshooting" (J Vis Exp); Primer3 design guidelines (Rozen & Skaletsky, 2000)
tags: [PCR, molecular-biology, primer-design, DNA-amplification, qPCR, experimental-design]
---

# Design PCR Experiment

Design a reliable PCR experiment by systematically selecting primers, optimizing thermal cycling conditions, including correct controls, and building in a troubleshooting strategy before the first reaction is run.

## Why This Is Best Practice

**Adopted by:** PCR is the most widely used molecular biology technique globally. Every major research institution, clinical diagnostic lab, and forensic laboratory uses systematic PCR design protocols. qPCR (quantitative PCR) design follows MIQE Guidelines (Bustin et al., 2009) — minimum information for publication of quantitative real-time PCR experiments — adopted by journals including Nature Methods, Nucleic Acids Research, and PLOS ONE.
**Impact:** The most common PCR failures (non-specific amplification, no product, smearing) are almost entirely attributable to poor primer design or incorrect cycling conditions — both preventable with systematic design. Bustin et al. (2009) showed that >30% of published qPCR data was unreliable due to failure to follow basic design standards. Primer3-designed primers with calculated Tm within 1°C of each other produce dramatically higher first-attempt success rates than ad hoc design.

## Steps

### 1. Define the target sequence and amplicon

Before designing primers:
- Obtain the target sequence from NCBI (GenBank or RefSeq) — use the reference genome for your organism
- Define the amplicon region: for genomic DNA, include intron-spanning regions to distinguish cDNA from gDNA; for RT-PCR, span at least one exon-exon junction
- Target amplicon size: 100-300 bp for qPCR; 200-1000 bp for standard PCR (smaller = more efficient)

### 2. Design primers using systematic criteria

Use Primer3 (primer3.ut.ee) or equivalent; apply these constraints:
- **Length:** 18-22 bp (20 bp optimal)
- **Melting temperature (Tm):** 58-62°C; forward and reverse within 1-2°C of each other
- **GC content:** 40-60%; avoid GC or AT runs >4 bp
- **3' end:** avoid complementarity to itself or the other primer (risk of primer-dimer); avoid 3' G-clamp or T at the very end
- **Self-complementarity and hairpin:** ΔG > −3 kcal/mol (use OligoCalc or IDT OligoAnalyzer to verify)
- **Specificity:** BLAST both primers against the target genome — confirm no significant off-target hits; expect single amplicon

### 3. Set annealing temperature

Optimal annealing temperature (Ta):
- Start: Ta = Tm − 5°C (for standard Taq); refine with gradient PCR
- For high-fidelity polymerases (Q5, Phusion): Ta can be set closer to Tm; use NEB Tm Calculator
- Gradient PCR (if available): test Ta across 5-8°C range in first experiment to find optimal

### 4. Design the thermal cycling program

Standard protocol (50 µL reaction):
1. Initial denaturation: 95°C, 3-5 min (30 sec for hot-start)
2. Denaturation: 95°C, 30 sec
3. Annealing: Ta, 30 sec
4. Extension: 72°C, 1 min/kb
5. Repeat steps 2-4: 25-35 cycles (fewer = less error accumulation; more = lower starting template)
6. Final extension: 72°C, 5 min
7. Hold: 4°C

For qPCR: two-step protocol (combined annealing/extension at 60°C); follow MIQE guidelines for reference gene normalization.

### 5. Include required controls

Never run a PCR without:
- **Positive control:** known template that should amplify — confirms reagents work
- **No-template control (NTC):** water instead of template — detects contamination
- **No-reverse-transcriptase control (for RT-PCR):** confirms amplification is from cDNA, not genomic DNA contamination

### 6. Optimize reaction components if needed

If initial experiment fails:
- MgCl₂ titration: test 1.5-3.5 mM in 0.5 mM steps (Taq buffer usually provides 1.5 mM; higher Mg increases yield but reduces specificity)
- DMSO (1-5%): for GC-rich templates
- Betaine (1 M): for secondary structure or GC-rich targets
- Template amount: titrate from 1 ng to 100 ng for genomic DNA

## Common Mistakes

- **No BLAST check for primer specificity:** Primers with off-target genomic hits produce spurious bands and contaminate quantification.
- **Identical Tm primers without checking primer-dimer potential:** Primer-dimers generate signal in NTC and reduce amplification efficiency.
- **Running 40 cycles by default:** More cycles ≠ more target. After saturation, non-specific products amplify preferentially. 30-35 cycles is sufficient for most templates.

## When NOT to Use

- Extremely GC-rich regions (>75% GC): use specialized protocols (GC enhancers, LNA primers, or alternative amplification methods like Rolling Circle Amplification).
