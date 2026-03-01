import SwiftUI
import Combine
import Foundation
import SwiftData

struct Savedstory_view: View {
    
   // @StateObject var viewModel = SavedStoryViewModel()

    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
              
                Image("NightDay_Background")
                .resizable()
                .ignoresSafeArea()
            
                VStack(spacing: 12) {
                    HStack {
                        Text("Stories Progress")
                            .font(.system(size: 25, weight: .bold, design: .rounded))
                            .foregroundStyle(Color.white)
//                            .bold()
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 10)
                    
                    Rectangle()
                        .fill(Color.white)
                        .frame(height: 1)
                    StoriesScrollbar()
                }
            }
            
            }
        }
        
        
    }

#Preview {
    Savedstory_view()
}

