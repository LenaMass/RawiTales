
import SwiftUI
import AVFoundation
import Speech
import Combine
import SwiftData


 

struct StoryView: View {
    
    @Bindable var story: Story
    @State private var showArabic: Bool = false
    private let speechSynthesizer = AVSpeechSynthesizer()
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
        // Check 'pages' instead of 'englishStory'
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
            // 1. IMAGE AREA (Adjusted height to push white background down)
            Image(story.storycover ?? "placeholder")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: UIScreen.main.bounds.height * 0.55) // Increased from 0.45 to 0.55
                .clipped()
                .ignoresSafeArea(edges: .top)
                .allowsHitTesting(false)
            
            
            // 2. UI LAYER
            VStack(spacing: 0) {
                // Independent Header Layer
                ZStack(alignment: .top) {
                    
                    // --- LAYER 1: THE TITLE (Purely Centered) ---
                    VStack {
                        
                        Text(story.title)
                            .font(.headline)
                            .padding(.horizontal, 25)
                            .padding(.vertical, 10)
                            .background(Capsule().fill(Color(.systemBackground)))
                        // Adjust this padding to sit perfectly under the iPhone capsule
                            .padding(.top, 60)
                            .ignoresSafeArea()
                    }
                    
                    // --- LAYER 2: THE BUTTONS (Pinned to the Right) ---
                    HStack {
                        Spacer() // Pushes everything in this HStack to the right
                        VStack(spacing: 15) {
                            CircleButton(
                                icon: isTranslating ? "ellipsis.bubble.fill" : (isTranslated ? "character.book.closed.fill" : "character.bubble.fill")
                            ) {
                                if isTranslated && !isTranslating {
                                    // Manual toggle to turn Arabic OFF
                                    isTranslated = false
                                    isClicked = false
                                } else {
                                    // Turn Arabic ON or translate current page
                                    translateCurrentPageENtoAR()
                                }
                            }
                            .foregroundColor(isClicked ? .blue : .primary)
                            
                            CircleButton(icon: "ear.and.waveform") {
                                speakCurrentPage()
                            }
                            
                            CircleButton(icon: story.isFavorite ? "star.fill" : "star") {
                                story.isFavorite.toggle()
                            }
                        }
                        .padding(.top, 50) // Adjust this so buttons don't overlap the title background
                    }
                    .padding(.horizontal, 20)
                }
                
                Spacer()
                
                //MARK: - the bottom view
                // BOTTOM CARD
                VStack(spacing: 20) {
                    // 1. Controls (Mic & Playback)
                    HStack(spacing: 20) {
                        recordButton
                        
                        Button(action: playRecording) {
                            Image(systemName: "play.circle.fill")
                                .font(.system(size: 44))
                                .foregroundColor(recordingExists ? .primary : .secondary)
                        }
                    }
                    .padding(.top, 20)
                    
                    // 2. Text Content (Back to ScrollView for reliability)
                    ScrollView {
                        Text(displayedPageText)
                            .font(.title3)
                            .multilineTextAlignment(.center)
                            .lineSpacing(8)
                            .padding(30)
                            .frame(maxWidth: .infinity)
                            .id(story.currentPage) // Matches your model property
                    }
                    
                    // 3. Pagination Dots
                    HStack(spacing: 8) {
                        ForEach(0..<story.pages.count, id: \.self) { index in
                            Circle()
                                .fill(index == story.currentPage ? Color.primary : Color.secondary.opacity(0.3))
                                .frame(width: 7, height: 7)
                                .scaleEffect(index == story.currentPage ? 1.4 : 1.0) // Makes the active dot slightly larger
                                .animation(.spring(response: 0.3, dampingFraction: 0.6), value: story.currentPage)
                        }
                    }
                    
                    .padding(.bottom, 40)
                    }
                    // Card Styling
                    .frame(maxWidth: .infinity)
                    .frame(height: UIScreen.main.bounds.height * 0.50)
                    .background(Color(.systemBackground))
                    .cornerRadius(30)
                    .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: -5)
                    .contentShape(Rectangle())
                    .highPriorityGesture(dragGesture) // Extracted below
                    .edgesIgnoringSafeArea(.bottom)
                }
                
            }
        
        .edgesIgnoringSafeArea(.bottom)
    }
    
    private func translateCurrentPageENtoAR() {
        // 1. Check if we already have it in cache
        if let cached = translatedArabicPages[story.currentPage], !cached.isEmpty {
            isTranslated = true
            isClicked = true
            return
        }
        
        // 2. Prepare the text for translation
        let text = englishPageText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !text.isEmpty, text != "Page not found" else { return }
        
        // 3. Avoid overlapping network calls
        guard !isTranslating else { return }
        
        isTranslating = true
        Task {
            defer { isTranslating = false }
            do {
                let ar = try await translator.translate(text, from: "EN", to: "AR")
                await MainActor.run {
                    translatedArabicPages[story.currentPage] = ar
                    // Ensure we stay in translated mode
                    isTranslated = true
                    isClicked = true
                }
            } catch {
                print("Translation Error: \(error)")
                // If it fails during a swipe, maybe revert to English so the user isn't stuck
                // await MainActor.run { isTranslated = false }
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
        // 1. Ensure we only evaluate English (Speech recognition is set to en-US)
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
                        // NEXT PAGE: use story.currentPage
                        if story.currentPage + 1 < story.pages.count {
                            updatePage(to: story.currentPage + 1)
                        }
                    } else if horizontal > 50 {
                        // PREVIOUS PAGE: use story.currentPage
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
                isTranslated = false // Reset translation when turning page
            }
        }
    }
    
    private func previousPage() {
        if story.currentPage > 0 {
            resetTranslationState() // Reset UI when moving
            story.currentPage -= 1
            updateProgress()
        }
    }
    
    private func resetTranslationState() {
        isTranslated = false
        isClicked = false
        if speechSynthesizer.isSpeaking {
            speechSynthesizer.stopSpeaking(at: .immediate)
        }
    }
    
    private func updateProgress() {
        // Use englishStory count here
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
            
            // Calculate Progress
            let total = story.pages.count
            if total > 0 {
                let calculated = Double(newIndex + 1) / Double(total) * 100.0
                story.Readingprogress = Int(calculated)
            }
            
            // REMOVED: isTranslated = false
            // We keep isTranslated as true if the user was already looking at Arabic
        }
        
        // If we are in translation mode, trigger the translation for the new page
        if isTranslated {
            translateCurrentPageENtoAR()
        }
    }
    
    private func speakCurrentPage() {
        // Stop if already speaking
        if speechSynthesizer.isSpeaking {
            speechSynthesizer.stopSpeaking(at: .immediate)
            return
        }
        
        let textToRead = displayedPageText
        let utterance = AVSpeechUtterance(string: textToRead)
        
        // Set language based on current view
        utterance.voice = AVSpeechSynthesisVoice(language: isTranslated ? "ar-SA" : "en-UK")
        utterance.rate = 0.5
        speechSynthesizer.speak(utterance)
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
            .background(.ultraThinMaterial) // This provides a glass effect on all modern iOS versions
            .clipShape(Circle())
        }
    }
    
    
    
    
    
    struct CircleButton: View {
        var icon: String
        var action: () -> Void
        
        var body: some View {
            Button(action: action) {
                Image(systemName: icon)
                    .font(.system(size: 18, weight: .bold))
                    .frame(width: 48, height: 48) // Standard Apple touch size
                    .background(Circle().fill(Color(.systemBackground).opacity(0.9)))
                    .shadow(color: .black.opacity(0.1), radius: 3)
            }
            .buttonStyle(.plain)
            .contentShape(Circle()) // Ensures the tap area is the whole circle
        }
    }
}
    #Preview {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: Story.self, configurations: config)
        
        let sampleStory = Story(
            title: "Back to the Moon",
            storycover: "storyCover1", // Ensure this exists in Assets
            englishStory: ["This is a page of the story about the moon.", "Second page text."],
            summary: "A story about a man and a queen."
        )
        
        container.mainContext.insert(sampleStory)
        
        return StoryView(story: sampleStory)
            .modelContainer(container)
    }

