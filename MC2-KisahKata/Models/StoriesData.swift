//
//  StoriesData.swift
//  MC2-KisahKata
//
//  Created by Dimas Putro on 25/06/21.
//

import Foundation
import CoreData
import UIKit

class StoriesData {
    
    let stories: [[String]] = [
                [
                    "Pada zaman dahulu",
                    "hiduplah seorang pemuda tani yatim piatu yang tampan bernama Toba",
                    "di bagian utara pulau Sumatra.",
                    "Daerah tersebut sangatlah kering",
                    "Pemuda itu hidup dari bertani",
                    "dan memancing ikan."
                ],
    ]
    
    let highlightedWords: [[String]] = [
                [
                    "",
                    "yatim",
                    "tampan",
                    "",
                    "kering",
                    "bertani",
                    "memancing"
                ]
    ]
    
    let storyIlustrations: [[String]] = [
        [
            "story_1_1",
            "story_1_2",
            "story_1_3",
            "story_1_4",
            "story_1_5",
            "story_1_6",
        ]
    ]
    
    var kosakatas = [Kosakata]()
    var manageObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    var list = [Stories]()
    
    init() {
        manageObjectContext = appDelegate?.persistentContainer.viewContext as! NSManagedObjectContext
        
        _loadData()
        
        
        list.append(Stories(id: 1, title: "Legenda Danau Toba", coverImage: "cover_image_story_1", stories: stories[0], storyIlustrations: storyIlustrations[0], highlightedWords: highlightedWords[0], videoDetail: kosakatas[0].urlVideo ?? "", descriptionDetail: kosakatas[0].deskripsi ?? ""))
        
        list.append(Stories(id: 2, title: "Lanj. Legenda Danau Toba", coverImage: "cover_image_story_1", stories: stories[0], storyIlustrations: storyIlustrations[0], highlightedWords: highlightedWords[0], videoDetail: kosakatas[0].urlVideo ?? "", descriptionDetail: kosakatas[0].deskripsi ?? ""))
        
        
    }
    
    func _loadData() {
        let kosakataRequest: NSFetchRequest<Kosakata> = Kosakata.fetchRequest()

        let sort = [NSSortDescriptor(key: "kata", ascending: true)]
        kosakataRequest.sortDescriptors = sort

        do {
            try kosakatas = manageObjectContext.fetch(kosakataRequest)
            
        } catch {
            print("Gagal load data!")
        }
    }
    
}


    
