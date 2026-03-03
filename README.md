# Sanctuary Meditation

A quiet space. An immersive iOS meditation app built with SwiftUI.

Inspired by a web prototype, Sanctuary brings guided meditation to iPhone and iPad with beautiful photographic scenes, synthesized ambient audio, and a curated library of recorded and AI-generated guided sessions.

---

## Build Plan

### Step 1 — Xcode project setup ✅
New SwiftUI app, iOS 17 minimum target. Background audio capability. Git initialized.

### Step 2 — Data model
`Meditation` struct, enums for `SceneType` / `AmbientType` / `AppPhase`, `@Observable` session store, SwiftData schema for transcripts and session history.

### Step 3 — Asset pipeline
Port the 5 scene images (Forest, Stream, Beach, Sunset, Dawn Cove) into the asset catalog. Organize audio asset folders. Seed a basic meditation library.

### Step 4 — Scene background + animation
Full-screen image view with Ken Burns slow zoom (8-second ease). Vignette overlay. Scene switching transition.

### Step 5 — Metal shaders
Atmospheric grain/film texture overlay. Soft animated vignette. Per-scene color grading (warmer for sunset, cooler for stream).

### Step 6 — Home screen UI
"Sanctuary / A quiet space" header. Scene selector, duration picker, ambient sound picker, voice/guide selector. BEGIN button with glow treatment.

### Step 7 — Audio engine
`AVAudioEngine` with mixer. Synthesized singing bowl, ethereal drone, and wind noise. Fade in/out behavior.

### Step 8 — Session player
Phase state machine: `intro → ready → playing → ending → ended`. Timer countdown, stop button, fade controls tied to phase transitions.

### Step 9 — Narration
`AVSpeechSynthesizer` with enhanced neural voice as placeholder. Script scheduling across session duration. Transcript accumulation. Later replaced/supplemented with recorded and AI-generated audio files.

### Step 10 — Transcript screen
Post-session transcript display. Persisted via SwiftData. Navigation back to home.

### Step 11 — Background audio + system integration
`AVAudioSession` background mode. Now Playing info on lock screen. Haptic feedback on session start and end bowl strike.

### Step 12 — Polish + device testing
iPhone and iPad layout. Dynamic Type, accessibility. Dark mode only. Performance on older devices.

---

## Tech Stack

| Layer | Technology |
|---|---|
| UI | SwiftUI |
| Scene backgrounds | Image assets with Ken Burns animation |
| Atmospheric effects | Metal shaders (colorEffect, distortionEffect) |
| Ambient audio | AVAudioEngine (synthesized) |
| Narration | AVSpeechSynthesizer / recorded .m4a / ElevenLabs API |
| State | @Observable |
| Persistence | SwiftData |
| Health | HealthKit (mindfulness minutes) |
| Future | visionOS Immersive Space via RealityKit |

---

## Scenes

Forest · Stream · Beach · Sunset · Dawn Cove
