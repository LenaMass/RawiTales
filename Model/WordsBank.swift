import SwiftData
import Foundation
import SwiftData

@Model
 final class WordBankItem  {
    @Attribute(.unique) var id: UUID
    var word: String
    var example: String
    var wordArabic: String?
    var exampleArabic: String?
    var createdAt: Date

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

