
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
            
                VStack {
                    HStack {
                        Text("Saved Stories")
                            .font(.system(size: 25, weight: .bold, design: .rounded))
                            .foregroundStyle(Color.white)
//                            .bold()
                    }
                    
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

