//
//  StoryDetailView.swift
//  LevelUp_19
//
//  Created by Nuha  on 08/02/2026.
//

import SwiftUI
import Combine

struct StoryDetailView: View {
    
    @ObservedObject var viewModel: SavedStoryViewModel
    let story: SavedStoryModel
    @State private var currentPage = 0

    var body: some View {
        ZStack {
          
            // TabView makes it a "Side-Swiper" instead of a vertical list
            TabView(selection: $currentPage) {
                ForEach(0..<story.pages.count, id: \.self) { index in
                    VStack (alignment: .leading, spacing: 0){
                        // This pushes the text to the center of the "page"
                        
                        Text(story.pages[index])
                            .font(.system(size: 24, weight: .regular, design: .serif))
                            .foregroundColor(.blue)
                            // 2. Alignment here handles multiple lines of text
                            .multilineTextAlignment(.leading)
                            .lineSpacing(10)
                            .padding(.horizontal, 30)
                            .padding(.top, 50)
                                            
                            // 3. This pushes the text to the top
                            Spacer()
                        
                      
                    }
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .tag(index)
                }
            }
            // This is the magic line for horizontal paging
            .tabViewStyle(.page(indexDisplayMode: .always))
        }
        
        .onChange(of: currentPage) { newValue in
        viewModel.updateReadingProgress(for: story.id, currentPageIndex: newValue)
        }
       
        .navigationTitle(story.imageName)
        .navigationBarTitleDisplayMode(.inline)
    }
}
