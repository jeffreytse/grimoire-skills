---
name: review-gel-electrophoresis
description: Use when analyzing agarose or polyacrylamide gel electrophoresis results — to correctly identify bands, assess purity and integrity of nucleic acid or protein samples, and systematically troubleshoot unexpected results.
source: Sambrook & Russell "Molecular Cloning: A Laboratory Manual" 4th ed. (2012); Current Protocols in Molecular Biology (Ausubel et al.); Bio-Rad Electrophoresis Technical Guide
tags: [gel-electrophoresis, agarose-gel, DNA-analysis, protein-analysis, troubleshooting, molecular-biology]
---

# Review Gel Electrophoresis

Accurately read electrophoresis results by comparing band positions to size standards, assessing sample quality, and applying a systematic troubleshooting framework when results are unexpected.

## Why This Is Best Practice

**Adopted by:** Gel electrophoresis interpretation is a core competency in every molecular biology, biochemistry, and clinical laboratory. FDA, EMA, and ICH guidelines require gel-based quality controls for nucleic acid therapeutics and molecular diagnostics. Good Laboratory Practice (GLP) standards mandate documented interpretation procedures for regulated laboratories.
**Impact:** Misinterpretation of gel results leads to false conclusions about PCR success, restriction digestion completeness, protein expression, or sample purity. In regulated contexts (clinical diagnostics, pharmaceutical QC), misread gels cause downstream process failures and costly repeats. Systematic interpretation — including band sizing against a ladder and assessment of smearing/degradation — prevents the most common analytical errors.

## Steps

### 1. Set up the gel correctly before interpreting

Prerequisites for valid interpretation:
- DNA ladder/protein marker loaded in the first and last lane (or every 5-6 lanes for wide gels)
- Gel percentage appropriate for the target size range:
  - DNA: 0.8% agarose (>2kb); 1.5% (100-2000bp); 2-3% (50-500bp)
  - Protein: 10% PAGE (25-100 kDa); 12-15% (10-50 kDa); 4-20% gradient (wide range)
- Run at correct voltage: 80-120V for agarose DNA gels; too fast = band distortion

### 2. Determine band positions and sizes

Procedure:
1. Identify all ladder bands — cross-reference with the ladder's reference card (not from memory)
2. Construct a standard curve: plot log(size) vs. migration distance from the well for each ladder band
3. Extrapolate unknown band sizes from the standard curve
4. Alternatively: estimate by bracketing — identify the two ladder bands above and below the unknown band

Expected vs. actual size:
- Within 10% of calculated size = consistent with prediction
- 10-20% difference = acceptable if band is single and sharp
- >20% difference or double bands = investigate further before proceeding

### 3. Assess band quality indicators

Read each lane for:
- **Sharp, discrete bands:** correct result; well-resolved product
- **Smearing (diffuse trailing below band):** RNA/DNA degradation, or overloading (reduce template next time)
- **Smearing (entire lane, top to bottom):** severe degradation or protein contamination in DNA prep
- **Multiple bands where one expected:** non-specific amplification (redesign primers or optimize cycling); incomplete digestion (extend digestion time)
- **No band:** failed amplification; check controls before troubleshooting
- **Faint band:** insufficient template, low cycle number, or inhibitors present

### 4. Interpret control lanes

Always read control lanes before experimental lanes:
- **Positive control has expected band:** reagents are functional; failure is sample-specific
- **Positive control fails:** reagent failure; results are invalid regardless of experimental lanes
- **NTC shows a band:** contamination present; results are suspect; clean the workspace
- **No-RT control shows band in RT-PCR:** genomic DNA contamination; redesign with exon-spanning primers or DNase treat RNA

### 5. Troubleshoot systematically by symptom

| Symptom | Most likely cause | Fix |
|---------|------------------|-----|
| No bands (NTC also empty) | Failed amplification: polymerase inactivated, wrong Mg, no template | Check reagents; increase template |
| Bands in NTC | Contamination | Decontaminate; use aliquoted reagents |
| Multiple bands | Non-specific amplification | Increase annealing temperature; redesign primers |
| Smearing | Degradation or overload | Check RNA/DNA integrity; reduce template load |
| Band wrong size | Wrong product; primer mismatch | BLAST-verify primers; sequence the band |
| Faint bands | Low efficiency | Optimize Mg, annealing temp; increase cycles |

### 6. Document the result

For regulated and publishable work:
- Photograph gel with appropriate exposure (bands visible but not saturated)
- Label: sample IDs, ladder identity, percentage gel, date, voltage, duration
- Save raw image; do not crop ladder lanes in published figures (Nature, PLOS, journals require full gel in supplementary)

## Common Mistakes

- **Estimating band size without a ladder in the same run:** Gel percentage and run conditions vary; always run a ladder in the same gel.
- **Ignoring control lanes:** Controls encode the interpretation of the entire gel. Read them first.
- **Proceeding with a smeared band:** A smear indicates a quality problem. Quantifying a smeared band produces unreliable downstream data.

## When NOT to Use

- High-resolution quantitative sizing: capillary electrophoresis (Bioanalyzer, TapeStation) provides more accurate sizing and quantification for RNA integrity (RIN) and DNA fragment analysis.
