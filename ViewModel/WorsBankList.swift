import Foundation
import Combine

@MainActor
final class WordsBankListViewModel: ObservableObject {
    @Published var items: [WordBankItem] = []
    @Published var translatingID: UUID? = nil

    private let store: WordsBankStore
    private var cancellables: Set<AnyCancellable> = []

    private var deeplApiKey: String {
        Bundle.main.object(forInfoDictionaryKey: "DEEPL_API_KEY") as? String ?? ""
    }

    private var deeplIsFreePlan: Bool {
        let v = Bundle.main.object(forInfoDictionaryKey: "DEEPL_FREE_PLAN") as? String ?? "YES"
        return (v as NSString).boolValue
    }

    private var translator: DeepLTranslator {
        DeepLTranslator(apiKey: deeplApiKey, isFreePlan: deeplIsFreePlan)
    }

    init(store: WordsBankStore = .shared) {
        self.store = store

        store.$items
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newItems in
                self?.items = newItems
            }
            .store(in: &cancellables)
    }

    func delete(_ item: WordBankItem) {
        store.delete(item)
    }

    func translateCard(_ item: WordBankItem) {
        guard translatingID == nil else { return }
        guard !deeplApiKey.isEmpty else { return }

        let needsWord = (item.wordArabic?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true)
        let needsExample = (item.exampleArabic?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true)

        guard needsWord || needsExample else { return }

        translatingID = item.id

        Task {
            defer { translatingID = nil }
            do {
                if needsWord {
                    let wAr = try await translator.translate(item.word, from: "EN", to: "AR")
                    store.updateWordArabic(id: item.id, arabic: wAr)
                }

                if needsExample {
                    let ex = item.example.trimmingCharacters(in: .whitespacesAndNewlines)
                    if !ex.isEmpty {
                        let exAr = try await translator.translate(ex, from: "EN", to: "AR")
                        store.updateExampleArabic(id: item.id, arabic: exAr)
                    }
                }
            } catch {
            }
        }
    }
}

