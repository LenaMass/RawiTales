//import Foundation
//
//struct Story: Identifiable, Hashable {
//    let id: UUID
//    let title: String
//    let assetName: String?
//
//    init(id: UUID = UUID(), title: String, assetName: String? = nil) {
//        self.id = id
//        self.title = title
//        self.assetName = assetName
//    }
//}



import Combine
import Foundation
import SwiftData

@Model
final class Story: Identifiable {
    @Attribute(.unique) var id: UUID
    var title: String
    var genre: String
    var storycover: String?
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
        self.arabicStory = arabicStory
        self.englishStory = englishStory
        self.Readingprogress = Readingprogress
        self.currentPage = currentPage
        self.summary = summary
        self.isFavorite = isFavorite
    }
}

/*
@Model
final class StoryGenre {
    @Attribute(.unique) var name: String // This prevents duplicate categories
        @Relationship(deleteRule: .nullify, inverse: \Story.genreGroup)
        var stories: [Story] = []

        init(name: String) {
            self.name = name
    }
}
*/















/*


struct Story: Identifiable, Hashable {
    let id: UUID
    let title: String
    let cover: String?
    let assets: [String]?
   
    let arabicStory: [String]?
    let englishStory: [String]?
    var progress: Int // Calculates progress based on number of pages read
    var currentPage: Int
    let summary: String?
    
    // this added
    var pages: [String] {
            return englishStory ?? []
        }
    
    
    //let assets: [String]
    init(id: UUID = UUID(), title: String,cover: String? = nil, assets:[String]? = nil, arabicStory: [String]? = nil, englishStory: [String]? = nil, progress: Int, currentPage: Int, summary: String? = nil) {
        self.id = id
        self.title = title
        self.cover = cover
        self.assets = assets
        self.arabicStory = arabicStory
        self.englishStory = englishStory
        self.progress = progress
        self.currentPage = currentPage
        self.summary = summary
    }
}

*/
