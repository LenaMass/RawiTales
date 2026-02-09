//
//  StoryView.swift
//  LevelUp_19
//
//  Created by Reem Alghamdi on 20/08/1447 AH.
//

import SwiftUI
import AVFoundation
import Speech
import Combine
//import stories

struct StoryView: View {
    @State var story: Story
    @State private var showArabic: Bool = false
    private let speechSynthesizer = AVSpeechSynthesizer()
    @State private var isRecording = false
    @State private var audioRecorder: AVAudioRecorder?
    @State private var audioPlayer: AVAudioPlayer?
    @State private var transcription: String = ""
    @State private var feedback: String = ""
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))
    
    private var recordingExists: Bool {
        let url = FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("userRecording.m4a")
        return FileManager.default.fileExists(atPath: url.path)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // MARK: - Top Image Section
            ZStack(alignment: .top) {
                Image(story.cover ?? "placeholder")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: UIScreen.main.bounds.height * 0.45)
                    .clipped()
                
                // Top Header Overlay
                HStack {
                    Button(action: {}) {
                        Image(systemName: "chevron.left")
                            .padding()
                            .background(Color(.systemBackground).opacity(0.85))
                            .clipShape(Circle())
                            .foregroundColor(.primary)
                    }
                    
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
                            } else {
                                speakCurrentPage()
                            }
                        }
                        CircleButton(icon: "star")
                    }
                }
                .padding(.top, 50)
                .padding(.horizontal, 20)
            }
            
            // MARK: - Bottom Content Section
            VStack(spacing: 30) {
                // Microphone Button
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
                .padding(.top, -40) // Overlaps the image slightly
                
                // Playback Slider
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

                    Text("AI")
                        .font(.caption)
                        .bold()
                        .padding(8)
                        .background(Circle().fill(Color.gray.opacity(0.2)))
                }
                .padding(.horizontal, 30)
                
                // Description Text
                ScrollView {
                    Text(
                        showArabic
                        ? (story.arabicStory?.indices.contains(story.currentPage) == true
                            ? story.arabicStory![story.currentPage]
                            : "لا يوجد محتوى")
                        : (story.englishStory?.indices.contains(story.currentPage) == true
                            ? story.englishStory![story.currentPage]
                            : "No content available")
                    )
                    .font(.title3)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
                    .lineSpacing(8)
                    .padding(.horizontal, 40)
                    .padding(.vertical, 10)
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
                
                // Pagination Dots
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
    
    private func transcribeAndEvaluate() {
        guard !showArabic else {
            feedback = "Pronunciation feedback is available for English only."
            return
        }

        let url = FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("userRecording.m4a")

        SFSpeechRecognizer.requestAuthorization { status in
            guard status == .authorized else {
                feedback = "Speech recognition permission not granted."
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
    
    // Pagination and progress update helpers
    private func nextPage() {
        guard let count = story.englishStory?.count,
              story.currentPage + 1 < count else { return }
        story.currentPage += 1
        updateProgress()
    }

    private func previousPage() {
        guard story.currentPage > 0 else { return }
        story.currentPage -= 1
        updateProgress()
    }

    private func updateProgress() {
        let totalPages = max((story.englishStory?.count ?? 1) - 1, 1)
        story.progress = Int(
            (Double(story.currentPage) / Double(totalPages)) * 100
        )
    }
    
    private func speakCurrentPage() {
        let textToRead: String

        if showArabic {
            guard let arabic = story.arabicStory,
                  arabic.indices.contains(story.currentPage) else { return }
            textToRead = arabic[story.currentPage]
        } else {
            guard let english = story.englishStory,
                  english.indices.contains(story.currentPage) else { return }
            textToRead = english[story.currentPage]
        }

        if speechSynthesizer.isSpeaking {
            speechSynthesizer.stopSpeaking(at: .immediate)
        }

        let utterance = AVSpeechUtterance(string: textToRead)
        if showArabic {
            utterance.voice = AVSpeechSynthesisVoice(language: "ar-SA")
        } else {
            // Use 'Allison (Enhanced)' from the Apple Voice Library if available
            utterance.voice = AVSpeechSynthesisVoice(identifier: "com.apple.ttsbundle.Allison-premium") ??
                             AVSpeechSynthesisVoice(identifier: "com.apple.ttsbundle.Allison-compact") ??
                             AVSpeechSynthesisVoice(language: "en-UK")
        }
        utterance.rate = 0.5

        speechSynthesizer.speak(utterance)
    }
}

 // Helper for the side buttons
struct CircleButton: View {
    var icon: String
    var action: () -> Void = {}

    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .padding(10)
                .background(Color.primary.opacity(0.15))
                .clipShape(Circle())
                .foregroundColor(.primary)
        }
    }
}

#Preview {
    StoryView(story: Story(
            title: "The Golden Gazelle",
            progress: 0,
            currentPage: 0,
            summary: "A beautiful desert tale."
        ))
}
