//
//  StoriesScrollbar.swift
//  LevelUp_19
//
//  Created by Nuha  on 08/02/2026.
//

import SwiftUI
import Combine
import SwiftData

struct StoriesScrollbar: View {
    // 1. CHANGE: Delete the ObservedObject and use @Query to get real saved data
    @Query var savedStories: [SavedStoryData]
    
    let columns = [
        GridItem(.flexible(), spacing: 30),
        GridItem(.flexible(), spacing: 30),
        GridItem(.flexible(), spacing: 30)
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 10) {
                // 2. CHANGE: Loop through savedStories instead of viewModel
                ForEach(savedStories) { story in
                    // 3. CHANGE: Remove "viewModel: viewModel" from the destination
                    NavigationLink(destination: StoryDetailView(story: story)) {
                        Image(story.imageName)
                            .resizable()
                            .scaledToFill()
                            .frame(height: 180) // Added frame to ensure consistency
                            .cornerRadius(18)
                            .clipped()
                            .overlay( // Using overlay is cleaner for progress bars than background
                                VStack {
                                    Spacer()
                                    ZStack(alignment: .leading) {
                                        Capsule()
                                            .fill(Color.gray.opacity(0.3))
                                            .frame(height: 8)
                                        
                                        GeometryReader { geo in
                                            Capsule()
                                                .fill(Color.black)
                                                .frame(width: geo.size.width * (Double(story.Readingprogress) / 100.0), height: 8)
                                        }
                                        .frame(height: 8)
                                    }
                                    .padding(.horizontal, 12)
                                    .padding(.bottom, 10)
                                }
                            )
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.bottom, 60)
                }
            }
            .padding()
        }
        .background(Color.clear)
        .scrollContentBackground(.hidden)
    }
}
