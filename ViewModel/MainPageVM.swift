import SwiftUI
import Combine



@MainActor
final class HomePageViewModel: ObservableObject {
    // We only need the names of the categories/genres
    @Published var genreNames: [String] = ["Favorite","Romance", "Mystery", "Fantasy","Wisdom","Comedy"]
    let heroVM: HeroRingWidgetViewModel
    
    init(heroVM: HeroRingWidgetViewModel? = nil) {
        self.heroVM = heroVM ?? .preset
    }
    

}

/*
static var placeholderGenres: [StoryGenre] {
    [
        .init(name: "comdey", stories: [
            .init(title: "You Can Never Please Everyone",cover: "Juha'sSon",progress: 0,currentPage: 0),
//                .init(title: "Juha's Nail",cover: "Juha'sNail",progress: 0,currentPage: 0),
//                .init(title: "Late Coffee", cover: "LittlewomanStory",progress: 0,currentPage: 0),
//                .init(title: "Late Coffee", cover: "BacktothemoonStory",progress: 0,currentPage: 0),
//                .init(title: "Late Coffee", cover: "LittlewomanStory",progress: 0,currentPage: 0)

        ]),
        .init(name: "Mystery", stories: [
            .init(title: "The Mystery of the City of Brass", cover: "cityOfBrass",progress: 0,currentPage: 0),
//                .init(title: "Cold Clue", cover: "OverthegardenwallStory",progress: 0,currentPage: 0),
//                .init(title: "Cold Clue", cover: "BacktothemoonStory",progress: 0,currentPage: 0),
//                .init(title: "Cold Clue", cover: "OverthegardenwallStory",progress: 0,currentPage: 0),
//                .init(title: "Night File", cover: "LittlewomanStory",progress: 0,currentPage: 0)
        ]),
        .init(name: "Wisdom and Pholosophy", stories: [
            .init(title: "Moon Spell", cover: "UnforgivableStory",progress: 0,currentPage: 0),
//                .init(title: "Sky Realm", cover: "OverthegardenwallStory",progress: 0,currentPage: 0),
//                .init(title: "Cold Clue", cover: "BacktothemoonStory",progress: 0,currentPage: 0),
//                .init(title: "Cold Clue", cover: "OverthegardenwallStory",progress: 0,currentPage: 0),
//                .init(title: "Star Keeper", cover: "LittlewomanStory",progress: 0,currentPage: 0)
        ])
    ]
}
*/
