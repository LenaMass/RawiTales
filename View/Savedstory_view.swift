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

    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                Image("NightDay_Background")
                .resizable()
                .ignoresSafeArea()
            
                VStack {
                    HStack {
                        Text("Saved Stories")
                            .font(.largeTitle)
                            .foregroundStyle(Color.white)
                            .bold()
                    }
                    
                    
                    
                    VStack {
                        Rectangle()
                            .frame(height: 2)
                            .foregroundStyle(Color.white)
                    }
                    
                    // Pass the existing viewModel here
                    StoriesScrollbar(viewModel: viewModel)
                }
            }
            
            }
        }
        
        
    }

#Preview {
    Savedstory_view()
}

