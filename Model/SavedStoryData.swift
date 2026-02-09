

import Foundation
import SwiftData
import Combine

@Model // This is the magic tag for SwiftData
final class SavedStoryData {
    @Attribute(.unique) var id: UUID // Ensures no duplicate stories
    var imageName: String
    var title: String
    var pages: [String]
    var Readingprogress: Int
    var currentPageIndex: Int
    
    init(id: UUID = UUID(), imageName: String, title: String = "", pages: [String] = [], Readingprogress: Int = 0, currentPageIndex: Int = 0) {
        self.id = id
        self.imageName = imageName
        self.title = title
        self.pages = pages
        self.Readingprogress = Readingprogress
        self.currentPageIndex = currentPageIndex
    }
}
