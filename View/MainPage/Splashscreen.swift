
import SwiftUI

struct Splashscreen: View {
    
    
    @State private var isTransitionComplete = false
    
    private let splashDuration: TimeInterval = 3.0
    
    var body: some View {
        
        
        VStack {
            Image("RawiTalesSplashscreen")
                .resizable().frame(width: 600,height: 900).scaledToFit()
              
                .ignoresSafeArea()
        
        }
        
           
                .onAppear {
                    // This is optional but good practice to show the splash screen for a few seconds.
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.4) { // Wait for 3 seconds
                        self.isTransitionComplete = true
                    }
                }
        
                .fullScreenCover(isPresented: $isTransitionComplete) {
                    // This will show your main app view after the timer runs out.
                    // Replace `ContentView()` with the name of your main app view.
                    PagesViewer()
                }
        
    }
    
   
}

#Preview {
    Splashscreen()
}
