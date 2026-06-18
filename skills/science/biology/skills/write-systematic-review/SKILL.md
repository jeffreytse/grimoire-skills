---
name: write-systematic-review
description: Use when planning or writing a systematic review of scientific literature — following PRISMA guidelines to search, screen, extract, and synthesize evidence from primary studies with transparent, reproducible methodology.
source: Page et al. (2021) "PRISMA 2020 Statement" (BMJ); Cochrane Handbook for Systematic Reviews of Interventions (Higgins et al., 2022); Moher et al. (2009) "Preferred Reporting Items for Systematic Reviews and Meta-Analyses" (PLOS Medicine)
tags: [systematic-review, PRISMA, evidence-synthesis, literature-review, meta-analysis, research-methodology]
---

# Write Systematic Review

Conduct and report a systematic review following PRISMA 2020 standards — with pre-registered protocol, comprehensive search, transparent screening, risk-of-bias assessment, and synthesis of evidence quality.

## Why This Is Best Practice

**Adopted by:** Cochrane Collaboration (the gold standard for systematic reviews), WHO, NIH systematic evidence review programs, NICE (UK clinical guidelines), FDA Evidence-Based Medicine framework, and virtually all clinical guideline bodies require systematic reviews as the primary evidence base for recommendations.
**Impact:** Ioannidis (2005) "Why Most Published Research Findings Are False" demonstrated that individual studies frequently yield false positives — systematic reviews, by pooling and assessing evidence quality, are the most reliable way to estimate true effect sizes. The PRISMA statement is endorsed by >700 journals (EQUATOR network); systematic reviews using PRISMA have significantly higher citation rates and lower retraction rates than narrative reviews.

## Steps

### 1. Register the protocol before searching

Pre-registration is mandatory for credible systematic reviews:
- Register on **PROSPERO** (www.crd.york.ac.uk/prospero) — the international register for systematic reviews
- Record: research question, PICO elements, search strategy, inclusion/exclusion criteria, outcomes, planned synthesis method
- Registration prevents selective reporting and outcome-switching — the primary bias in non-registered reviews

### 2. Formulate the research question using PICO

Structure the question:
- **P** (Population): who are the participants? What condition/context?
- **I** (Intervention/Exposure): what is being done or examined?
- **C** (Comparator): what is it compared to?
- **O** (Outcome): what outcomes matter? Primary and secondary?

Example: In adults with Type 2 diabetes (P), does GLP-1 agonist therapy (I) compared to SGLT-2 inhibitors (C) reduce cardiovascular mortality (O)?

### 3. Design the comprehensive search strategy

Search must be comprehensive and reproducible:
- **Databases:** search at minimum MEDLINE (PubMed), EMBASE, CENTRAL (Cochrane); add discipline-specific databases (PsycINFO, CINAHL, etc.)
- **Search terms:** combine MeSH terms with free-text synonyms using Boolean operators (AND, OR, NOT); work with a research librarian for complex searches
- **Time span:** search all years unless specific rationale for cutoff
- **Additional sources:** grey literature (clinical trial registries, conference abstracts, regulatory submissions); reference lists of included studies; forward citation of key papers

Document the exact search string for each database (required for PRISMA flow diagram).

### 4. Screen titles/abstracts then full texts

Two-phase screening:
1. **Title/abstract screening:** apply inclusion/exclusion criteria; two independent reviewers screen all records; resolve disagreements by discussion or third reviewer
2. **Full-text screening:** retrieve and assess all articles that passed abstract screening; document reason for exclusion

Use systematic review software (Covidence, Rayyan, DistillerSR) to manage screening and track decisions.

Calculate inter-rater reliability (Cohen's kappa ≥ 0.7 = acceptable agreement).

### 5. Extract data systematically

Create a data extraction form before extraction begins:
- Study characteristics: authors, year, country, study design, sample size, follow-up duration
- Participant characteristics: demographics, inclusion/exclusion criteria
- Intervention details: dose, duration, comparator
- Outcomes: measures, results, units, time points
- Risk of bias elements (see step 6)

Extract with two independent reviewers for key outcome data; verify against source.

### 6. Assess risk of bias

Every included study must be assessed for methodological quality:
- **RCTs:** use Cochrane Risk of Bias 2 (RoB 2) tool: randomization, allocation concealment, blinding, selective outcome reporting
- **Observational studies:** use ROBINS-I tool
- **Diagnostic accuracy:** use QUADAS-2

Summarize at the study level and domain level. High-risk-of-bias studies downgrade the certainty of evidence.

### 7. Synthesize evidence and assess certainty (GRADE)

**Narrative synthesis:** when pooling is not appropriate (heterogeneous methods/populations); describe patterns, consistencies, and gaps

**Meta-analysis:** when ≥2 studies report the same outcome with compatible methods; use random-effects model (DerSimonian-Laird) as default for clinical heterogeneity; report I² for heterogeneity assessment

**GRADE assessment:** rate evidence certainty for each outcome:
- High: consistent, direct, precise evidence from RCTs
- Moderate: one downgrade (risk of bias, inconsistency, imprecision, indirectness, publication bias)
- Low/Very low: multiple downgrades

## Common Mistakes

- **No pre-registration:** Allows post-hoc outcome selection — primary driver of systematic review bias.
- **Single-reviewer screening:** Increases miss rate for relevant studies; requires dual independent screening.
- **Narrative review disguised as systematic:** Using the word "systematic" without a registered protocol, comprehensive search, and risk-of-bias assessment is misleading — and journals increasingly desk-reject these.

## When NOT to Use

- Research question with <5 existing primary studies: scoping review or narrative review is more appropriate; meta-analysis with too few studies yields unreliable pooled estimates.
