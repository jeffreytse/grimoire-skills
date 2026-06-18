---
name: apply-raw-processing-workflow
description: Use when processing RAW image files — applying a systematic RAW processing workflow (exposure, white balance, tone, detail, color) to maximize image quality and establish a consistent editing foundation before any creative adjustments.
source: Schewe "The Digital Negative" 3rd ed. (2018); Evening "Adobe Photoshop Lightroom Classic" (2019); McNally "The Moment It Clicks" (2008); Adobe Lightroom Develop Module documentation; Phase One Capture One workflow guides
tags: [photography, RAW-processing, Lightroom, Capture-One, editing, post-processing, exposure]
---

# Apply RAW Processing Workflow

Apply a systematic RAW file processing workflow — correcting exposure, white balance, tone, noise, and detail in a consistent sequence — to maximize image quality from the RAW file before creative adjustments.

## Why This Is Best Practice

**Adopted by:** Jeff Schewe's "The Digital Negative" is the definitive technical reference for RAW processing, used by professional retouchers, photographers, and digital imaging technicians globally. Adobe Lightroom's Develop module and Phase One's Capture One are the two dominant professional RAW processing applications; both organizations publish workflow documentation consistent with the sequence described here.
**Impact:** RAW files contain significantly more tonal information than JPEG exports — typically 12–14 bits of per-channel information vs. 8 bits in JPEG. Processing RAW correctly recovers highlight and shadow detail that is irreversibly lost in JPEG. A photographer who captures RAW but processes it incorrectly (random edits, wrong sequence) discards much of the quality advantage of shooting RAW. The systematic workflow described here preserves and maximizes the RAW file's full tonal range.

## Steps

### 1. Set the foundation: calibration and lens corrections

Before any tonal or color adjustments, apply objective corrections:
- **Camera calibration profile:** choose the correct camera profile (Adobe Standard or the manufacturer's profile calibrated to your camera model); this is the color foundation — all subsequent corrections build on it
- **Lens profile corrections:** enable automatic lens distortion and vignette correction (Lightroom and Capture One have profiles for most lens/camera combinations); corrects barrel/pincushion distortion and lens vignetting automatically
- **Remove chromatic aberration:** enables correction of color fringing at high-contrast edges; apply globally in RAW processing

### 2. Set white balance for accurate or intended color

White balance correction comes early because all subsequent color adjustments depend on it:
- **As-shot:** the white balance the camera recorded; correct for most cameras with accurate AWB in consistent lighting
- **Custom setting:** set the Kelvin temperature or use the eyedropper tool on a neutral gray or white surface in the frame
- **Creative intent:** white balance can be used creatively — slightly warmer WB produces golden-hour feel; slightly cooler produces clean, modern feel

**Sequence importance:** white balance affects the mathematical underlying color data; adjusting white balance after color grading requires re-doing all color work. Set white balance first.

### 3. Adjust exposure and contrast

**Exposure slider:** global brightness adjustment; think of it as your primary exposure correction
- Move the Exposure slider until the histogram peaks sit within the tonal range without clipping

**Highlights and Shadows sliders (recovery):**
- Highlights: reduce to recover blown-out highlight detail (sky, specular reflections); recover up to 3–4 stops of overexposure in RAW vs. JPEG's ~1 stop
- Shadows: increase to open up blocked shadows; recovery capacity varies by camera sensor dynamic range

**Whites and Blacks sliders (clipping control):**
- Whites: hold Option/Alt while adjusting to see clipping overlay; set Whites to just below clipping (some white point definition is normal and desirable)
- Blacks: hold Option/Alt; set Blacks to begin clipping just slightly (a small amount of deep black anchors the tonal range)

**Histogram reading:** after Step 3, the histogram should show a full tonal range from near-black to near-white without significant clipping (unless the creative intent requires it).

### 4. Adjust tone curve for contrast and midtone control

After setting the overall exposure and clipping points, the tone curve refines contrast in the midtones:
- **S-curve:** slight S-shape (slight bump in the upper-midtones; slight dip in the lower-midtones) adds punch and contrast; the standard starting point for most images
- **Linear:** leave the tone curve linear and control contrast with the Contrast slider if the image is already well-exposed with good contrast
- **Per-channel curves:** adjust the Red, Green, and Blue curves individually for color grading effects (lower the blue channel in the shadows = warm shadow toning)

### 5. Adjust color saturation, vibrance, and hue

**Vibrance:** selectively increases saturation of less-saturated colors while protecting skin tones; preferred for portraits
**Saturation:** global saturation increase; can push skin tones toward oversaturation; use carefully
**HSL/Color panel:** adjust Hue, Saturation, and Luminance of individual color ranges (reds, oranges, yellows, greens, aquas, blues, purples, magentas):
- Reduce orange saturation slightly to reduce skin redness
- Reduce blue luminance to make sky darker and more dramatic
- Adjust green hue to shift grass toward yellow-green or blue-green depending on palette

### 6. Apply noise reduction and sharpening

**Noise reduction (Lightroom Detail panel / Capture One Noise Reduction):**
- **Luminance noise reduction:** smooth grainy texture in flat areas (sky, skin); set between 20–50 for ISO 3200–6400; higher ISO requires more NR
- **Color noise reduction:** default 25 in Lightroom handles most color noise; reduce if color detail is being lost
- **Balance:** noise reduction softens fine detail; use the minimum necessary to produce an acceptable result

**Output sharpening:**
- RAW files require sharpening (they are intentionally unsharpened to allow user control)
- **Amount:** 50–75 typical starting point; **Radius:** 0.8–1.0 (smaller = finer detail); **Detail:** 25–50; **Masking:** hold Option/Alt to see the masking overlay — increase masking to restrict sharpening to edges only (prevents amplifying noise in flat areas)

### 7. Export at the correct format and quality settings

RAW processing must be exported for sharing or printing:
- **For print or archive:** TIFF or PSD at 16-bit; full resolution; AdobeRGB color space for professional printing
- **For web/screen:** JPEG; sRGB color space (standard for screen); quality 85–95; resize to intended display size
- **For retouching in Photoshop:** TIFF 16-bit; use Lightroom's "Edit in Photoshop" workflow, not a separate export — maintains the Lightroom adjustment layer relationship

## Common Mistakes

- **Processing in wrong order:** adjusting saturation before white balance, or sharpening before noise reduction — operations applied in the wrong order produce suboptimal results. Follow the sequence: calibration → white balance → exposure/tone → color → detail.
- **Relying on JPEG-output NR:** in-camera JPEG noise reduction is applied before RAW, permanently; RAW files retain full noise and can be processed more carefully with full control over the NR/detail trade-off.
- **Over-processing:** excessive clarity, heavy-handed tone mapping, over-saturated colors — the goal of RAW processing is to maximize the captured information, not to create visually extreme images.

## When NOT to Use

- JPEG-only cameras or smartphone RAW: processed JPEGs have already had all the RAW data discarded by the camera; JPEG processing in Lightroom has far less recovery range and produces different quality ceiling; the full RAW processing workflow with highlight/shadow recovery applies only to unprocessed RAW files.
