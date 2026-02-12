import SwiftUI
import Combine



@MainActor
final class HomePageViewModel: ObservableObject {
    // We only need the names of the categories/genres
    @Published var genreNames: [String] = ["Romance", "Mystery", "Fantasy"]
    let heroVM: HeroRingWidgetViewModel
    
    init(heroVM: HeroRingWidgetViewModel? = nil) {
        self.heroVM = heroVM ?? .preset
    }
}
