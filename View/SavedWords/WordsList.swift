import SwiftUI

struct WordsBankList: View {
    private let items: [WordBankItem] = [
        .init(word: "Looks", example: "“He looks at the mirror”"),
        .init(word: "Bright", example: "“The room is bright today”"),
        .init(word: "Calm", example: "“Stay calm and breathe”")
    ]

    var body: some View {
        ZStack {

            ScrollView(showsIndicators: false) {
                LazyVStack(spacing: 18) {
                    ForEach(items) { item in
                        WordCardView(
                            item: item,
                            onLeftAction: { print("Left action:", item.word) },
                            onRightAction: { print("Right action:", item.word) }
                        )
                        .padding(.horizontal, 20)
                    }
                }
                .padding(.top, 110)
                .padding(.bottom, 120)
            }
        }
    }
}

#Preview {
    WordsBankList()
}


