---
name: apply-crispr-design-principles
description: Use when designing a CRISPR-Cas9 (or Cas12/Cas13) gene editing experiment — selecting guide RNAs, evaluating on-target efficiency and off-target risk, choosing delivery strategy, and designing assays to confirm editing outcome.
source: Doench et al. (2016) "Optimized sgRNA design to maximize activity and minimize off-target effects" (Nature Biotechnology); Hsu et al. (2013) "DNA targeting specificity of RNA-guided Cas9 nucleases" (Nature Biotechnology); Addgene CRISPR Guide (www.addgene.org/guides/crispr)
tags: [CRISPR, gene-editing, sgRNA, Cas9, off-target, molecular-biology, genome-editing]
---

# Apply CRISPR Design Principles

Design a CRISPR genome editing experiment by selecting high-efficiency guide RNAs with minimal off-target potential, choosing appropriate delivery and selection strategies, and building in rigorous editing confirmation assays.

## Why This Is Best Practice

**Adopted by:** NIH, Broad Institute, Wellcome Sanger Institute, and every major research institution conducting genome editing use systematic CRISPR design tools (Benchling, CRISPOR, CHOPCHOP, Cas-OFFinder) rather than ad hoc guide selection. The FDA's guidance on CRISPR-based therapeutics requires comprehensive off-target analysis as a prerequisite for IND filing.
**Impact:** Doench et al. (2016) showed that guide RNA efficiency varies by more than 100-fold depending on sequence context — random guide selection produces high failure rates. Hsu et al. (2013) demonstrated that off-target cleavage occurs at sequences with up to 5 mismatches, particularly in the seed region — making systematic off-target prediction essential. The first human CRISPR clinical trials (Vertex/CRISPR Therapeutics CTX001) validated that systematic design followed by rigorous confirmation produces safe editing outcomes.

## Steps

### 1. Define the editing goal precisely

Before designing any guide RNA:
- **Knockout:** disrupt protein function by frameshift — cut near the start of the coding sequence (first exon, early coding region)
- **Knockin:** introduce precise sequence change — requires HDR template design; plan donor DNA alongside the gRNA
- **Transcription regulation:** activate or repress without cutting — use dCas9-KRAB (repression) or dCas9-VPR (activation)
- **Base editing:** single base change without DSB — use CBE (C→T) or ABE (A→G) depending on target base

The goal determines which Cas variant (Cas9, Cas12a, base editors, prime editors) is appropriate.

### 2. Select target site and guide RNA

Rules for standard Cas9 (SpCas9, requires NGG PAM):
1. Identify all NGG PAMs in the target region
2. Extract the 20-nt protospacer immediately 5' of the NGG
3. Score each candidate gRNA using a prediction tool:
   - **CRISPOR** (crispor.tefor.net): on-target efficiency (Doench 2016 score) + off-target scores
   - **Benchling** or **CHOPCHOP**: integrated design and off-target analysis
4. Select gRNAs with:
   - Doench efficiency score ≥ 60%
   - Specificity score: no predicted off-targets with <3 mismatches in coding regions
   - GC content: 40-70%
   - Avoid poly-T runs (TTTT) — cause Pol III termination in U6-driven expression
5. Design 2-3 gRNAs per target — test all; select the best-performing one empirically

### 3. Assess and mitigate off-target risk

Off-target cleavage is the primary safety concern:
- **In silico screening:** run Cas-OFFinder or CRISPOR off-target prediction; flag all sites with ≤3 mismatches in coding or regulatory regions
- **Seed region priority:** mismatches in positions 1-12 (PAM-proximal) are better tolerated by Cas9; avoid guides with perfect match to off-target sites in the seed region
- **Mitigation options:** high-fidelity Cas9 variants (eSpCas9, HiFi Cas9, HEK4) for therapeutic contexts; paired Cas9 nickases for additional specificity; truncated gRNAs (17-18 nt)

### 4. Select delivery strategy

Match delivery to cell type and context:
- **Plasmid transfection:** simple; persistent expression; low cost; risk of random integration
- **Ribonucleoprotein (RNP) complex (Cas9 + gRNA):** preferred for cells with HDR requirement; transient exposure minimizes off-target; used in clinical applications
- **Lentiviral/AAV:** for difficult-to-transfect cells (neurons, HSCs); size constraints limit AAV-packaged Cas9 (use SaCas9 or split constructs)
- **Electroporation:** high efficiency for most cell types; RNP delivery is optimal

### 5. Design editing confirmation assays

Confirming successful editing is mandatory:
- **Indel detection (for knockouts):**
  - T7 endonuclease I (T7EI) assay or Surveyor assay: detect mismatch at cut site; semi-quantitative
  - TIDE (Tracking of Indels by DEcomposition): quantitative indel profiling from Sanger sequencing
  - Next-generation sequencing (amplicon-seq): most accurate; required for clinical applications
- **HDR confirmation (for knockins):**
  - PCR across the junction + Sanger sequencing
  - Allele-specific PCR for precise mutations
- **Off-target validation (for therapeutic use):**
  - GUIDE-seq, CIRCLE-seq, or DISCOVER-seq: unbiased whole-genome off-target detection

### 6. Clone or isolate edited cells

For most applications: sort or limit-dilute after transfection to obtain clonal populations; sequence both alleles to confirm bi-allelic editing.

## Common Mistakes

- **Selecting a gRNA based solely on target proximity, not efficiency score:** Guide RNA efficiency varies enormously by sequence context. Use a validated prediction tool.
- **Skipping the negative selection step after editing:** Mixed populations contain unedited cells. Clonal isolation and confirmation are required for downstream experiments.
- **No unedited control:** Always compare edited and isogenic unedited cells to attribute phenotype to the edit, not to transfection or selection stress.

## When NOT to Use

- Targeting mitochondrial DNA: Cas9 lacks efficient mitochondrial delivery; use mitochondria-targeted base editors specifically designed for mtDNA.
