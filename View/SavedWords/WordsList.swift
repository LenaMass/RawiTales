import SwiftUI
import SwiftData
import Combine
import AVFoundation


struct WordsBankList: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \WordBankItem.createdAt, order: .reverse) var items: [WordBankItem]
    
    @StateObject private var vm = WordsBankListViewModel.shared

    var body: some View {
        ZStack {
            Image("NightDay_Background")
                .resizable()
                .ignoresSafeArea()
            
            List {
                ForEach(items) { item in
                    WordCardView(
                        item: item,
                        isTranslating: vm.translatingID == item.id,
                        isSpeaking: vm.currentlySpeakingID == item.id,
                        onLeftAction: { vm.translateCard(item) },
                        onRightAction: {
                                    // --- THE FIX GOES HERE ---
                                    // 1. Prepare the speakers
                                    SpeechController.shared.configureAudioSession()
                                    
                                    // 2. Speak ONLY the word from this specific card
                                    // Use item.word (English) or item.wordArabic (Arabic)
                                    SpeechController.shared.speak(item.word, language: "en-GB")
                                }
                    )
                    .listRowInsets(EdgeInsets(top: 9, leading: 20, bottom: 9, trailing: 20))
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                    .contentShape(Rectangle())
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button(role: .destructive) {
                            modelContext.delete(item)
                        } label: {
                            Label("", systemImage: "trash")
                        }
                    }
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .padding(.top, 1)
            .padding(.bottom, 1)
        }
    }
}


class SpeechController: NSObject, ObservableObject {
    // This allows you to call SpeechController.shared from ANY file
    static let shared = SpeechController()
    
    private let speechSynthesizer = AVSpeechSynthesizer()

    // Forces audio to the loud bottom speakers
    func configureAudioSession() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playback, mode: .default, options: [.defaultToSpeaker])
            try audioSession.setActive(true)
        } catch {
            print("Failed to set audio session: \(error)")
        }
    }

    func speak(_ text: String, language: String) {
        // Stop any current reading (like a long paragraph) immediately
        if speechSynthesizer.isSpeaking {
            speechSynthesizer.stopSpeaking(at: .immediate)
        }

        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: language)
        
        // Slow down slightly for single words to make them clearer
        utterance.rate = 0.45
        
        speechSynthesizer.speak(utterance)
    }
}



#Preview {
    WordsBankList()
}


