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
    
    var body: some Scene {
        WindowGroup {
            PagesViewer()
                .background{
                    Image("NightDay_Background")
                    
                    
                }
                .modelContainer(for: [Story.self, WordBankItem.self])
        }
        
        
        
    }
    
    
}


