import Foundation
import SwiftData
import Combine

struct StoriesLibrary {
    static func syncLibrary(in context: ModelContext) {
        let masterList = [
            Story(title: "Layla and Majnun", genre: "Romance", storycover: "storyCover1", isFavorite: true),
            Story(title: "The Fisherman", genre: "Fantasy", storycover: "storyCover2", isFavorite: false)
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
