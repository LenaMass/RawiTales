import SwiftUI

private struct BubbleSizeKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        let n = nextValue()
        if n != .zero { value = n }
    }
}

struct TappableStoryTextView: View {
    let text: String
    @ObservedObject var vm: WordBubbleViewModel
    let onSave: (String, String?) -> Void

    @State private var bubbleSize: CGSize = .zero

    var body: some View {
        ZStack(alignment: .topLeading) {
            WordWrapLayout(spacing: 2, lineSpacing: 8) {
                ForEach(vm.tokens, id: \.id) { t in
                    if t.isWord {
                        Text(t.raw)
                            .foregroundColor(vm.selection?.tokenID == t.id ? .red : .primary)
                            .onTapGesture {
                                vm.toggleSelection(tokenID: t.id, word: t.raw)
                            }
                            .anchorPreference(key: TokenAnchorKey.self, value: .bounds) { [t.id: $0] }
                    } else {
                        Text(t.raw)
                            .foregroundColor(.primary)
                    }
                }
            }
        }
        .overlayPreferenceValue(TokenAnchorKey.self) { anchors in
            GeometryReader { proxy in
                if let sel = vm.selection,
                   let a = anchors[sel.tokenID] {
                    let rect = proxy[a]

                    let safeInset: CGFloat = 8
                    let margin: CGFloat = 2
                    let tailLift: CGFloat = 4

                    let bw = max(bubbleSize.width, 1)
                    let bh = max(bubbleSize.height, 1)

                    let aboveY = rect.minY - margin - (bh / 2) + tailLift
                    let belowY = rect.maxY + margin + (bh / 2) - tailLift

                    let canShowAbove = aboveY - (bh / 2) >= safeInset
                    let canShowBelow = belowY + (bh / 2) <= proxy.size.height - safeInset

                    let y: CGFloat = {
                        if canShowAbove { return aboveY }
                        if canShowBelow { return belowY }
                        return min(
                            max(belowY, (bh / 2) + safeInset),
                            proxy.size.height - (bh / 2) - safeInset
                        )
                    }()

                    let x: CGFloat = {
                        let raw = rect.midX
                        return min(
                            max(raw, (bw / 2) + safeInset),
                            proxy.size.width - (bw / 2) - safeInset
                        )
                    }()

                    TranslationBubbleView(
                        english: sel.word,
                        arabic: vm.translatedArabic,
                        isLoading: vm.isLoading,
                        isSaved: vm.isSelectedWordSaved
                    ) {
                        onSave(sel.word, vm.translatedArabic)
                    }
                    .background(
                        GeometryReader { g in
                            Color.clear.preference(key: BubbleSizeKey.self, value: g.size)
                        }
                    )
                    .onPreferenceChange(BubbleSizeKey.self) { bubbleSize = $0 }
                    .position(x: x, y: y)
                }
            }
        }
        .contentShape(Rectangle())
        .onTapGesture { vm.clear() }
        .onAppear {
            vm.setText(text)
        }
        .onChange(of: text) { newValue in
            bubbleSize = .zero
            vm.setText(newValue)
        }
        .id(text)
    }
}
