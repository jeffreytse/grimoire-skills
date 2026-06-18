---
name: design-sound-mix-plan
description: Use when planning a film or video sound mix — designing the dialogue/music/SFX layering hierarchy, establishing level relationships between tracks, and creating a mix plan that serves the narrative's emotional arc before entering the mixing session.
source: Murch "In the Blink of an Eye" 2nd ed. (2001); LoBrutto "Sound-on-Film" (1994); Sonnenschein "Sound Design" (2001); AES Journal on Film Sound Standards
tags: [sound-design, sound-mix, film-audio, dialogue, music, SFX, post-production]
---

# Design Sound Mix Plan

Plan a film or video sound mix by establishing the dialogue/music/SFX hierarchy, designing level relationships for each scene type, and mapping the mix to the emotional arc before entering the DAW mixing session.

## Why This Is Best Practice

**Adopted by:** Professional film sound mixing (supervised by a Re-Recording Mixer) follows a hierarchical workflow: dialogue → SFX/ambience → music — always in that priority order. Dolby, DTS, and IMAX mixing standards define loudness normalization and dynamic range targets. Academy Award-winning sound teams (Christopher Boyes, Gary Rydstrom, Skip Lievsay) consistently describe pre-session mix planning as essential to efficient and artistically coherent results.
**Impact:** An unplanned sound mix produces inconsistent levels across scenes, music that fights dialogue, and ambience that fills the wrong emotional register. The three-element hierarchy (dialogue > SFX > music) reflects how audiences process narrative: intelligibility of dialogue is always primary; sound effects establish reality; music governs emotion. Violating this hierarchy — music drowning dialogue, SFX masking critical story information — breaks the story's communication and is the most common amateur mixing error.

## Steps

### 1. Define the mix hierarchy for the project

The fundamental rule of narrative film sound:

**Priority order:**
1. **Dialogue (always first):** every word must be intelligible; dialogue carries story information; nothing masks it
2. **Sound effects (SFX):** establish physical reality (environment, objects, physical events); level set below clear dialogue but present
3. **Ambience/room tone:** the background acoustic environment; continuous low-level sound that makes the world feel real
4. **Music:** emotional underscore; supports but does not override narrative clarity

**Exception:** action sequences where dialogue is absent — SFX and music may be prioritized; still serve the story.

### 2. Establish loudness targets before mixing

Set technical targets before creative mixing begins:
- **Loudness standard:**
  - Theatrical: Leq(m) -85 dBSPL average; dynamic range unrestricted
  - Broadcast/streaming (Netflix, Amazon): LUFS -24 integrated (Netflix standard); peaks at -2 dBFS true peak
  - YouTube/web: LUFS -14 integrated; peaks at -1 dBFS
  - Podcast: -16 to -19 LUFS integrated
- **Dialogue reference level:** place properly recorded dialogue at -18 to -24 LUFS; this leaves headroom for SFX and music impacts

Use a loudness meter (iZotope RX, Nugen Loudness Toolkit, or DAW built-in meter) to measure and target these values.

### 3. Map scene types to mix treatment

Categorize each scene and define the mix treatment:

| Scene type | Dialogue level | SFX level | Music treatment |
|---|---|---|---|
| Quiet dialogue | Full; very present | Low or absent | Absent or barely present |
| Dramatic confrontation | Full; elevated pressure | Minimal ambience | Subtle underscore; don't compete |
| Action sequence | Below ambience | Primary; full dynamic range | Score drives energy |
| Exterior/nature | Clear but with space | Ambience prominent | Minimal or absent |
| Emotional beat (no dialogue) | N/A | Gentle; supportive | Music primary |
| Crowd/public setting | Clearly audible above crowd | Crowd provides ambience | Optional |

Pre-map each scene to one of these categories — it becomes the mixing brief for each scene.

### 4. Design the ambience and SFX layer

Ambience (room tone, exterior environment) creates the acoustic world:
- **Every scene needs ambience:** a room without ambience sounds like a dead studio; audience senses the unreality
- **Match ambience to the visual world:** exteriors have wind, birds, traffic (as appropriate); interiors have HVAC hum, room character
- **Continuity:** ambience must be consistent within a scene even when dialogue cuts; record wild room tone on set for at least 60 seconds

SFX (specific sounds): foley (performed sync sounds for physical actions), hard SFX (explosions, impacts, specific events), background SFX (distant city, rain on window):
- Place SFX in the stereo/surround field to match the visual position of the source
- Foley level: 3–6 dB below dialogue for interior scenes; may rise in action

### 5. Address music's role in the emotional arc

Plan where music enters and exits across the whole project:
- Map all music cues on a scene-by-scene timeline: where does music begin? When does it end or fade?
- **Less music is often more:** continuous underscore desensitizes the audience; music reserved for key moments is more powerful
- **Music must breathe with dialogue:** when dialogue is present, music generally ducks under it (sidechained or manual automation)
- **Temp tracks:** if cutting to a temp track, be aware of "temp love" — the final score may not match the temp's energy; plan for adjustment

**Musical transitions:** ensure music doesn't abruptly enter or exit; plan for 2–5 second fade-in/out at cue edges; musical transitions between scenes may be placed before or after the picture cut for deliberate effect.

### 6. Mix in context — playback at reference level

Critical mixing decisions must be made at reference monitoring level:
- For theatrical: 85 dBSPL reference in the room; check total mix
- For home/streaming: mix at comfortable listening level; check intelligibility at lower volumes
- **Check dialogue clarity on cheap speakers:** most audiences hear on laptops, phones, and small TVs; dialogue that sounds intelligible on studio monitors may be masked in real listening conditions

**Final mix QC checklist:**
- All dialogue clearly intelligible throughout?
- No music drowning dialogue in plot-critical moments?
- Ambience consistent within scenes?
- Loudness target met (measure with loudness meter)?
- Stereo/surround field balanced?

## Common Mistakes

- **Mixing music too loud over dialogue:** the most pervasive amateur error. Music always yields to dialogue in narrative film.
- **No ambience track:** scenes with clean dialogue but no ambience sound artificial. Even a subtle room tone transforms the acoustic reality.
- **Setting levels by eye (looking at waveforms only):** waveform height is not loudness. Use a calibrated loudness meter; listen at reference level; trust your ears.

## When NOT to Use

- Music video sound mixing: music videos invert the hierarchy — the music is primary; dialogue (if any) is secondary; the mix serves the music, not the story.
