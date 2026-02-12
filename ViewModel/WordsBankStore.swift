import Foundation
import Combine

final class WordsBankStore: ObservableObject {
    static let shared = WordsBankStore()

    @Published private(set) var items: [WordBankItem] = []

    private let storageKey = "WORDS_BANK_ITEMS_V2"

    private init() {
        load()
    }

    func add(word: String, example: String, wordArabic: String?) {
        let w = word.trimmingCharacters(in: .whitespacesAndNewlines)
        let ex = example.trimmingCharacters(in: .whitespacesAndNewlines)
        let wa = wordArabic?.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !w.isEmpty else { return }

        if let idx = items.firstIndex(where: { $0.word.lowercased() == w.lowercased() }) {
            var updated = items[idx]
            if let wa, !wa.isEmpty { updated.wordArabic = wa }
            if !ex.isEmpty { updated = WordBankItem(id: updated.id, word: updated.word, example: ex, wordArabic: updated.wordArabic, exampleArabic: updated.exampleArabic, createdAt: updated.createdAt) }

            items.remove(at: idx)
            items.insert(updated, at: 0)
            save()
            return
        }

        let item = WordBankItem(
            word: w,
            example: ex,
            wordArabic: (wa?.isEmpty == false) ? wa : nil,
            exampleArabic: nil
        )

        items.insert(item, at: 0)
        save()
    }

    func updateWordArabic(id: UUID, arabic: String?) {
        guard let idx = items.firstIndex(where: { $0.id == id }) else { return }
        let ar = arabic?.trimmingCharacters(in: .whitespacesAndNewlines)
        items[idx].wordArabic = (ar?.isEmpty == false) ? ar : nil
        save()
    }

    func updateExampleArabic(id: UUID, arabic: String?) {
        guard let idx = items.firstIndex(where: { $0.id == id }) else { return }
        let ar = arabic?.trimmingCharacters(in: .whitespacesAndNewlines)
        items[idx].exampleArabic = (ar?.isEmpty == false) ? ar : nil
        save()
    }

    func delete(_ item: WordBankItem) {
        items.removeAll { $0.id == item.id }
        save()
    }

    private func load() {
        guard let data = UserDefaults.standard.data(forKey: storageKey) else {
            items = []
            return
        }
        do {
            items = try JSONDecoder().decode([WordBankItem].self, from: data)
        } catch {
            items = []
        }
    }

    private func save() {
        do {
            let data = try JSONEncoder().encode(items)
            UserDefaults.standard.set(data, forKey: storageKey)
        } catch {
        }
    }
}


