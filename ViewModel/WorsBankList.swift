import Foundation
import SwiftUI
import Combine
import AVFoundation
import SwiftData

@MainActor
final class WordsBankListViewModel: NSObject, ObservableObject, AVSpeechSynthesizerDelegate {
    static let shared = WordsBankListViewModel()
    
    @Published var translatingID: UUID? = nil
    @Published var currentlySpeakingID: UUID? = nil
    
    private let synthesizer = AVSpeechSynthesizer()
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

    override init() {
        super.init()
        synthesizer.delegate = self
    }

    func speak(_ item: WordBankItem) {
        if synthesizer.isSpeaking {
            synthesizer.stopSpeaking(at: .immediate)
            
            if currentlySpeakingID == item.id {
                currentlySpeakingID = nil
                return
            }
        }
        
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
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        currentlySpeakingID = nil
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) {
        currentlySpeakingID = nil
    }
}
