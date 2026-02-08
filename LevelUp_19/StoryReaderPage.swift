//
//  StoryReaderPage.swift
//  LevelUp_19
//
//  Created by Nuha  on 07/02/2026.
//

import SwiftUI
import Combine

struct StoryReaderPage: View {
    @ObservedObject var viewModel: StoryViewModel
    var story: StoryModel
    
    @State private var currentPage: Int = 0

    var body: some View {
        VStack {
            TabView(selection: $currentPage) {
                ForEach(0..<story.pages.count, id: \.self) { index in
                    ScrollView {
                        Text(story.pages[index])
                            .font(.title3)
                            .padding(30)
                            .multilineTextAlignment(.leading)
                    }
                    .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            
            // FIX 1: Updated onChange syntax (iOS 17+)
            .onChange(of: currentPage) { oldValue, newValue in
                viewModel.updateReadingProgress(for: story.id, currentPageIndex: newValue)
            }
            
            .onAppear {
                // FIX 2: Safer Resume Logic
                if story.pages.count > 0 {
                    let total = Double(story.pages.count - 1)
                    let progress = Double(story.Readingprogress) / 100.0
                    currentPage = Int(progress * total)
                }
            }
        }
        .navigationTitle(story.imageName)
        .navigationBarTitleDisplayMode(.inline)
    }
}
#Preview {
    let previewViewModel = StoryViewModel()
    
    // We explicitly return the view since we created a variable above it
    return NavigationStack {
        StoryReaderPage(
            viewModel: previewViewModel,
            story: StoryModel(
                imageName: "UnforgivableStory",
                pages: ["Page 1 text", "Page 2 text"],
                Readingprogress: 50 // Test if it resumes to page 2
            )
        )
    }
}
