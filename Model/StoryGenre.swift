import Foundation

struct StoryGenre: Identifiable, Hashable {
    let id: UUID
    let name: String
    let stories: [Story]

    init(id: UUID = UUID(), name: String, stories: [Story]) {
        self.id = id
        self.name = name
        self.stories = stories
    }
}


