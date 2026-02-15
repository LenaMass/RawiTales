
import SwiftUI
import Combine
import SwiftData

// the commneted sections will be used later for the next challenge 


@main
struct LevelUp_19App: App {
    @Environment(\.modelContext) private var modelContext
   // @StateObject private var settings = AppSettings()
    
    var body: some Scene {
        WindowGroup {
            Splashscreen()
            
            
                .background{
                    Image("NightDay_Background")
                }
            
             /*   .environmentObject(settings) // Inject it here
                .preferredColorScheme(settings.appearance == .dark ? .dark : .light)*/
            
                .modelContainer(for: [Story.self, WordBankItem.self])
        }
        
        
        
    }
    
    
}


