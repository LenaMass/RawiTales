import Foundation

struct Story: Identifiable, Hashable {
    let id: UUID
    let title: String
    let assetName: String?

    init(id: UUID = UUID(), title: String, assetName: String? = nil) {
        self.id = id
        self.title = title
        self.assetName = assetName
    }
}


