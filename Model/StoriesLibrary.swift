import Foundation
import SwiftData
import Combine

struct StoriesLibrary {
    static func syncLibrary(in context: ModelContext) {
        let masterList = [
            Story(title: "Layla and Majnun", genre: "Romance", storycover: "storyCover1",pages: [
                "Long ago in the Arabian desert, Qays fell in love with Layla...",
                "Their love was so intense that Qays became known as Majnun...",
                "Despite their devotion, their families kept them apart."
            ], isFavorite: true),
            Story(title: "The Fisherman", genre: "Fantasy", storycover: "storyCover2",pages: [
                "The fisherman cast his net into the deep blue sea...",
                "Suddenly, he felt a heavy pull and saw a shimmering light...",
                "Inside the net lay a pearl larger than any he had ever seen."
            ], isFavorite: false)
        ]
        
        for item in masterList {
            // 1. Get the cover string from the item to use in the search
            // We use storycover because your Story model uses that name, not imageName
            guard let coverToSearch = item.storycover else { continue }
            
            // 2. Fix the Predicate: It must compare the DB property ($0.storycover)
            // to the local variable (coverToSearch)
            let descriptor = FetchDescriptor<Story>(predicate: #Predicate { $0.storycover == coverToSearch })
            
            let existing = try? context.fetch(descriptor)
            
            // 3. If no story with that cover exists, insert it
            if existing?.isEmpty ?? true {
                context.insert(item)
            }
        }
    }
}
