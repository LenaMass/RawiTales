
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
                            .font(.title2)
                            .foregroundStyle(Color.white)
                            .bold()
                    }
                    
              Divider()
                .background(Color.white)
                    StoriesScrollbar()
                }
            }
            
            }
        }
        
        
    }

#Preview {
    Savedstory_view()
}

