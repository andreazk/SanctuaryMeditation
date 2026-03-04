import SwiftUI

enum DoorPhase: Int {
    case closed = 0, opening, wide, scene
}

struct DoorEntryView: View {
    let scene: SceneType
    let phase: DoorPhase

    var body: some View {
        GeometryReader { geo in
            ZStack {
                SceneBackgroundView(scene: scene, isZoomedIn: false)

                doorImage("MeditationTempleDoorsWide", geo: geo)
                    .opacity(phase == .wide ? 1.0 : 0.0)

                doorImage("MeditationTempleDoorsOpening", geo: geo)
                    .opacity(phase == .opening ? 1.0 : 0.0)

                doorImage("MeditationTempleDoors", geo: geo)
                    .opacity(phase == .closed ? 1.0 : 0.0)
            }
        }
        .ignoresSafeArea()
    }

    private func doorImage(_ name: String, geo: GeometryProxy) -> some View {
        Image(name)
            .resizable()
            .scaledToFill()
            .frame(width: geo.size.width, height: geo.size.height)
            .clipped()
    }
}

#Preview {
    DoorEntryView(scene: .forest, phase: .closed)
}
