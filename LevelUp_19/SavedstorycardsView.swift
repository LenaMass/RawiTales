//
//  SavedstorycardsView.swift
//  LevelUp_19
//
//  Created by Nuha  on 07/02/2026.
//

import SwiftUI

struct SavedstorycardsView: View {

        var story: StoryModel
        
        var body: some View {
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
                            
                            GeometryReader { geo in
                                Capsule()
                                    .fill(Color.black)
                                    .frame(width: geo.size.width * (Double(story.Readingprogress) / 100.0))
                            }
                            .frame(height: 8)
                        }
                        .padding(.horizontal, 12)
                        .padding(.bottom, 15)
                    }
                        .frame(height: 180)
                        .background(Color.white)
                        .cornerRadius(18)
                    , alignment: .top
                )
        }
    }


#Preview {
    let mockVM = StoryViewModel()
        // Make sure 'viewModel' and 'story' match the names in your ReaderPage struct
    StoryReaderPage(viewModel: mockVM, story: mockVM.allStories[0])
}
