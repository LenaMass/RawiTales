import SwiftUI
import Combine

@MainActor
final class HomePageViewModel: ObservableObject {
    @Published var genres: [StoryGenre]
    let heroVM: HeroRingWidgetViewModel

    init(genres: [StoryGenre] = [], heroVM: HeroRingWidgetViewModel? = nil) {
        self.genres = genres.isEmpty ? Self.placeholderGenres : genres
        self.heroVM = heroVM ?? .preset
    }

    static var placeholderGenres: [StoryGenre] {
        [
            .init(name: "Romance", stories: [
                .init(title: "Lavender Night"),
                .init(title: "Back to You"),
                .init(title: "Summer Wish")
            ]),
            .init(name: "Adventure and heroism", stories: [
                .init(title: "The World"),
                .init(title: "Little Demon"),
                .init(title: "Garden Wall")
            ]),
            .init(name: "Wisdom and Philosophy", stories: [
                .init(title: "Still Mind"),
                .init(title: "Golden Hour"),
                .init(title: "Quiet Truth")
            ]),
            .init(name: "Mystery", stories: [
                .init(title: "Hidden Door"),
                .init(title: "Cold Clue"),
                .init(title: "Night File")
            ]),
            .init(name: "Fantasy", stories: [
                .init(title: "Moon Spell"),
                .init(title: "Sky Realm"),
                .init(title: "Star Keeper")
            ])
        ]
    }
}


