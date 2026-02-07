import Foundation
import Combine

final class WordsBankListViewModel: ObservableObject {
    @Published var items: [WordBankItem] = [
        .init(word: "Looks", example: "“He looks at the mirror”"),
        .init(word: "Bright", example: "“The room is bright today”"),
        .init(word: "Calm", example: "“Stay calm and breathe”")
    ]

    func delete(_ item: WordBankItem) {
        items.removeAll { $0.id == item.id }
    }
}
