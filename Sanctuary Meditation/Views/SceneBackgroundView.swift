import SwiftUI

struct SceneBackgroundView: View {
    let scene: SceneType
    let isZoomedIn: Bool

    var body: some View {
        GeometryReader { geo in
            let isLandscape = geo.size.width > geo.size.height
            Image(scene.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: geo.size.width, height: geo.size.height, alignment: isLandscape ? .center : .bottom)
                .scaleEffect(isZoomedIn ? 1.1 : 1.0, anchor: .center)
                .animation(.easeInOut(duration: 8), value: isZoomedIn)
                .overlay(vignette(size: geo.size))
                .clipped()
        }
        .ignoresSafeArea()
    }

    private func vignette(size: CGSize) -> some View {
        let radius = max(size.width, size.height)
        return ZStack {
            // Radial darkening from edges inward
            RadialGradient(
                colors: [.clear, .black.opacity(0.75)],
                center: .center,
                startRadius: radius * 0.3,
                endRadius: radius * 0.85
            )
            // Extra darkening at the bottom for UI legibility
            LinearGradient(
                colors: [.clear, .black.opacity(0.6)],
                startPoint: .center,
                endPoint: .bottom
            )
        }
    }
}

#Preview {
    SceneBackgroundView(scene: .forest, isZoomedIn: false)
}
