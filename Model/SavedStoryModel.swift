import SwiftUI
import Combine
import Foundation

struct SavedStoryModel: Identifiable {
        let id = UUID()
        let imageName: String
        let pages: [String] // The actual text content
        var Readingprogress: Int // Percentage 0-100
        var currentPageIndex: Int = 0 // Which page the user is currently on
    
    
    
    
}
