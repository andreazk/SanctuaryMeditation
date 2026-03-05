import SwiftUI

struct HomeOverlayView: View {
    @Environment(SessionStore.self) private var session
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    @State private var visible = false

    private var isLandscape: Bool { verticalSizeClass == .compact }

    var body: some View {
        ZStack {

            // MARK: Title — floats above the glass panel
            VStack(spacing: isLandscape ? 8 : 16) {

                VStack(spacing: 4) {
                    Text("Sanctuary")
                        .font(.system(size: 38, weight: .light, design: .serif))
                        .tracking(6)
                        .foregroundStyle(Color.sanctuaryGold)
                        .shadow(color: .white.opacity(0.6), radius: 8, x: 0, y: 0)
                    Text("A Quiet Space")
                        .font(.system(size: 10, weight: .regular))
                        .tracking(5)
                        .textCase(.uppercase)
                        .foregroundStyle(Color.white.opacity(0.75))
                        .shadow(color: .white.opacity(0.5), radius: 6, x: 0, y: 0)
                }

                // MARK: Glass panel — selectors + BEGIN
                VStack(spacing: isLandscape ? 6 : 14) {

                // Atmosphere — 3-column grid in both orientations
                VStack(alignment: .leading, spacing: 6) {
                    Text("Atmosphere")
                        .font(.system(size: 9, weight: .regular))
                        .tracking(3)
                        .textCase(.uppercase)
                        .foregroundStyle(Color.sanctuary.opacity(0.45))
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: isLandscape ? 4 : 6) {
                        ForEach(SceneType.allCases, id: \.self) { s in
                            pillButton(icon: s.icon, label: s.rawValue, isSelected: session.selectedScene == s) {
                                session.selectedScene = s
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
                    HStack(spacing: 8) {
                        Image(systemName: "play.fill")
                            .font(.system(size: 12, weight: .light))
                        Text("Begin")
                            .font(.system(size: 13, weight: .semibold))
                            .tracking(4)
                            .textCase(.uppercase)
                    }
                    .foregroundStyle(Color.sanctuaryGold)
                    .padding(.horizontal, 28)
                    .padding(.vertical, 8)
                    .background(Capsule().fill(Color.white.opacity(0.15)))
                    .overlay(Capsule().stroke(Color.white.opacity(0.6), lineWidth: 1))
                    .shadow(color: Color.sanctuaryAmber.opacity(0.45), radius: 14, x: 0, y: 0)
                    .padding(.top, isLandscape ? 6 : 0)
                }
                } // end glass panel VStack
                .padding(.horizontal, 16)
                .padding(.vertical, isLandscape ? 10 : 20)
                .frame(maxWidth: isLandscape ? 560 : 360)
                .background {
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
            }
                .shadow(color: .black.opacity(0.38), radius: 24, x: 0, y: 10)
                .shadow(color: .black.opacity(0.18), radius: 4, x: 0, y: 2)

            } // end outer VStack
            .frame(maxWidth: isLandscape ? 560 : 360)

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
