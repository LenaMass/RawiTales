import Combine
import Foundation
import SwiftData

@Model
final class Story: Identifiable {
    @Attribute(.unique) var id: UUID
    var title: String
    var genre: String
    var storycover: String?
    var pages: [String]
    var arabicStory: [String]?
    var englishStory: [String]?
    var Readingprogress: Int
    var currentPage: Int
    var summary: String?
    var isFavorite: Bool
    
    init(
        id: UUID = UUID(),
        title: String,
        genre: String = "General",
        storycover: String? = nil,
        pages: [String] = [],
        arabicStory: [String]? = nil,
        englishStory: [String]? = nil,
        Readingprogress: Int = 0,
        currentPage: Int = 0,
        summary: String? = nil,
        isFavorite: Bool = false
    ) {
        self.id = id
        self.title = title
        self.genre = genre
        self.storycover = storycover
        self.pages = pages
        self.arabicStory = arabicStory
        self.englishStory = englishStory
        self.Readingprogress = Readingprogress
        self.currentPage = currentPage
        self.summary = summary
        self.isFavorite = isFavorite
    }
}













