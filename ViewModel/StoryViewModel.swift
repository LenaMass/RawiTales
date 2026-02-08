//
//  StoryViewModel.swift
//  LevelUp_19
//
//  Created by Nuha  on 08/02/2026.
//


import Foundation
import SwiftUI
import Combine

class StoryViewModel: ObservableObject {
    @Published var allStories: [StoryModel] = [
        StoryModel(
            imageName: "LittlewomanStory",
            pages: ["Once upon a time...", "She lived in a small house.", "The end."],
            Readingprogress: 0
        ),
        StoryModel(
            imageName: "SleepingbeautyStory",
            pages: ["The princess fell asleep.", "A hundred years passed.", "The prince arrived."],
            Readingprogress: 0
        ),
        StoryModel(
            imageName: "UnforgivableStory",
            pages: ["It was a dark night.", "Nobody said a word."],
            Readingprogress: 0
        ),
        StoryModel(
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
