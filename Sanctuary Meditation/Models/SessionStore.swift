import Foundation
import Observation

@Observable
final class SessionStore {
    var phase: AppPhase = .home

    // User selections
    var selectedScene: SceneType    = .forest
    var selectedAmbient: AmbientType = .drone
    var selectedDuration: TimeInterval = 600  // 10 min default

    // Active session
    var elapsedTime: TimeInterval = 0
    var transcript: [String] = []
    var currentMeditation: Meditation? = nil

    // Derived
    var timeRemaining: TimeInterval {
        max(selectedDuration - elapsedTime, 0)
    }

    var progress: Double {
        guard selectedDuration > 0 else { return 0 }
        return min(elapsedTime / selectedDuration, 1.0)
    }

    func resetSession() {
        elapsedTime = 0
        transcript = []
        currentMeditation = nil
        phase = .home
    }
}
