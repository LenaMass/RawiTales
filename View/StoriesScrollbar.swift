//
//  StoriesScrollbar.swift
//  LevelUp_19
//
//  Created by Nuha  on 08/02/2026.
//

import SwiftUI
import Combine
struct StoriesScrollbar: View {
    // CHANGE: Use ObservedObject so it shares data with the parent
    @ObservedObject var viewModel: StoryViewModel
    
    let columns = [
        GridItem(.flexible(), spacing: 30),
        GridItem(.flexible(), spacing: 30),
        GridItem(.flexible(), spacing: 30)
    ]
    
    var body: some View {
        // Remove the outer VStack, it's not needed and can block backgrounds
        ScrollView {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(viewModel.allStories) { story in
                    NavigationLink(destination: StoryDetailView(viewModel: viewModel, story: story)) {
                        Image(story.imageName)
                            .resizable()
                            .scaledToFill()
                            .cornerRadius(18)
                            .clipped()
                            .background(
                                VStack {
                                    Spacer()
                                    ZStack(alignment: .leading) {
                                        Capsule()
                                            .fill(Color.gray.opacity(0.3))
                                            .frame(height: 8)
                                        
                                        // GeometryReader detects the width of the container
                                        GeometryReader { geo in
                                            Capsule()
                                                .fill(Color.black)
                                                // Math: (Progress Percentage / 100) * Total Width
                                                .frame(width: geo.size.width * (Double(story.Readingprogress) / 100.0), height: 8)
                                        }
                                    }
                                    .frame(height: 8) // Give the GeometryReader a specific height
                                    .padding(.horizontal, 12)
                                    .padding(.bottom, 15)
                                }
                                .frame(height: 180)
                                .background(Color.white)
                                .cornerRadius(18)
                                , alignment: .top
                            )
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.bottom, 60)
                }
            }
            .padding()
        }
        
        .background(Color.clear)
        // FIX: Moved modifier directly to the ScrollView
        .scrollContentBackground(.hidden)
    }
}
