
import SwiftUI
import AVFoundation
import Speech
import Combine
import SwiftData


struct StoryView: View {
    @Bindable var story: Story
    
    
        @State private var showArabic: Bool = false
        @State private var isRecording = false
        @State private var transcription: String = ""
        @State private var feedback: String = ""
        
        // 3. Audio & Speech properties
        private let speechSynthesizer = AVSpeechSynthesizer()
        private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))
        @State private var audioRecorder: AVAudioRecorder?
        @State private var audioPlayer: AVAudioPlayer?
    
import SwiftUI
import AVFoundation
import Speech

struct StoryView: View {
    @State private var story: Story = stories[5]
    @State private var showArabic: Bool = false
    private let speechSynthesizer = AVSpeechSynthesizer()
    @State private var isRecording = false
    @State private var audioRecorder: AVAudioRecorder?
    @State private var audioPlayer: AVAudioPlayer?
    @State private var transcription: String = ""
    @State private var feedback: String = ""
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))

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
        guard let english = story.englishStory,
              english.indices.contains(story.currentPage) else { return "No content available" }
        return english[story.currentPage]
    }

    private var displayedPageText: String {
        if isTranslated {
            if let cached = translatedArabicPages[story.currentPage], !cached.isEmpty {
                return cached
            }
            return isTranslating ? "Translating..." : "..."
        }
        return englishPageText
    }

    var body: some View {
        
     
        
        VStack(spacing: 0) {
            // MARK: - Top Image Section
            ZStack(alignment: .top) {
                Image(story.storycover ?? "placeholder")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: UIScreen.main.bounds.height * 0.45)
                    .clipped()
                
                // Top Header Overlay
                HStack {
                  
                    
                    Spacer()
                    
                    Text(story.title)
                        .font(.headline)
                        .padding(.horizontal, 40)
                        .padding(.vertical, 10)
                        .background(Color(.systemBackground))
                        .cornerRadius(20)
                    
                    Spacer()
                    
                    // Side Buttons
                    VStack(spacing: 12) {
                        CircleButton(icon: "character.book.closed.fill") {
                            showArabic.toggle()
                        }
                        CircleButton(icon: "ear.and.waveform") {
                            if speechSynthesizer.isSpeaking {
                                speechSynthesizer.stopSpeaking(at: .immediate)
                            } /*else {
                                speakCurrentPage()
                            }*/
                        }
                        CircleButton(icon: story.isFavorite ? "star.fill" : "star") {
                                        story.isFavorite.toggle()
                                    }
                    }
                    .padding(.top, 50)
                    .padding(.horizontal, 20)
                }

                VStack(spacing: 30) {
                    Button(action: {
                        toggleRecording()
                    }) {
                        ZStack {
                            Circle()
                                .fill(Color.yellow.opacity(0.3))
                                .frame(width: 80, height: 80)
                            Circle()
                                .fill(Color.yellow)
                                .frame(width: 60, height: 60)
                                .shadow(radius: 5)
                            Image(systemName: isRecording ? "stop.fill" : "mic.fill")
                                .foregroundColor(.black)
                                .font(.title)
                        }
                    }
                    .padding(.top, -40)

                    HStack(spacing: 15) {
                        Button {
                            playRecording()
                        } label: {
                            Image(systemName: "play.circle.fill")
                                .font(.system(size: 40))
                                .foregroundColor(recordingExists ? .primary : .secondary)
                        }

                        Rectangle()
                            .fill(Color.secondary.opacity(0.4))
                            .frame(height: 3)

                        
                    }
                    .padding(.horizontal, 30)

                    ScrollView {
                        VStack(spacing: 0) {
                            Color.clear.frame(height: 0)

                    Text("AI")
                        .font(.caption)
                        .bold()
                        .padding(8)
                        .background(Circle().fill(Color.gray.opacity(0.2)))
                }
                .padding(.horizontal, 30)
                
                // Description Text
                ScrollView {
                    VStack {
                        Text(
                            story.pages.indices.contains(story.currentPage)
                            ? story.pages[story.currentPage]
                            : "End of story"
                        )
                        .font(.title3)
                        .multilineTextAlignment(.center)
                        .lineSpacing(8)
                        .padding(.horizontal, 40)
                        .padding(.vertical, 10)
                    }
                    .frame(minHeight: UIScreen.main.bounds.height * 0.3) // Give it enough space to catch taps
                    .contentShape(Rectangle()) // Makes the whole area swipable
                }
                .gesture(
                    DragGesture()
                        .onEnded { value in
                            if value.translation.width < -50 {
                                nextPage()
                            } else if value.translation.width > 50 {
                                previousPage()
                            }
                        }
                    }
                    .frame(maxHeight: .infinity)
                    .gesture(
                        DragGesture()
                            .onEnded { value in
                                if value.translation.width < -50 {
                                    nextPage()
                                } else if value.translation.width > 50 {
                                    previousPage()
                                }
                            }
                    )

                    if !feedback.isEmpty {
                        Text(feedback)
                            .font(.footnote)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 30)
                    }

                    HStack(spacing: 8) {
                        ForEach(0..<(story.englishStory?.count ?? 0), id: \.self) { index in
                            Circle()
                                .fill(index == story.currentPage ? Color.primary : Color.secondary.opacity(0.4))
                                .frame(
                                    width: index == story.currentPage ? 8 : 6,
                                    height: index == story.currentPage ? 8 : 6
                                )
                                .animation(.easeInOut(duration: 0.2), value: story.currentPage)
                        }
                    }
                    .padding(.bottom, 20)
                }
                .frame(maxWidth: .infinity)
                .background(Color(.systemBackground))
            }
            .edgesIgnoringSafeArea(.top)
        }
    }

    private func translateCurrentPageENtoAR() {
        if isTranslated || isTranslating {
            isTranslated = false
            isTranslating = false
            return
        }

        guard !deeplApiKey.isEmpty else { return }

        let text = englishPageText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !text.isEmpty else { return }

        if let cached = translatedArabicPages[story.currentPage], !cached.isEmpty {
            isTranslated = true
            return
        }

        isTranslating = true

        Task {
            defer { isTranslating = false }
            do {
                let ar = try await translator.translate(text, from: "EN", to: "AR")
                translatedArabicPages[story.currentPage] = ar
                isTranslated = true
            } catch {
                isTranslated = false
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
      // transcribeAndEvaluate()
    }

    private func playRecording() {
        let url = FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("userRecording.m4a")

        audioPlayer = try? AVAudioPlayer(contentsOf: url)
        audioPlayer?.play()
    }
//
//    private func transcribeAndEvaluate() {
////        guard !isTranslated else {
////            feedback = "Pronunciation feedback is available for English only."
////            return
////        }
//
//        let url = FileManager.default
//            .urls(for: .documentDirectory, in: .userDomainMask)[0]
//            .appendingPathComponent("userRecording.m4a")
//
//        SFSpeechRecognizer.requestAuthorization { status in
//            guard status == .authorized else {
//                feedback = "Speech recognition permission not granted."
//                return
//            }
//
//            let request = SFSpeechURLRecognitionRequest(url: url)
//
//            self.speechRecognizer?.recognitionTask(with: request) { result, _ in
//                guard let result = result, result.isFinal else { return }
//
//                DispatchQueue.main.async {
//                    self.transcription = result.bestTranscription.formattedString
//                    self.generateFeedback()
//                }
//            }
//        }
//    }

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

    private func nextPage() {
        // Check 'pages' count instead of 'englishStory'
        if story.currentPage + 1 < story.pages.count {
            story.currentPage += 1
            updateProgress()
        }
    }

    private func previousPage() {
        if story.currentPage > 0 {
            story.currentPage -= 1
            updateProgress()
        }
    }

    private func updateProgress() {
        let totalPages = story.pages.count
        guard totalPages > 1 else {
            story.Readingprogress = 100
            return
        }
        
        // Calculate percentage based on current page vs total pages
        let progress = (Double(story.currentPage) / Double(totalPages - 1)) * 100
        story.Readingprogress = Int(progress)
    }
    
   /* private func speakCurrentPage() {
        let textToRead: String
        if isTranslated, let cached = translatedArabicPages[story.currentPage], !cached.isEmpty {
            textToRead = cached
        } else {
            textToRead = englishPageText
        }

        if speechSynthesizer.isSpeaking {
            speechSynthesizer.stopSpeaking(at: .immediate)
        }

        let utterance = AVSpeechUtterance(string: textToRead)
        if isTranslated {
            utterance.voice = AVSpeechSynthesisVoice(language: "ar-SA")
        } else {
            utterance.voice = AVSpeechSynthesisVoice(language: "en-UK")
        }
        utterance.rate = 0.5
        speechSynthesizer.speak(utterance)
    }*/
}

struct GlassCircleButton: View {
    var icon: String
    var action: () -> Void = {}
    var color: Color = .primary
    
    
    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .padding(10)
                .foregroundColor(.primary)
        }
        .buttonStyle(.plain)
        .background(
            Group {
                if #available(iOS 26.0, *) {
                    Circle().glassEffect(.clear)
                } else {
                    Circle().fill(Color(.systemBackground).opacity(0.85))
                }
            }
        )
        .clipShape(Circle())
    }
}

struct CircleButton: View {
    var icon: String
    var action: () -> Void = {}

    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .padding(12)
                .foregroundColor(.primary)
                .background(Color(.systemBackground).opacity(0.85))
                .clipShape(Circle())
        }
        .buttonStyle(.plain)
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

