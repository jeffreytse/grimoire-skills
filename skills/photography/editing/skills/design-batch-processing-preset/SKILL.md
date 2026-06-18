---
name: design-batch-processing-preset
description: Use when processing large volumes of similar photos — designing Lightroom or Capture One develop presets that apply consistent tonal, color, and detail corrections across a batch, reducing per-image processing time while maintaining image-to-image consistency.
source: Schewe "The Digital Negative" 3rd ed. (2018); Evening "Adobe Photoshop Lightroom Classic" (2019); Capture One Pro Workflow Guide (Phase One, 2023); McNally "Hot Shoe Diaries" (2009); Professional Photographers of America (PPA) workflow documentation
tags: [photography, batch-processing, Lightroom, Capture-One, editing-workflow, preset, post-production]
---

# Design Batch Processing Preset

Design Lightroom or Capture One develop presets for batch processing — creating consistent starting-point corrections that apply to all images from a shoot, then fine-tuning per-image to reduce total processing time while maintaining tonal and color consistency across a gallery.

## Why This Is Best Practice

**Adopted by:** Professional event, wedding, and commercial photographers process hundreds to thousands of images per assignment; manual per-image processing is not commercially viable. All professional workflow software (Lightroom, Capture One, Photo Mechanic+) includes batch processing and preset systems. Phase One's professional workflow documentation and the Professional Photographers of America (PPA) business resources both document preset-based batch workflows as the industry standard.
**Impact:** A wedding photographer who processes 800 images manually at 3 minutes per image spends 40 hours on post-production. A photographer using a developed preset workflow processes the same 800 images in 8–10 hours: 2 hours building and applying the base preset, then 1 minute per image for individual fine-tuning. The preset approach maintains consistency that manual processing cannot achieve — every image has the same tonal foundation, same color grade, same noise reduction starting point.

## Steps

### 1. Design the base exposure preset for the shoot conditions

A good base preset captures the common characteristics of the entire shoot:
- **Shoot-specific WB:** weddings shot indoors under mixed tungsten/LED lighting have a consistent white balance problem; the preset can set a fixed WB correction that corrects for the dominant light source
- **Exposure bias:** if the shoot was consistently underexposed by 1/3 stop (dark venue), the preset applies +0.3 EV correction globally
- **Lens profile corrections:** always include the correct lens profile for the lens used; apply chromatic aberration removal

**What NOT to include in the base preset:**
- Corrections specific to one image (exposure corrections for a specific dark scene)
- White balance corrections that vary significantly by scene type
- Spot removal or local adjustments (these cannot be batched)

### 2. Build the color grade into the preset

Consistent color grading is the primary value of a preset-based workflow:
- **The "look":** the photographer's stylistic color treatment — film-inspired fading, warm tones, cool tones, high contrast, low contrast — should be coded into the preset so every image starts with the same color treatment
- **HSL adjustments:** selective adjustments to skin tone colors (reduce orange saturation slightly to normalize skin; adjust green luminance for outdoor images) should be in the base preset
- **Tone curve:** the contrast curve defining the overall aesthetic (S-curve for punchy; gentle curve for soft/airy) is the most distinctive stylistic element

**Pre-built vs. custom presets:** third-party preset packs (VSCO, Mastin Labs film simulation, RNI) offer high-quality starting points; customize them for your camera model and shooting conditions before batch applying.

### 3. Apply the preset to the batch efficiently

**Lightroom workflow:**
1. Import all images from the shoot
2. In the Library module, select all images from the same shooting conditions (indoor reception, outdoor ceremony, etc.)
3. Apply the base preset to the selection
4. Use Lightroom's "Sync Settings" to apply one image's corrections to the full selection after manual adjustment of one representative image

**Capture One workflow:**
- Create a Style (Capture One's equivalent of a Lightroom preset)
- Apply via right-click → Apply Style → to selection
- Auto Adjustments (Capture One's auto-correct feature) can be applied before the Style for automatic exposure normalization

**Photo Mechanic + integration:** for very high-volume workflows, Photo Mechanic handles the culling and rating step before passing selects to Lightroom or Capture One for preset application; reduces the number of images needing even the preset-application step.

### 4. Cull, then fine-tune per image

**Culling before post-processing:**
- Rate or pick images before processing; don't process rejects
- Typical professional culling ratio: keep 25–50% of captured images for delivery; wedding: 10–15% of total captures

**Per-image fine-tuning sequence (30–90 seconds per image for experienced photographers):**
1. Exposure: does this image need more or less than the preset applied?
2. White balance: is the color cast correct for this specific image?
3. Highlights/Shadows: recover blown highlights or open shadows specific to this image
4. Nothing else unless the image has a specific issue (uneven horizon, color cast from adjacent colored surface)

**Use Previous Image Sync sparingly:** "Previous" in Lightroom applies all settings from the last image to the current; useful for sequential images from the same scene; dangerous when the camera moved from a bright outdoor scene to a dark indoor scene — the next image gets the wrong preset applied.

### 5. Export and name the preset intelligently

**Preset naming convention:**
```
[Photographer/Studio]_[Genre]_[Look]_[WB]_[Date]
Example: JTPhoto_Wedding_Warm-Airy_Tungsten_2025
```

Naming presets with the genre, look, and conditions allows fast selection when re-entering a similar shoot.

**Preset organization (Lightroom):**
- Group presets in named folders by genre (Weddings, Portraits, Events, Product)
- Archive presets annually; update for new camera models (calibration profiles change between camera generations)

## Common Mistakes

- **Applying the same preset to different lighting conditions without sub-presets:** a preset designed for tungsten reception lighting applied to outdoor portraits will look orange and incorrect. Create sub-presets for each distinct lighting condition within a shoot.
- **Building color-dependent presets from one camera to use on a different camera model:** color calibration profiles differ between camera models; a preset built on the Sony A7IV applied to images from a Nikon Z6 will have different color rendering. Build presets on the specific camera model they'll be applied to.
- **Processing without culling first:** processing all images including rejects wastes time on images that will not be delivered; cull first, then process selects.

## When NOT to Use

- Fine art photography with high per-image customization: photographers who treat every image as a unique art print with individual creative decisions are better served by building a personal workflow checklist than a batch preset; the preset approach optimizes for consistency and efficiency, not maximum per-image customization.
