import Foundation
import SwiftUI

struct WordToken: Identifiable, Hashable {
    let id: Int
    let raw: String
    let isWord: Bool
}

struct WordSelection: Equatable {
    let tokenID: Int
    let word: String
}

struct WordTokenizer {
    static func tokenize(_ text: String) -> [WordToken] {
        let pattern = #"[^\S\r\n]+|[\p{L}\p{N}']+|[^\p{L}\p{N}\s]+"#
        let regex = try? NSRegularExpression(pattern: pattern)
        let ns = text as NSString
        let matches = regex?.matches(in: text, range: NSRange(location: 0, length: ns.length)) ?? []

        return matches.enumerated().map { idx, m in
            let s = ns.substring(with: m.range)
            let isWord = s.range(of: #"^[\p{L}\p{N}']+$"#, options: .regularExpression) != nil
            return WordToken(id: idx, raw: s, isWord: isWord)
        }
    }
}

//Ancor
struct TokenAnchorKey: PreferenceKey {
    static var defaultValue: [Int: Anchor<CGRect>] = [:]
    static func reduce(value: inout [Int: Anchor<CGRect>], nextValue: () -> [Int: Anchor<CGRect>]) {
        value.merge(nextValue(), uniquingKeysWith: { $1 })
    }
}

//Tail
struct BubbleTail: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        p.move(to: CGPoint(x: rect.midX, y: rect.maxY))
        p.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        p.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        p.closeSubpath()
        return p
    }
}

/// A simple wrap layout that places subviews left-to-right and moves to the next line when needed.
/// Works great for word "bubbles".
struct WordWrapLayout: Layout {
    var spacing: CGFloat = 8
    var lineSpacing: CGFloat = 10

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let maxWidth = proposal.width ?? .greatestFiniteMagnitude

        var rowWidth: CGFloat = 0
        var rowHeight: CGFloat = 0

        var totalWidth: CGFloat = 0
        var totalHeight: CGFloat = 0

        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)

            if rowWidth > 0, rowWidth + spacing + size.width > maxWidth {
                totalWidth = max(totalWidth, rowWidth)
                totalHeight += rowHeight + lineSpacing

                rowWidth = size.width
                rowHeight = size.height
            } else {
                rowWidth = rowWidth == 0 ? size.width : (rowWidth + spacing + size.width)
                rowHeight = max(rowHeight, size.height)
            }
        }

        totalWidth = max(totalWidth, rowWidth)
        totalHeight += rowHeight

        return CGSize(width: proposal.width ?? totalWidth, height: totalHeight)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let maxWidth = bounds.width

        var x = bounds.minX
        var y = bounds.minY
        var rowHeight: CGFloat = 0

        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)

            if x > bounds.minX, x + size.width > bounds.minX + maxWidth {
                x = bounds.minX
                y += rowHeight + lineSpacing
                rowHeight = 0
            }

            subview.place(
                at: CGPoint(x: x, y: y),
                anchor: .topLeading,
                proposal: ProposedViewSize(width: size.width, height: size.height)
            )

            x += size.width + spacing
            rowHeight = max(rowHeight, size.height)
        }
    }
}

