import SwiftUI

struct NavigationHeader: View {
    let title: String
    let canGoBack: Bool
    let onBack: () -> Void

    private let buttonShape = RoundedRectangle(cornerRadius: 16, style: .continuous)

    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 12) {
                if canGoBack {
                    Button(action: onBack) {
                        Image(systemName: "chevron.backward")
                            .font(.system(size: 18, weight: .semibold))
                            .frame(width: 44, height: 44)
                            .foregroundStyle(.white)
                            .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                    .background {
                        Rectangle()
                            .fill(Color.clear)
                            .glassEffect(.clear)
                            .compositingGroup()
                            .mask(buttonShape)
                    }
                    .overlay {
                        buttonShape.strokeBorder(.white.opacity(0.20), lineWidth: 1)
                    }
                } else {
                    Color.clear.frame(width: 44, height: 44)
                }

                Text(title)
                    .font(.system(size: 22, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
                    .padding(.horizontal,60)

                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.top, 10)

            Divider()
                .opacity(0.35)
        }
    }
}


