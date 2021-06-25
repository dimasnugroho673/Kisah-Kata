//
//  Stories.swift
//  MC2-KisahKata
//
//  Created by Dimas Putro on 24/06/21.
//

import Foundation
import UIKit

class Stories: Identifiable {
    // Properties
    let id: Int
    let title: String
    let coverImage: String
    let stories: [String]
    let storyIlustrations: [String]
    let highlightedWords: [String]
    let videoDetail: String
    let descriptionDetail: String
    
    
    
    init(id: Int, title: String, coverImage: String, stories: [String], storyIlustrations: [String], highlightedWords: [String], videoDetail: String, descriptionDetail: String) {
        self.id = id
        self.title = title
        self.coverImage = coverImage
        self.stories = stories
        self.storyIlustrations = storyIlustrations
        self.highlightedWords = highlightedWords
        self.videoDetail = videoDetail
        self.descriptionDetail = descriptionDetail
        
        
        
        
//        let stories: [[String]] = [
//            [
//                "Pada zaman dahulu",
//                "hiduplah seorang pemuda tani yatim piatu yang tampan bernama Toba",
//                "di bagian utara pulau Sumatra.",
//                "Daerah tersebut sangatlah kering",
//                "Pemuda itu hidup dari bertani",
//                "dan memancing ikan."
//            ],
//        ]
//
//        let highlightedWords: [[String]] = [
//            [
//                "",
//                "yatim",
//                "tampan",
//                "",
//                "kering",
//                "bertani",
//                "memancing"
//            ]
//        ]
//
//
//
//        Stories(id: 1, title: "Legenda Danau Toba", coverImage: "", stories: stories[0], storyIlustrations: [], highlightedWords: highlightedWords[0], videoDetail: [], descriptionDetail: "")
    }
    
    

    
    
    
}
