import Foundation
import Combine
import SwiftUI

@MainActor
final class PagesViewerViewModel: ObservableObject {
    @Published var selectedTab: Tab = .library
    @Published var path: [NavRoute] = []
    let searchVM = DynamicSearchViewModel()
    
    var canGoBack: Bool { !path.isEmpty }
    
    var currentTitle: String {
        if let last = path.last {
            switch last {
            case .wordsBank:
                return "Words Bank"
            }
        }
        switch selectedTab {
        case .library: return ""
        case .reading: return "Reading"
        case .dictionary: return "Saved Words"
        }
    }
    
    func goBack() {
        guard !path.isEmpty else { return }
        _ = path.popLast()
    }
    
    func push(_ route: NavRoute) {
        path.append(route)
    }
    
    func handleSearch(_ text: String) {
        print("Search:", text)
        
    }
    func openWordsBank() {
        selectedTab = .dictionary
        if path.last != .wordsBank {
            path.append(.wordsBank)
        }
    }
}

