import SwiftUI
import Combine
import SwiftData

struct WordCardView: View {
    let item: WordBankItem
    let isTranslating: Bool
    let isSpeaking: Bool
    let onLeftAction: () -> Void
    let onRightAction: () -> Void
    
    
    
    @State private var isClicked: Bool = false
    
    init(
        item: WordBankItem,
        isTranslating: Bool = false,
        isSpeaking: Bool = false,
        onLeftAction: @escaping () -> Void,
        onRightAction: @escaping () -> Void
    ) {
        self.item = item
        self.isTranslating = isTranslating
        self.isSpeaking = isSpeaking
        self.onLeftAction = onLeftAction
        self.onRightAction = onRightAction
    }

    private var hasWordArabic: Bool {
        !(item.wordArabic?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true)
    }

    private var hasExampleArabic: Bool {
        !(item.exampleArabic?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true)
    }

    var body: some View {
        VStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 10) {
                Text(item.word)
                    .font(.title2).bold()
                    .foregroundColor(.red)
                
                if isClicked, let arWord = item.wordArabic {
                    Text(arWord)
                        .font(.title3)
                        .foregroundColor(.orange)
                }
                
                Text(item.example)
                    .font(.body)
                
                if isClicked, let arExample = item.exampleArabic {
                    Text(arExample)
                        .font(.body)
                        .foregroundColor(.secondary)
                }
            }
            .padding(.horizontal, 18)
            .padding(.vertical, 16)
            .frame(maxWidth: .infinity, alignment: .leading)

            Divider()
                .background(Color.black)
                .opacity(5)

            HStack(spacing: 0) {
                Button {
                    let isMissingData = (item.wordArabic?.isEmpty ?? true) || (item.exampleArabic?.isEmpty ?? true)
                    
                    if isMissingData {
                        onLeftAction()
                        withAnimation {
                            isClicked = true
                        }
                    } else {
                        withAnimation {
                            isClicked.toggle()
                        }
                    }
                } label: {
                    Group {
                        if isTranslating {
                            ProgressView()
                                .scaleEffect(0.9)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        } else {
                            Image(systemName: "translate")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(isClicked ? .blue : .black.opacity(0.70))
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                    }
                    .contentShape(Rectangle())
                }
                .buttonStyle(.plain)

                Divider()
                    .background(Color.black)

                Button {
                    onRightAction()
                } label: {
                    Image(systemName: "ear.and.waveform")
                        .font(.system(size: 20, weight: .semibold))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .foregroundColor(isSpeaking ? .blue : .black.opacity(0.70))
                        .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
            }
            .frame(height: 54)
        }
        .background(
            RoundedRectangle(cornerRadius: 22)
                .fill(Color.white)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 22)
                .strokeBorder(Color.white.opacity(0.25), lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.20), radius: 14, x: 0, y: 10)
    }
}



#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        WordCardView(
            item: .init(
                word: "Looks",
                example: "“He looks at the mirror.”",
                wordArabic: "ينظر",
                exampleArabic: "“إنه ينظر إلى المرآة.”"
            ),
            isTranslating: false,
            isSpeaking: true,
            onLeftAction: {},
            onRightAction: {}
        )
        .padding(.horizontal, 20)
    }
}
