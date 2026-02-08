//
//  Savedstory_view.swift
//  LevelUp_19
//
//  Created by Nuha  on 03/02/2026.
//

import SwiftUI
import Combine
import Foundation


struct Savedstory_view: View {
    
    @StateObject var viewModel = StoryViewModel()
    
    
    // 1. Define 3 equal columns
    let columns = [
        GridItem(.flexible(), spacing: 30),
        GridItem(.flexible(), spacing: 30),
        GridItem(.flexible(), spacing: 30)
    ]
    
    
    var body: some View {
        
        NavigationStack {
            //MARK: - Main VStack
            ZStack{
              
                
                VStack{
                    
                    HStack{
                        // here to add a nvaigation view to see this page
                        /* Button(action: {
                         // Your code here
                         print("Button tapped!")
                         }) {
                         Image(systemName: "arrowshape.left.fill")
                         .buttonBorderShape(.circle)
                         .frame(width: 40, height: 40)
                         .font(.system(size: 40))
                         .glassEffect(.clear)
                         
                         }*/
                        
                        
                        
                        Text("Saved Stories")
                            .font(.largeTitle)
                            .foregroundStyle(Color.white)
                            .bold()
                    }
                    
                    // divider under the page title
                    VStack{
                        Rectangle()
                            .frame(height: 2)
                            .foregroundStyle(Color.white)
                    }
                    
                    //MARK: - VStack that holds the scrollbar of stories
                    
                    VStack{
                        
                        ScrollView {
                                                LazyVGrid(columns: columns, spacing: 10) {
                                                    ForEach(viewModel.allStories) { story in
                                                        // NavigationLink makes the card clickable
                                                        NavigationLink(destination: StoryReaderPage(viewModel: viewModel, story: story)) {
                                                            SavedstorycardsView(story: story) // Use the new small view
                                                        }
                                                        .buttonStyle(PlainButtonStyle())
                                                        .padding(.bottom, 60)
                                                    }
                                                }
                                                .padding()
                                            }
                        
                        
                        
                        
                        
                    }// end of main VStack
                    
                }
                
            }
            
        }
        
        
        
    }
}

    


#Preview {
    Savedstory_view()
}

