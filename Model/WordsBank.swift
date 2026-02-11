import Foundation

struct WordBankItem: Identifiable, Codable, Hashable {
    let id: UUID
    let word: String
    let example: String

    var wordArabic: String?
    var exampleArabic: String?

    let createdAt: Date

    init(
        id: UUID = UUID(),
        word: String,
        example: String,
        wordArabic: String? = nil,
        exampleArabic: String? = nil,
        createdAt: Date = Date()
    ) {
        self.id = id
        self.word = word
        self.example = example
        self.wordArabic = wordArabic
        self.exampleArabic = exampleArabic
        self.createdAt = createdAt
    }
}


