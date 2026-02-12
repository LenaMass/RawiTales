/*

import Foundation
import SwiftData
import Combine

@Model
final class SavedStoryData {
    @Attribute(.unique) var id: UUID
    var imageName: String
    var title: String
    var pages: [String]
    var Readingprogress: Int
    var currentPageIndex: Int
    var genre: String        // Added for categorization
    var isFavorite: Bool     // Added for the saved page logic
    
    init(
        id: UUID = UUID(),
        imageName: String,
        title: String = "",
        pages: [String] = [],
        Readingprogress: Int = 0,
        currentPageIndex: Int = 0,
        genre: String = "General",
        isFavorite: Bool = false
    ) {
        self.id = id
        self.imageName = imageName
        self.title = title
        self.pages = pages
        self.Readingprogress = Readingprogress
        self.currentPageIndex = currentPageIndex
        self.genre = genre
        self.isFavorite = isFavorite
    }
}
*/
