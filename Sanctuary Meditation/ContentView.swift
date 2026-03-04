import SwiftUI

struct ContentView: View {
    @Environment(SessionStore.self) private var session
    @State private var doorPhase: DoorPhase = .closed
    @State private var entryComplete = false

    var body: some View {
        ZStack {
            if entryComplete {
                SceneBackgroundView(
                    scene: session.selectedScene,
                    isZoomedIn: session.phase != .home
                )
                HomeOverlayView()
            } else {
                DoorEntryView(scene: session.selectedScene, phase: doorPhase)
            }
        }
        .task { await runDoorSequence() }
    }

    private func runDoorSequence() async {
        try? await Task.sleep(for: .seconds(1.5))

        withAnimation(.easeInOut(duration: 1.5)) { doorPhase = .opening }
        try? await Task.sleep(for: .seconds(2.5))

        withAnimation(.easeInOut(duration: 1.2)) { doorPhase = .wide }
        try? await Task.sleep(for: .seconds(2.0))

        withAnimation(.easeInOut(duration: 2.0)) { doorPhase = .scene }
        try? await Task.sleep(for: .seconds(2.5))

        withAnimation(.easeInOut(duration: 1.0)) { entryComplete = true }
    }
}

#Preview {
    ContentView()
        .environment(SessionStore())
}
