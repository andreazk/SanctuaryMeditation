import Foundation

// MARK: - Scene

enum SceneType: String, CaseIterable, Codable {
    case forest   = "Forest"
    case stream   = "Stream"
    case beach    = "Beach"
    case sunset   = "Sunset"
    case dawnCove = "Dawn Cove"
    case teahouse = "Tea House"

    var imageName: String {
        switch self {
        case .forest:   return "scene-forest"
        case .stream:   return "scene-stream"
        case .beach:    return "scene-beach"
        case .sunset:   return "scene-sunset"
        case .dawnCove: return "scene-cove"
        case .teahouse: return "teahouse"
        }
    }

    var icon: String {
        switch self {
        case .forest:   return "tree.fill"
        case .stream:   return "water.waves"
        case .beach:    return "sun.max.fill"
        case .sunset:   return "sunset.fill"
        case .dawnCove: return "sunrise.fill"
        case .teahouse: return "cup.and.saucer.fill"
        }
    }
}

// MARK: - Ambient Sound
// Note: singing bowl is a session punctuation sound, not an ambient track.
// It is handled separately by the audio engine.

enum AmbientType: String, CaseIterable, Codable {
    case drone = "Ethereal Drone"
    case wind  = "Forest Wind"

    var icon: String {
        switch self {
        case .drone: return "music.note"
        case .wind:  return "wind"
        }
    }
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
