import Foundation
import Combine

@MainActor
final class DynamicSearchViewModel: ObservableObject {
    @Published var isSearching: Bool = false
    @Published var query: String = ""

    func begin() { isSearching = true }
    func end() { isSearching = false }
    func setQuery(_ text: String) { query = text }
    func clear() { query = "" }

    func submit(onSubmit: (String) -> Void) {
        onSubmit(query)
        end()
    }

    func title(for tab: Tab) -> String {
        switch tab {
        case .library:
            return "Tales"
        case .reading:
            return "Progress"
        case .dictionary:
            return "Words"
        }
    }
}
