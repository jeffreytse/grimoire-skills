---
name: apply-remote-sensing-analysis
description: Use when analyzing satellite or aerial imagery for earth science applications — including image preprocessing, spectral band selection, classification, change detection, and index calculation for land cover, vegetation, geology, or water assessment.
source: Lillesand et al. "Remote Sensing and Image Interpretation" 7th ed. (2015); Jensen "Introductory Digital Image Processing" 4th ed. (2015); ESA Sentinel-2 User Handbook; USGS Landsat Collection 2 Science Product Guide
tags: [remote-sensing, satellite-imagery, land-cover, spectral-analysis, GIS, vegetation-index, change-detection]
---

# Apply Remote Sensing Analysis

Analyze satellite or aerial imagery systematically — preprocessing to remove atmospheric and geometric artifacts, selecting bands appropriate to the application, calculating spectral indices, and validating classifications against ground truth — to extract reliable earth observation data.

## Why This Is Best Practice

**Adopted by:** NASA, ESA, USGS, FAO, and all major national mapping agencies use standardized remote sensing workflows for operational monitoring programs (Global Forest Watch, Copernicus Land Monitoring, USDA CropScape). IPCC relies on satellite-derived land use change data for national GHG inventories. The Copernicus Emergency Management Service and Global Disaster Alert and Coordination System (GDACS) use remote sensing for rapid disaster response.
**Impact:** Wulder et al. (2022, Remote Sensing of Environment) demonstrated that Landsat time series — analyzed with systematic methods — provides a 50-year global record of land change that no other data source can replicate. Inadequate preprocessing (uncorrected atmospheric haze, misregistered images) corrupts spectral indices by up to 30% and change detection results by orders of magnitude. Systematic analysis converts petabytes of raw satellite data into actionable earth observation products.

## Steps

### 1. Select the appropriate sensor and spatial/spectral resolution

Match sensor to application:
| Application | Recommended sensor | Resolution |
|-------------|-------------------|------------|
| Regional land cover mapping | Landsat 8/9 (free), Sentinel-2 (free) | 10-30m |
| Vegetation stress / agriculture | Sentinel-2 (13 bands, 10m visible/NIR) | 10-20m |
| Geological mapping (mineralogy) | ASTER (thermal + SWIR), Sentinel-2 | 15-30m |
| Urban mapping, infrastructure | WorldView-3, Pleiades, Planet | 0.3-3m |
| Vegetation height / structure | LiDAR, GEDI (space-based LiDAR) | variable |
| Sea surface temperature | MODIS, Landsat TIR band | 30-1000m |

### 2. Preprocess the imagery

Never analyze raw (Level 0/1) imagery — preprocessing is mandatory:
- **Geometric correction:** co-register image to map projection; verify using GCPs (Ground Control Points); RMSE < 0.5 pixels required for change detection
- **Atmospheric correction:** convert Top-of-Atmosphere (TOA) reflectance to Surface Reflectance (SR) using tools:
  - Landsat: use Collection 2 Level 2 products (pre-corrected) or run LaSRC
  - Sentinel-2: use Sen2Cor plugin or ESA L2A products
  - Why: haze and aerosols add 5-30% reflectance to visible bands; uncorrected imagery gives wrong spectral signatures
- **Cloud masking:** remove cloud-covered pixels using QA bands (Landsat BQA, Sentinel-2 SCL layer); cloud shadows are equally problematic
- **Radiometric normalization:** for multi-date change detection, normalize all images to a common radiometric baseline using Pseudo-Invariant Features (PIFs) or histogram matching

### 3. Calculate spectral indices for the application

**Vegetation:**
```
NDVI = (NIR − Red) / (NIR + Red)
Range: −1 to +1; healthy vegetation: 0.3-0.8; bare soil: 0.1-0.2; water: negative
```

**Water:**
```
NDWI = (Green − NIR) / (Green + NIR)  [water bodies]
MNDWI = (Green − SWIR) / (Green + SWIR)  [better in urban areas]
```

**Burned area:**
```
NBR = (NIR − SWIR2) / (NIR + SWIR2)
dNBR = pre-fire NBR − post-fire NBR  [burn severity]
```

**Geology (iron oxides):**
```
Iron Oxide Ratio = Red / Blue  (ASTER or Landsat Band 4/2)
Clay Ratio = SWIR1 / SWIR2  (ASTER Band 5/7)
```

**Built-up area:**
```
NDBI = (SWIR − NIR) / (SWIR + NIR)  [built-up vs vegetation]
```

### 4. Land cover classification

Two approaches:
- **Supervised classification:** requires training samples per class; algorithms: Random Forest (preferred), SVM, Maximum Likelihood; validate with independent test samples (separate from training)
- **Unsupervised classification (K-means, ISODATA):** for exploration without prior knowledge; requires post-classification label assignment

Accuracy assessment — mandatory before reporting:
- Create stratified random sample of validation points (minimum 50 per class, 250 total)
- Compare classified vs reference label (from high-res imagery or field data)
- Report Overall Accuracy and Cohen's Kappa; target OA ≥ 85%, Kappa ≥ 0.80

### 5. Change detection for multi-temporal analysis

For before/after comparison:
- **Image differencing:** subtract band/index values; threshold change magnitude and direction
- **Post-classification comparison:** classify each date independently; compare class maps
- **LandTrendr / CCDC:** for time series trend fitting; captures gradual change (forest degradation, drought stress) missed by two-date methods

Tools: Google Earth Engine, SNAP (ESA), QGIS Semi-Automatic Classification Plugin (free), ArcGIS Image Analyst.

## Common Mistakes

- **Skipping atmospheric correction for multi-date analysis:** TOA reflectance varies with atmospheric conditions and sun angle. Change detection on uncorrected images detects atmosphere, not surface change.
- **Using non-cloud-masked pixels:** A single cloud shadow can produce a false "vegetation loss" or "water detection" signal that propagates into the final product.
- **Reporting classification accuracy without a validation dataset independent of training data:** Using the same points for training and validation produces inflated, meaningless accuracy statistics.

## When NOT to Use

- Fine-scale feature mapping (individual trees, small structures): sub-meter commercial imagery or field survey is needed; 10-30m pixel size conflates multiple land cover types.
