//
//  StoryDetailView.swift
//  LevelUp_19
//
//  Created by Nuha  on 08/02/2026.
//
/*
import SwiftUI
import Combine
import SwiftData

struct StoryDetailView: View {
    // ❌ REMOVE THIS:
    // @ObservedObject var viewModel: SavedStoryViewModel
    
    // ✅ KEEP THIS:
    let story: SavedStoryData
    
    @State private var currentPage: Int

    // ✅ UPDATE THE INIT: Remove viewModel from here
    init(story: SavedStoryData) {
        self.story = story
        // Jump to the page saved in the database
        _currentPage = State(initialValue: story.currentPageIndex)
    }

    var body: some View {
        ZStack {
            TabView(selection: $currentPage) {
                ForEach(0..<story.pages.count, id: \.self) { index in
                    VStack(alignment: .leading, spacing: 0) {
                        Text(story.pages[index])
                            .font(.system(size: 24, weight: .regular, design: .serif))
                            .foregroundColor(.blue)
                            .padding(.horizontal, 30)
                            .padding(.top, 50)
                        Spacer()
                    }
                    .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
        }
        .onChange(of: currentPage) { newValue in
            // ✅ UPDATE THE PROGRESS DIRECTLY ON THE MODEL
            story.currentPageIndex = newValue
            
            let total = story.pages.count
            if total > 0 {
                let calculated = Double(newValue + 1) / Double(total) * 100.0
                story.Readingprogress = Int(calculated)
            }
            // SwiftData saves this change automatically!
        }
        .navigationTitle(story.imageName)
    }
}
*/
