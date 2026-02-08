//import Foundation
//
//struct Story: Identifiable, Hashable {
//    let id: UUID
//    let title: String
//    let assetName: String?
//
//    init(id: UUID = UUID(), title: String, assetName: String? = nil) {
//        self.id = id
//        self.title = title
//        self.assetName = assetName
//    }
//}

//  storyModle.swift
//  ch5
//
//  Created by Reem Alghamdi on 16/08/1447 AH.
//


import Foundation

struct Story: Identifiable, Hashable {
    let id: UUID
    let title: String
    let cover: String?
    let assets: [String]?
   
    let arabicStory: [String]?
    let englishStory: [String]?
    var progress: Int // Calculates progress based on number of pages read
    var currentPage: Int
    let summary: String?
    
    //let assets: [String]
    init(id: UUID = UUID(), title: String,cover: String? = nil, assets:[String]? = nil, arabicStory: [String]? = nil, englishStory: [String]? = nil, progress: Int, currentPage: Int, summary: String? = nil) {
        self.id = id
        self.title = title
        self.cover = cover
        self.assets = assets
        self.arabicStory = arabicStory
        self.englishStory = englishStory
        self.progress = progress
        self.currentPage = currentPage
        self.summary = summary
    }
}

