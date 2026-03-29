import SwiftUI

enum BubbleArrowEdge {
    case top
    case bottom
}

struct TranslationBubbleView: View {
    let english: String
    let arabic: String?
    let isLoading: Bool
    let isSaved: Bool
    let onSave: () -> Void

    var arrowEdge: BubbleArrowEdge = .bottom
    var arrowX: CGFloat = 28

    var body: some View {
        VStack(spacing: 0) {
            if arrowEdge == .top {
                tailRow(isTop: true)
            }

            HStack(spacing: 10) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("“\(english)”")
                        .font(.footnote.weight(.medium))
                        .foregroundColor(.primary)

                    Text(isLoading ? "..." : (arabic ?? ""))
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }

                Button(action: {
                    if !isSaved {
                        onSave()
                    }
                }) {
                    Image(systemName: isSaved ? "checkmark" : "character.book.closed")
                        .font(.system(size: 16, weight: .semibold))
                        .frame(width: 28, height: 28)
                        .background(isSaved ? Color.blue.opacity(0.9) : Color.gray.opacity(0.9))
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .buttonStyle(.plain)
                .disabled(isSaved)
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 10)
            .background(Color(.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 14))

            if arrowEdge == .bottom {
                tailRow(isTop: false)
            }
        }
        .shadow(color: .black.opacity(0.18), radius: 18, x: 0, y: 10)
    }

    private func tailRow(isTop: Bool) -> some View {
        GeometryReader { geo in
            let w = geo.size.width
            let tailW: CGFloat = 18
            let tailH: CGFloat = 10

            let clampedX = min(max(arrowX, 14), max(14, w - 14))
            let xOffsetFromCenter = clampedX - (w / 2)

            BubbleTail()
                .fill(Color(.systemBackground))
                .frame(width: tailW, height: tailH)
                .rotationEffect(isTop ? .degrees(180) : .degrees(0))
                .offset(x: xOffsetFromCenter, y: -1)
        }
        .frame(height: 10)
    }
}
