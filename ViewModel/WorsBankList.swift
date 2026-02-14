import Foundation
import SwiftUI
import Combine
import AVFoundation
import SwiftData

@MainActor
final class WordsBankListViewModel: ObservableObject {
    static let shared = WordsBankListViewModel()
        
        @Published var translatingID: UUID? = nil
        @Published var currentlySpeakingID: UUID? = nil
        
        private let synthesizer = AVSpeechSynthesizer()
   // private let store: WordsBankStore
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

   /* init(store: WordsBankStore = .shared) {
        self.store = store

        store.$items
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newItems in
                self?.items = newItems
            }
            .store(in: &cancellables)
    }
    */
    func speak(_ item: WordBankItem) {
            // 1. If it's already speaking, stop it.
            if synthesizer.isSpeaking {
                synthesizer.stopSpeaking(at: .immediate)
                
                // 2. If the user clicked the SAME card, just stay silent.
                // If they clicked a DIFFERENT card, stop the old one and start the new one.
                if currentlySpeakingID == item.id {
                    currentlySpeakingID = nil
                    return
                }
            }
            
            // 3. Start speaking the new item
            let textToRead = "\(item.word). \(item.example)"
            let utterance = AVSpeechUtterance(string: textToRead)
            utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
            utterance.rate = 0.5
            
            currentlySpeakingID = item.id
            synthesizer.speak(utterance)
        }

    func translateCard(_ item: WordBankItem) {
            guard translatingID == nil else { return }
            translatingID = item.id

            Task {
                defer { translatingID = nil }
                do {
                    // Instead of calling store.update, modify the item directly.
                    // SwiftData automatically detects these changes and saves them.
                    let wAr = try await translator.translate(item.word, from: "EN", to: "AR")
                    let ex = item.example.trimmingCharacters(in: .whitespacesAndNewlines)
                    let exAr = ex.isEmpty ? "" : try await translator.translate(ex, from: "EN", to: "AR")
                    
                    await MainActor.run {
                        item.wordArabic = wAr
                        item.exampleArabic = exAr
                    }
                } catch {
                    print("Translation error: \(error)")
                }
            }
        }
}

