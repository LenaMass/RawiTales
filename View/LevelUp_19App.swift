//
//  LevelUp_19App.swift
//  LevelUp_19
//
//  Created by Nuha  on 02/02/2026.
//

import SwiftUI
import Combine
import SwiftData


@main
struct LevelUp_19App: App {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var settings = AppSettings()
    
    var body: some Scene {
        WindowGroup {
            PagesViewer()
            
            
                .background{
                    Image("NightDay_Background")
                }
            
                .environmentObject(settings) // Inject it here
                .preferredColorScheme(settings.appearance == .dark ? .dark : .light)
            
                .modelContainer(for: [Story.self, WordBankItem.self])
        }
        
        
        
    }
    
    
}


