import SwiftUI
import AVFoundation
import Speech
import Combine
import SwiftData

@MainActor
final class StorySpeechController: NSObject, ObservableObject, AVSpeechSynthesizerDelegate {
    @Published var isSpeaking: Bool = false

    private let synthesizer = AVSpeechSynthesizer()

    override init() {
        super.init()
        synthesizer.delegate = self
    }

    func speak(_ text: String, language: String) {
        if synthesizer.isSpeaking {
            synthesizer.stopSpeaking(at: .immediate)
            return
        }

        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: language)
        utterance.rate = 0.5
        synthesizer.speak(utterance)
    }

    func stop() {
        synthesizer.stopSpeaking(at: .immediate)
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didStart utterance: AVSpeechUtterance) {
        isSpeaking = true
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        isSpeaking = false
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) {
        isSpeaking = false
    }
}

struct StoryView: View {
    
    @Bindable var story: Story
    @State private var showArabic: Bool = false
    @StateObject private var speechController = StorySpeechController()
    @State private var isRecording = false
    @State private var audioRecorder: AVAudioRecorder?
    @State private var audioPlayer: AVAudioPlayer?
    @State private var transcription: String = ""
    @State private var feedback: String = ""
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))
    
    @State private var isClicked: Bool = false
    
    @State private var isTranslated: Bool = false
    @State private var isTranslating: Bool = false
    @State private var translatedArabicPages: [Int: String] = [:]
    
    @StateObject private var bubbleVM = WordBubbleViewModel()
    
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
    
    private var recordingExists: Bool {
        let url = FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("userRecording.m4a")
        return FileManager.default.fileExists(atPath: url.path)
    }
    
    private var englishPageText: String {
        if story.pages.indices.contains(story.currentPage) {
            return story.pages[story.currentPage]
        }
        return "Page not found"
    }
    
    private var displayedPageText: String {
        if isTranslating {
            return "Translating... Please wait."
        }
        
        if isTranslated {
            if let cached = translatedArabicPages[story.currentPage] {
                return cached
            }
        }
        
        return englishPageText
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            // Background image – fills the frame completely
            Image(story.storycover ?? "placeholder")
                .resizable()
                .aspectRatio(contentMode: .fill)   // fills the entire frame, cropping excess
                .frame(height: UIScreen.main.bounds.height * 0.5)
                .clipped()                          // ensures no overflow
                .ignoresSafeArea(edges: .top)
                .allowsHitTesting(false)
            
            VStack(spacing: 0) {
                // Buttons – unchanged
                HStack {
                    Spacer()
                    VStack(spacing: 15) {
                        CircleButton(
                            icon: isTranslating ? "ellipsis.bubble.fill" : (isTranslated ? "character.bubble" : "character.bubble.fill"),
                            isActive: isClicked,
                            activeForeground: .blue,
                            inactiveForeground: .primary,
                            activeBackground: Color(.systemBackground).opacity(0.9),
                            inactiveBackground: Color(.systemBackground).opacity(0.9)
                        ) {
                            if isTranslated && !isTranslating {
                                isTranslated = false
                                isClicked = false
                                bubbleVM.clear()
                                bubbleVM.setText(displayedPageText)
                            } else {
                                translateCurrentPageENtoAR()
                            }
                        }
                        
                        CircleButton(
                            icon: "ear.and.waveform",
                            isActive: speechController.isSpeaking,
                            activeForeground: .blue,
                            inactiveForeground: .primary,
                            activeBackground: Color(.systemBackground).opacity(0.9),
                            inactiveBackground: Color(.systemBackground).opacity(0.9)
                        ) {
                            speakCurrentPage()
                        }
                        
                        CircleButton(
                            icon: story.isFavorite ? "star.fill" : "star",
                            isActive: story.isFavorite,
                            activeForeground: .orange,
                            inactiveForeground: .primary,
                            activeBackground: Color(.systemBackground).opacity(0.9),
                            inactiveBackground: Color(.systemBackground).opacity(0.9)
                        ) {
                            story.isFavorite.toggle()
                        }
                    }
                    .padding(.top, 50)
                }
                .padding(.horizontal, 20)
                .zIndex(1)
                
                Spacer()
                
                // Main content card – slightly overlapped for seamless shadow
                VStack(spacing: 7) { // Reduced spacing to bring dots closer to text
                    HStack(spacing: 20) {
                        recordButton
                        
                        Button(action: playRecording) {
                            Image(systemName: "play.circle.fill")
                                .font(.system(size: 44))
                                .foregroundColor(recordingExists ? .primary : .secondary)
                        }
                    }
                    .padding(.top, 20)
                    
                    ScrollView {
                        VStack(alignment: .leading, spacing: 16) {
                            // Title – centered, with extra bottom padding
                            Text(story.title)
                                .font(.title2)
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 30)
                                .padding(.top, 10)
                                .padding(.bottom, 9) // 9pt space between title and story text
                            
                            TappableStoryTextView(
                                text: displayedPageText,
                                vm: bubbleVM,
                                onSave: { word, translation in
                                    handleSaveWord(word: word, translation: translation)
                                }
                            )
                            .id("\(story.currentPage)-\(displayedPageText)")
                            .font(.title3)
                            .padding(.horizontal, 30)
                            .padding(.bottom, 30)
                            .multilineTextAlignment(isTranslated ? .trailing : .leading)
                            .environment(\.layoutDirection, isTranslated ? .rightToLeft : .leftToRight)
                        }
                    }
                    
                    // Page indicator dots – pushed higher by increasing bottom padding
                    HStack(spacing: 8) {
                        ForEach(0..<story.pages.count, id: \.self) { index in
                            Circle()
                                .fill(index == story.currentPage ? Color.primary : Color.secondary.opacity(0.3))
                                .frame(width: 8, height: 8)
                                .scaleEffect(index == story.currentPage ? 1.4 : 1.0)
                                .animation(.spring(response: 0.3, dampingFraction: 0.6), value: story.currentPage)
                        }
                    }
                    .padding(.bottom, 40) // Increased from 20 to 40 to move dots upward
                }
                .frame(maxWidth: .infinity)
                .frame(height: UIScreen.main.bounds.height * 0.70)
                .background(Color(.systemBackground))
                .cornerRadius(30)
                .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: -5)
                .contentShape(Rectangle())
                .highPriorityGesture(dragGesture)
                .padding(.top, -10) // Overlap for shadow
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .toolbar(.hidden, for: .tabBar)
    }
    
    // MARK: - Helper Methods (unchanged)
    private func translateCurrentPageENtoAR() {
        if let cached = translatedArabicPages[story.currentPage], !cached.isEmpty {
            isTranslated = true
            isClicked = true
            bubbleVM.clear()
            bubbleVM.setText(displayedPageText)
            return
        }
        
        let text = englishPageText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !text.isEmpty, text != "Page not found" else { return }
        guard !isTranslating else { return }
        
        isTranslating = true
        Task {
            defer { isTranslating = false }
            do {
                let ar = try await translator.translate(text, from: "EN", to: "AR")
                await MainActor.run {
                    translatedArabicPages[story.currentPage] = ar
                    isTranslated = true
                    isClicked = true
                    bubbleVM.clear()
                    bubbleVM.setText(displayedPageText)
                }
            } catch {
                print("Translation Error: \(error)")
            }
        }
    }
    
    private func toggleRecording() {
        isRecording ? stopRecording() : startRecording()
    }
    
    private func startRecording() {
        let session = AVAudioSession.sharedInstance()
        try? session.setCategory(.playAndRecord, mode: .spokenAudio)
        try? session.setActive(true)
        
        let url = FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("userRecording.m4a")
        
        let settings: [String: Any] = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        audioRecorder = try? AVAudioRecorder(url: url, settings: settings)
        audioRecorder?.record()
        isRecording = true
    }
    
    private func stopRecording() {
        audioRecorder?.stop()
        audioRecorder = nil
        isRecording = false
        transcribeAndEvaluate()
    }
    
    private func playRecording() {
        let url = FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("userRecording.m4a")
        
        audioPlayer = try? AVAudioPlayer(contentsOf: url)
        audioPlayer?.play()
    }
    
    private var recordButton: some View {
        Button(action: toggleRecording) {
            Image(systemName: isRecording ? "stop.fill" : "mic.fill")
                .foregroundColor(.black)
                .padding(18)
                .background(Circle().fill(Color.yellow))
                .background(Circle().fill(Color.yellow.opacity(0.3)).scaleEffect(1.3))
        }
    }
    
    private func transcribeAndEvaluate() {
        guard !isTranslated else {
            feedback = "Pronunciation feedback is available for English only."
            return
        }
        
        let url = FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("userRecording.m4a")
        
        SFSpeechRecognizer.requestAuthorization { status in
            guard status == .authorized else {
                DispatchQueue.main.async { feedback = "Permission denied." }
                return
            }
            
            let request = SFSpeechURLRecognitionRequest(url: url)
            self.speechRecognizer?.recognitionTask(with: request) { result, error in
                guard let result = result, result.isFinal else { return }
                
                DispatchQueue.main.async {
                    self.transcription = result.bestTranscription.formattedString
                    self.generateFeedback()
                }
            }
        }
    }
    
    @Environment(\.modelContext) private var modelContext
    
    private func handleSaveWord(word: String, translation: String?) {
        let normalizedWord = word.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        
        let descriptor = FetchDescriptor<WordBankItem>()
        let existingItems = (try? modelContext.fetch(descriptor)) ?? []
        
        if existingItems.contains(where: {
            $0.word.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() == normalizedWord
        }) {
            bubbleVM.markSaved(word: word)
            
            Task {
                try? await Task.sleep(nanoseconds: 1_500_000_000)
                await MainActor.run {
                    withAnimation(.easeOut(duration: 0.25)) {
                        bubbleVM.clear()
                    }
                }
            }
            return
        }

        let newItem = WordBankItem(
            word: word,
            example: englishPageText,
            wordArabic: translation
        )

        modelContext.insert(newItem)
        bubbleVM.markSaved(word: word)

        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        
        Task {
            try? await Task.sleep(nanoseconds: 1_500_000_000)
            await MainActor.run {
                withAnimation(.easeOut(duration: 0.25)) {
                    bubbleVM.clear()
                }
            }
        }
    }
    
    private func generateFeedback() {
        guard let englishStory = story.englishStory,
              englishStory.indices.contains(story.currentPage) else {
            feedback = "No text available for evaluation."
            return
        }
        
        let expected = englishStory[story.currentPage]
            .lowercased()
            .components(separatedBy: .whitespacesAndNewlines)
        
        let spoken = transcription
            .lowercased()
            .components(separatedBy: .whitespacesAndNewlines)
        
        let missingWords = expected.filter { !spoken.contains($0) }
        
        if missingWords.isEmpty {
            feedback = "Great job! Your pronunciation was clear and accurate."
        } else {
            feedback = """
            You missed or mispronounced some words:
            \(missingWords.prefix(5).joined(separator: ", "))
            
            Try speaking more slowly and clearly, especially on stressed syllables.
            """
        }
    }
    
    private var dragGesture: some Gesture {
        DragGesture(minimumDistance: 20)
            .onEnded { value in
                let horizontal = value.translation.width
                let vertical = value.translation.height
                
                if abs(horizontal) > abs(vertical) {
                    if horizontal < -50 {
                        if story.currentPage + 1 < story.pages.count {
                            updatePage(to: story.currentPage + 1)
                        }
                    } else if horizontal > 50 {
                        if story.currentPage > 0 {
                            updatePage(to: story.currentPage - 1)
                        }
                    }
                }
            }
    }
    
    private func nextPage() {
        if let count = story.englishStory?.count, story.currentPage + 1 < count {
            withAnimation(.easeInOut) {
                story.currentPage += 1
                isTranslated = false
            }
        }
    }
    
    private func previousPage() {
        if story.currentPage > 0 {
            resetTranslationState()
            story.currentPage -= 1
            updateProgress()
        }
    }
    
    private func resetTranslationState() {
        isTranslated = false
        isClicked = false
        speechController.stop()
    }
    
    private func updateProgress() {
        guard let totalPages = story.englishStory?.count, totalPages > 1 else {
            story.Readingprogress = 100
            return
        }
        let progress = (Double(story.currentPage) / Double(totalPages - 1)) * 100
        story.Readingprogress = Int(progress)
    }
    
    private func updatePage(to newIndex: Int) {
        withAnimation(.spring()) {
            story.currentPage = newIndex
            
            let total = story.pages.count
            if total > 0 {
                let calculated = Double(newIndex + 1) / Double(total) * 100.0
                story.Readingprogress = Int(calculated)
            }
        }
        
        bubbleVM.clear()
        bubbleVM.setText(displayedPageText)
        speechController.stop()
        
        if isTranslated {
            translateCurrentPageENtoAR()
        }
    }
    
    private func speakCurrentPage() {
        speechController.speak(
            displayedPageText,
            language: isTranslated ? "ar-SA" : "en-UK"
        )
    }
    
    struct GlassCircleButton: View {
        var icon: String
        var action: () -> Void = {}
        
        var body: some View {
            Button(action: action) {
                Image(systemName: icon)
                    .padding(10)
                    .foregroundColor(.primary)
            }
            .buttonStyle(.plain)
            .background(.ultraThinMaterial)
            .clipShape(Circle())
        }
    }
    
    struct CircleButton: View {
        var icon: String
        var isActive: Bool = false
        var activeForeground: Color = .blue
        var inactiveForeground: Color = .primary
        var activeBackground: Color = Color(.systemBackground).opacity(0.9)
        var inactiveBackground: Color = Color(.systemBackground).opacity(0.9)
        var action: () -> Void
        
        var body: some View {
            Button(action: action) {
                Image(systemName: icon)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(isActive ? activeForeground : inactiveForeground)
                    .frame(width: 48, height: 48)
                    .background(
                        Circle().fill(isActive ? activeBackground : inactiveBackground)
                    )
                    .shadow(color: .black.opacity(0.1), radius: 3)
            }
            .buttonStyle(.plain)
            .contentShape(Circle())
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Story.self, configurations: config)
    
    let sampleStory = Story(
        title: "Back to the Moon",
        storycover: "storyCover1",
        englishStory: ["This is a page of the story about the moon.", "Second page text."],
        summary: "A story about a man and a queen."
    )
    
    container.mainContext.insert(sampleStory)
    
    return StoryView(story: sampleStory)
        .modelContainer(container)
}
