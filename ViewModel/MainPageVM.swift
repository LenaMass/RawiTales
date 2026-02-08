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
                .init(title: "Heart Letter",cover: "UnforgivableStory",progress: 0,currentPage: 0),
                .init(title: "Soft Promise",cover: "OverthegardenwallStory",progress: 0,currentPage: 0),
                .init(title: "Late Coffee", cover: "LittlewomanStory",progress: 0,currentPage: 0),
                .init(title: "Late Coffee", cover: "BacktothemoonStory",progress: 0,currentPage: 0),
                .init(title: "Late Coffee", cover: "LittlewomanStory",progress: 0,currentPage: 0)

            ]),
            .init(name: "Mystery", stories: [
                .init(title: "Hidden Door", cover: "UnforgivableStory",progress: 0,currentPage: 0),
                .init(title: "Cold Clue", cover: "OverthegardenwallStory",progress: 0,currentPage: 0),
                .init(title: "Cold Clue", cover: "BacktothemoonStory",progress: 0,currentPage: 0),
                .init(title: "Cold Clue", cover: "OverthegardenwallStory",progress: 0,currentPage: 0),
                .init(title: "Night File", cover: "LittlewomanStory",progress: 0,currentPage: 0)
            ]),
            .init(name: "Fantasy", stories: [
                .init(title: "Moon Spell", cover: "UnforgivableStory",progress: 0,currentPage: 0),
                .init(title: "Sky Realm", cover: "OverthegardenwallStory",progress: 0,currentPage: 0),
                .init(title: "Cold Clue", cover: "BacktothemoonStory",progress: 0,currentPage: 0),
                .init(title: "Cold Clue", cover: "OverthegardenwallStory",progress: 0,currentPage: 0),
                .init(title: "Star Keeper", cover: "LittlewomanStory",progress: 0,currentPage: 0)
            ])
        ]
    }
}
