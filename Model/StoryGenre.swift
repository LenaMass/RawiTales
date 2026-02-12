
/*
import Foundation
import SwiftData
import Combine


@Model
final class StoryGenre {
    @Attribute(.unique) var id: UUID
    var name: String
    
    // Relationship: If a Genre is deleted, its stories stay (nullify)
    // or you can use .cascade to delete stories too.
    @Relationship(deleteRule: .nullify, inverse: \Story.genreGroup)
    var stories: [Story]

    init(id: UUID = UUID(), name: String, stories: [Story] = []) {
        self.id = id
        self.name = name
        self.stories = stories
    }
}*/
