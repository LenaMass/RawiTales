import Foundation
import Combine

@MainActor
final class WordBubbleViewModel: ObservableObject {
    @Published private(set) var tokens: [WordToken] = []
    @Published var selection: WordSelection? = nil
    @Published var translatedArabic: String? = nil
    @Published var isLoading: Bool = false

    private var cache: [String: String] = [:]

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

    func setText(_ text: String) {
        tokens = WordTokenizer.tokenize(text)
        clear()
    }

    func clear() {
        selection = nil
        translatedArabic = nil
        isLoading = false
    }

    func toggleSelection(tokenID: Int, word: String) {
        let clean = word.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !clean.isEmpty else { return }

        if selection?.tokenID == tokenID {
            clear()
            return
        }

        selection = WordSelection(tokenID: tokenID, word: clean)

        if let cached = cache[clean] {
            translatedArabic = cached
            isLoading = false
            return
        }

        guard !deeplApiKey.isEmpty else { return }

        translatedArabic = nil
        isLoading = true

        Task {
            do {
                let ar = try await translator.translate(clean, from: "EN", to: "AR")
                cache[clean] = ar
                if selection?.tokenID == tokenID {
                    translatedArabic = ar
                }
            } catch {
            }
            if selection?.tokenID == tokenID {
                isLoading = false
            }
        }
    }
}


