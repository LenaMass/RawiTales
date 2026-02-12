

/*
 new issue
 
 1- the progress bar is not saving the progress
 2- must add a function where it stories are added by the genre title and not all genre 
 
 */
/*
import Foundation
import SwiftUI
import Combine
import SwiftData

class SavedStoryViewModel: ObservableObject {
    @Published var allStories: [Story] = [
        SavedStoryData(
            imageName: "LittlewomanStory",
            pages: ["Once upon a time...", "She lived in a small house.", "The end."],
            Readingprogress: 0
        ),
        SavedStoryData(
            imageName: "SleepingbeautyStory",
            pages: ["The princess fell asleep.", "A hundred years passed.", "The prince arrived."],
            Readingprogress: 0
        ),
        SavedStoryData(
            imageName: "UnforgivableStory",
            pages: ["It was a dark night.", "Nobody said a word."],
            Readingprogress: 0
        ),
        SavedStoryData(
            imageName: "CinderellaStory",
            pages: ["Once upon a time...", "there was a girl living with a stepmom and two step sisters", "after the father died, cinderella started havingi a miserable life, her stepmom and sisters would always tease her", "one day, a prince came to visit her and they got married", "and they had a happy life together"],
            Readingprogress: 0
        )
    ]
    
    // Don't forget your update function here too!
    func updateReadingProgress(for storyId: UUID, currentPageIndex: Int) {
        if let index = allStories.firstIndex(where: { $0.id == storyId }) {
            let totalPages = allStories[index].pages.count
            if totalPages > 0 {
                let calculated = Double(currentPageIndex + 1) / Double(totalPages) * 100.0
                allStories[index].Readingprogress = Int(calculated)
            }
        }
    }
}
*/
