import SwiftUI
import Combine

// MARK: - AppSettings

final class AppSettings: ObservableObject {

    enum AppearanceMode: Equatable {
        case dark
        case light
    }

    @Published var appearance: AppearanceMode = .dark

    // Range: -3 ... +3
    @Published var textLevel: Int = 0

    /// Each level changes text by +4pt
    var textOffset: CGFloat {
        CGFloat(textLevel * 4)
    }

    func increaseTextLevel() {
        if textLevel < 3 { textLevel += 1 }
    }

    func decreaseTextLevel() {
        if textLevel > -3 { textLevel -= 1 }
    }

    var primaryTextColor: Color {
        appearance == .dark ? .white : Color.black.opacity(0.85)
    }

    func iconColor(isSelected: Bool) -> Color {
        if isSelected {
            return primaryTextColor
        } else {
            return appearance == .dark
            ? Color.white.opacity(0.35)
            : Color.black.opacity(0.35)
        }
    }
}

// MARK: - Dynamic Font (resizes using settings.textOffset)

struct DynamicFont: ViewModifier {

    @EnvironmentObject var settings: AppSettings
    var baseSize: CGFloat
    var weight: Font.Weight = .regular

    func body(content: Content) -> some View {
        content.font(
            .system(
                size: baseSize + settings.textOffset,
                weight: weight
            )
        )
    }
}

extension View {
    func dynamicFont(_ size: CGFloat,
                     weight: Font.Weight = .regular) -> some View {
        modifier(DynamicFont(baseSize: size, weight: weight))
    }
}

// MARK: - Glass Effects

// Outer capsule for groups (Mode/Dynamic Text)
struct GlassView: ViewModifier {

    @EnvironmentObject var settings: AppSettings

    func body(content: Content) -> some View {
        content
            .padding(.horizontal, 18)
            .padding(.vertical, 10)
            .background(
                ZStack {

                    RoundedRectangle(cornerRadius: 30)
                        .fill(.ultraThinMaterial)

                    RoundedRectangle(cornerRadius: 30)
                        .fill(
                            LinearGradient(
                                colors: [
                                   Color.white.opacity(settings.appearance == .dark ? 0.18 : 0.35),
                                    Color.clear
                                ],
                                startPoint: .top,
                                endPoint: .center
                            )
                        )
                        .blendMode(.overlay)

                    RoundedRectangle(cornerRadius: 30)
                        .stroke(
                           Color.white.opacity(settings.appearance == .dark ? 0.25 : 0.4),
                            lineWidth: 1
                        )
                }
            )
            .shadow(
                color: Color.black.opacity(settings.appearance == .dark ? 0.35 : 0.15),
                radius: 10,
                y: 6
            )
    }
}

extension View {
    func glassEffect() -> some View {
        modifier(GlassView())
    }
}

// Inner circle buttons
struct GlassCircle: ViewModifier {

    var isSelected: Bool

    func body(content: Content) -> some View {
        content
            .frame(width: 44, height: 44)
            .background(
                ZStack {
                    Circle().fill(.ultraThinMaterial)

                    if isSelected {
                        Circle()
                            .fill(Color.white.opacity(0.25))
                            .blur(radius: 4)
                    }

                    Circle()
                        .stroke(
                            Color.white.opacity(isSelected ? 0.5 : 0.2),
                            lineWidth: 1
                        )
                }
            )
    }
}

extension View {
    func glassCircle(selected: Bool) -> some View {
        modifier(GlassCircle(isSelected: selected))
    }
}

// Glass button for navigation/back
struct GlassButton: ViewModifier {

    @State private var isPressed = false

    func body(content: Content) -> some View {
        content
            .padding(.horizontal, 14)
            .padding(.vertical, 10)
            .background(
                ZStack {

                    RoundedRectangle(cornerRadius: 18)
                        .fill(.ultraThinMaterial)

                    RoundedRectangle(cornerRadius: 18)
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color.white.opacity(0.35),
                                    Color.white.opacity(0.05)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .blendMode(.overlay)

                    RoundedRectangle(cornerRadius: 18)
                        .stroke(Color.white.opacity(0.35), lineWidth: 1)
                }
            )
            .scaleEffect(isPressed ? 0.96 : 1.0)
            .animation(.easeOut(duration: 0.15), value: isPressed)
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in isPressed = true }
                    .onEnded { _ in isPressed = false }
            )
            .shadow(color: Color.black.opacity(0.25), radius: 10, y: 6)
    }
}

extension View {
    func glassButton() -> some View {
        modifier(GlassButton())
    }
}

// Optional: if you still want this ButtonStyle available
struct GlassButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.96 : 1.0)
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .fill(.ultraThinMaterial)
                    .blur(radius: configuration.isPressed ? 2 : 0)
            )
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
    }
}

// MARK: - SettingsView

struct SettingsView: View {

    @EnvironmentObject var settings: AppSettings
    @Environment(\.dismiss) private var dismiss

    var body: some View {

        ZStack {

            backgroundView
                .ignoresSafeArea()

            VStack(spacing: 30) {

                header

                // MARK: Mode Row
                settingRow(
                    title: "Mode",
                    content: {
                        HStack(spacing: 12) {

                            Button {
                                settings.appearance = .dark
                            } label: {
                                Image(systemName: "moon.fill")
                                    .foregroundColor(
                                        settings.iconColor(isSelected: settings.appearance == .dark)
                                    )
                            }
                            .glassCircle(selected: settings.appearance == .dark)

                            Button {
                                settings.appearance = .light
                            } label: {
                                Image(systemName: "sun.max.fill")
                                    .foregroundColor(
                                        settings.iconColor(isSelected: settings.appearance == .light)
                                    )
                            }
                            .glassCircle(selected: settings.appearance == .light)
                        }
                        .glassEffect()
                    }
                )

                // MARK: Dynamic Text Row
                settingRow(
                    title: "Dynamic Text",
                    content: {
                        HStack(spacing: 12) {

                            Button {
                                settings.decreaseTextLevel()
                            } label: {
                                Text("-A")
                                    .font(.system(size: 18, weight: .semibold)) // ✅ STATIC
                                    .foregroundColor(settings.primaryTextColor)
                            }
                            .glassCircle(selected: settings.textLevel == -3)

                            Button {
                                settings.increaseTextLevel()
                            } label: {
                                Text("+A")
                                    .font(.system(size: 18, weight: .semibold)) // ✅ STATIC
                                    .foregroundColor(settings.primaryTextColor)
                            }
                            .glassCircle(selected: settings.textLevel == 3)
                        }
                        .glassEffect()
                    }
                )

                Spacer()
            }
            .padding()
        }
    }
}

private extension SettingsView {

    var header: some View {
        HStack(spacing: 12) {

            Button {
                dismiss()   // ✅ real back
            } label: {
                Image(systemName: "chevron.left")
                    .foregroundColor(settings.primaryTextColor)
                    .padding(.horizontal, 6)
            }
            .glassButton()

            Text("Setting")
                .dynamicFont(34, weight: .bold)

            Spacer()
        }
        .foregroundColor(settings.primaryTextColor)
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    func settingRow<Content: View>(
        title: String,
        @ViewBuilder content: () -> Content
    ) -> some View {

        HStack {
            Text(title)
                .dynamicFont(20, weight: .medium)
                .foregroundColor(settings.primaryTextColor)

            Spacer()
            content()
        }
        .padding()
        .background(Color.white.opacity(0.05))
        .cornerRadius(16)
    }

    @ViewBuilder
    var backgroundView: some View {
        GeometryReader { geo in
            Image(settings.appearance == .dark ? "darkBackground" : "lightBackground")
                .resizable()
                .scaledToFill()
                .frame(width: geo.size.width, height: geo.size.height)
                .clipped()
                .ignoresSafeArea()
                .animation(.easeInOut(duration: 0.5), value: settings.appearance)
        }
    }
}
#Preview {
    SettingsView()
        .environmentObject(AppSettings())
        .background(.black)
}
