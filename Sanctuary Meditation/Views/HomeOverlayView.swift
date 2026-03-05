import SwiftUI

extension Color {
    static let sanctuary      = Color(red: 0.87, green: 0.79, blue: 0.65) // pale cream
    static let sanctuaryAmber = Color(red: 0.88, green: 0.46, blue: 0.04) // rich deep amber
}

struct HomeOverlayView: View {
    @Environment(SessionStore.self) private var session
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    @State private var visible = false

    private var isLandscape: Bool { verticalSizeClass == .compact }

    var body: some View {
        ZStack {

            // MARK: Centered glass panel
            ZStack {
                // Glass background — very faint fill + bright edge, content is never under heavy tint
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(red: 0.45, green: 0.65, blue: 0.95).opacity(0.10))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .strokeBorder(
                                LinearGradient(
                                    colors: [
                                        Color.white.opacity(0.65),
                                        Color.white.opacity(0.20),
                                        Color.white.opacity(0.05),
                                        Color.white.opacity(0.30)
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 1
                            )
                    )

                // Content — explicitly on top of glass
                VStack(spacing: isLandscape ? 8 : 14) {

                    // Title
                    VStack(spacing: 4) {
                        Text("Sanctuary")
                            .font(.system(size: isLandscape ? 28 : 38, weight: .light, design: .serif))
                            .tracking(6)
                            .foregroundStyle(Color.white)
                            .shadow(color: .black.opacity(0.5), radius: 4, x: 0, y: 1)
                        Text("A Quiet Space")
                            .font(.system(size: 10, weight: .regular))
                            .tracking(5)
                            .textCase(.uppercase)
                            .foregroundStyle(Color.white.opacity(0.75))
                            .shadow(color: .black.opacity(0.4), radius: 2, x: 0, y: 1)
                    }
                    .padding(.top, 4)

                    Divider()
                        .background(Color.sanctuary.opacity(0.2))

                    // Atmosphere — 2-row grid in portrait, scrolling row in landscape
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Atmosphere")
                            .font(.system(size: 9, weight: .regular))
                            .tracking(3)
                            .textCase(.uppercase)
                            .foregroundStyle(Color.sanctuary.opacity(0.45))
                        if isLandscape {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 8) {
                                    ForEach(SceneType.allCases, id: \.self) { s in
                                        pillButton(icon: s.icon, label: s.rawValue, isSelected: session.selectedScene == s) {
                                            session.selectedScene = s
                                        }
                                    }
                                }
                            }
                        } else {
                            let cols = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
                            LazyVGrid(columns: cols, spacing: 6) {
                                ForEach(SceneType.allCases, id: \.self) { s in
                                    pillButton(icon: s.icon, label: s.rawValue, isSelected: session.selectedScene == s) {
                                        session.selectedScene = s
                                    }
                                }
                            }
                        }
                    }

                    // Sound
                    selectorRow(label: "Sound") {
                        ForEach(AmbientType.allCases, id: \.self) { a in
                            pillButton(icon: a.icon, label: a.rawValue, isSelected: session.selectedAmbient == a) {
                                session.selectedAmbient = a
                            }
                        }
                    }

                    // Duration
                    selectorRow(label: "Duration") {
                        ForEach([5, 10, 20, 30, 45], id: \.self) { min in
                            let seconds = TimeInterval(min * 60)
                            pillButton(icon: nil, label: "\(min) Min", isSelected: session.selectedDuration == seconds) {
                                session.selectedDuration = seconds
                            }
                        }
                    }

                    // BEGIN
                    Button {
                        // TODO: start session
                    } label: {
                        HStack(spacing: 14) {
                            ZStack {
                                Circle()
                                    .fill(Color.sanctuary.opacity(0.15))
                                    .frame(width: 44, height: 44)
                                Image(systemName: "play.fill")
                                    .font(.system(size: 14, weight: .regular))
                                    .foregroundStyle(Color.sanctuary.opacity(0.85))
                                    .offset(x: 2)
                            }
                            Text("Begin")
                                .font(.system(size: 14, weight: .light))
                                .tracking(6)
                                .textCase(.uppercase)
                                .foregroundStyle(Color.sanctuary.opacity(0.9))
                        }
                    }
                    .padding(.bottom, 4)
                }
                .padding(.horizontal, 14)
                .padding(.vertical, isLandscape ? 10 : 16)
                .zIndex(1)
            }
            .frame(maxWidth: isLandscape ? 360 : 380)
            .shadow(color: .black.opacity(0.38), radius: 24, x: 0, y: 10)
            .shadow(color: .black.opacity(0.18), radius: 4, x: 0, y: 2)

            // MARK: Transcript — right edge
            HStack {
                Spacer()
                Button {
                    // TODO: navigate to transcript
                } label: {
                    VStack(spacing: 6) {
                        Image(systemName: "scroll")
                            .font(.system(size: 16, weight: .light))
                        Text("Transcript")
                            .font(.system(size: 9, weight: .regular))
                            .tracking(2)
                            .textCase(.uppercase)
                    }
                    .foregroundStyle(Color.sanctuary.opacity(0.6))
                    .padding(.vertical, 14)
                    .padding(.horizontal, 10)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.white.opacity(0.1), lineWidth: 1)
                    )
                }
                .padding(.trailing, 16)
                .opacity(session.transcript.isEmpty ? 0.35 : 1.0)
            }
        }
        .opacity(visible ? 1 : 0)
        .offset(y: visible ? 25 : 45)
        .onAppear {
            withAnimation(.easeOut(duration: 1.2).delay(0.3)) {
                visible = true
            }
        }
    }

    // MARK: - Helpers

    private func selectorRow<Content: View>(label: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(label)
                .font(.system(size: 9, weight: .regular))
                .tracking(3)
                .textCase(.uppercase)
                .foregroundStyle(Color.sanctuary.opacity(0.45))
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    content()
                }
            }
        }
    }

    private func pillButton(icon: String?, label: String, isSelected: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack(spacing: 5) {
                if let icon {
                    Image(systemName: icon)
                        .font(.system(size: 11, weight: .light))
                }
                Text(label)
                    .font(.system(size: 11, weight: .regular))
                    .tracking(0.5)
            }
            .foregroundStyle(isSelected ? Color.white : Color(white: 0.1))
            .shadow(color: .black.opacity(0.4), radius: 2, x: 0, y: 1)
            .padding(.horizontal, 9)
            .padding(.vertical, 6)
            .background(
                Capsule()
                    .fill(isSelected ? Color.sanctuaryAmber.opacity(0.55) : Color.white.opacity(0.42))
            )
            .overlay(
                Capsule()
                    .stroke(isSelected ? Color.sanctuaryAmber.opacity(0.6) : Color.white.opacity(0.4), lineWidth: 1)
            )
            .shadow(color: .black.opacity(0.22), radius: 4, x: 0, y: 2)
        }
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        HomeOverlayView()
            .environment(SessionStore())
    }
}
