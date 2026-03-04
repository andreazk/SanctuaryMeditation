import Foundation

// MARK: - Scene

enum SceneType: String, CaseIterable, Codable {
    case forest   = "Forest"
    case stream   = "Stream"
    case beach    = "Beach"
    case sunset   = "Sunset"
    case dawnCove = "Dawn Cove"
}

// MARK: - Ambient Sound
// Note: singing bowl is a session punctuation sound, not an ambient track.
// It is handled separately by the audio engine.

enum AmbientType: String, CaseIterable, Codable {
    case drone = "Ethereal Drone"
    case wind  = "Forest Wind"
}

// MARK: - App Phase

enum AppPhase {
    case home     // pre-session, controls visible
    case intro    // slow Ken Burns zoom begins
    case playing  // session running, timer counting
    case ending   // bowl rings, fade out
    case ended    // transcript available, return to home
}

// MARK: - Meditation

struct Meditation: Identifiable, Codable {
    let id: UUID
    var title: String
    var description: String
    var scene: SceneType
    var ambient: AmbientType
    var duration: TimeInterval       // seconds
    var audioFileName: String?       // nil = use AVSpeechSynthesizer narrator
}
