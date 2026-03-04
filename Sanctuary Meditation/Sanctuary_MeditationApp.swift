//
//  Sanctuary_MeditationApp.swift
//  Sanctuary Meditation
//
//  Created by Andrea Kapitan on 3/3/26.
//

import SwiftUI
import SwiftData

@main
struct Sanctuary_MeditationApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(SessionStore())
        }
        .modelContainer(for: [SessionTranscript.self, TranscriptLine.self])
    }
}
