import Foundation
import SwiftData

@Model
final class SessionTranscript {
    var id: UUID
    var date: Date
    var sceneName: String            // stored as String, not enum, for migration safety
    var durationTarget: TimeInterval
    var durationCompleted: TimeInterval
    @Relationship(deleteRule: .cascade) var lines: [TranscriptLine]

    init(
        id: UUID = UUID(),
        date: Date = .now,
        sceneName: String,
        durationTarget: TimeInterval,
        durationCompleted: TimeInterval,
        lines: [TranscriptLine] = []
    ) {
        self.id = id
        self.date = date
        self.sceneName = sceneName
        self.durationTarget = durationTarget
        self.durationCompleted = durationCompleted
        self.lines = lines
    }
}

@Model
final class TranscriptLine {
    var timestamp: TimeInterval
    var text: String

    init(timestamp: TimeInterval, text: String) {
        self.timestamp = timestamp
        self.text = text
    }
}
