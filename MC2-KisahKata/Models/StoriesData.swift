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
            // cerita 1
            "Selamat pagi, semuanya.",
            "Saya ingin memperkenalkan diri, nama saya M-Eggy.",
            "Tapi kalian bisa panggil saya Megi.",
            "Saya anak kedua dari tiga bersaudara.",
            "Umur saya 9 tahun. Saya lahir di Batam, 23 Februari 2012."
        ],
        [
            // cerita 2
            "Hobi saya yaitu olahraga. Olahraga kesukaan saya yaitu sepak bola. Pemain sepak bola favorite saya yaitu Christian Ronaldo. Saya senang bermain sepak bola bersama teman-teman.",
        ],
        [
            // cerita 3
            "Saya mempunyai cita-cita yaitu ingin menjadi pemain sepak bola yang membanggakan Indonesia.",
        ]
    ]
    
    let highlightedWords: [[String]] = [
        [
            "Selamat pagi,",
            "memperkenalkan",
            "panggil",
            "bersaudara",
        ],
        [
            "olahraga",
            "bermain",
        ],
        [
            "cita-cita",
            "membanggakan",
        ]
        
    ]
    
    let storyIlustrations: [[String]] = [
        [
            "story_1_1",
            "story_1_2",
            "story_1_3",
            "story_1_4",
            "story_1_5",
        ],
        [],
        [],
    ]
    
    var kosakatas = [Kosakata]()
    var manageObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    var list = [Stories]()
    
    init() {
        manageObjectContext = appDelegate?.persistentContainer.viewContext as! NSManagedObjectContext
        
        self._loadData()
        
        
        list.append(Stories(id: 1, title: "Salam Kenal", coverImage: "", stories: stories[0], storyIlustrations: storyIlustrations[0], highlightedWords: highlightedWords[0], videoDetail: kosakatas[0].urlVideo ?? "", descriptionDetail: kosakatas[0].deskripsi ?? ""))
        
        list.append(Stories(id: 2, title: "Hobi", coverImage: "", stories: stories[1], storyIlustrations: storyIlustrations[1], highlightedWords: highlightedWords[1], videoDetail: kosakatas[1].urlVideo ?? "", descriptionDetail: kosakatas[1].deskripsi ?? ""))
        
        list.append(Stories(id: 3, title: "Cita-cita", coverImage: "", stories: stories[2], storyIlustrations: storyIlustrations[2], highlightedWords: highlightedWords[2], videoDetail: kosakatas[2].urlVideo ?? "", descriptionDetail: kosakatas[2].deskripsi ?? ""))
        
        
    }
    
    private func _loadData() {
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


    
