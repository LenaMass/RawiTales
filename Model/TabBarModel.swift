import Foundation

enum Tab: CaseIterable, Hashable {
    case library, reading, dictionary

    var icon: String {
        switch self {
        case .library: return "books.vertical"
        case .reading: return "apple.books.pages"
        case .dictionary: return "character.book.closed"
        }
    }

    var filledIcon: String {
        switch self {
        case .library: return "books.vertical.fill"
        case .reading: return "apple.books.pages.fill"
        case .dictionary: return "character.book.closed.fill"
        }
    }
}
