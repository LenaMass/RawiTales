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
                .init(title: "Heart Letter", assetName: "UnforgivableStory"),
                .init(title: "Soft Promise", assetName: "OverthegardenwallStory"),
                .init(title: "Late Coffee", assetName: "LittlewomanStory"),
                .init(title: "Late Coffee", assetName: "BacktothemoonStory"),
                .init(title: "Late Coffee", assetName: "LittlewomanStory")

            ]),
            .init(name: "Mystery", stories: [
                .init(title: "Hidden Door", assetName: "UnforgivableStory"),
                .init(title: "Cold Clue", assetName: "OverthegardenwallStory"),
                .init(title: "Cold Clue", assetName: "BacktothemoonStory"),
                .init(title: "Cold Clue", assetName: "OverthegardenwallStory"),
                .init(title: "Night File", assetName: "LittlewomanStory")
            ]),
            .init(name: "Fantasy", stories: [
                .init(title: "Moon Spell", assetName: "UnforgivableStory"),
                .init(title: "Sky Realm", assetName: "OverthegardenwallStory"),
                .init(title: "Cold Clue", assetName: "BacktothemoonStory"),
                .init(title: "Cold Clue", assetName: "OverthegardenwallStory"),
                .init(title: "Star Keeper", assetName: "LittlewomanStory")
            ])
        ]
    }
}
