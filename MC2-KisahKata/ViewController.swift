//
//  ViewController.swift
//  MC2-KisahKata
//
//  Created by Dimas Putro on 17/06/21.
//

import UIKit
import CoreData

class ViewController: UIViewController {
//    @IBOutlet weak var judulLabel: UILabel!
    @IBOutlet weak var haloLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var poinLabel: UILabel!
    @IBOutlet weak var ceritaButton: UIButton!
    
    let judul = "✨KisahKata"
    
    // 1.coredata config
    var kosakatas = [Kosakata]()
    var manageObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // CoreData config
        manageObjectContext = appDelegate?.persistentContainer.viewContext as! NSManagedObjectContext
        
        customComponent()
//        customTitleColor()
        
        // check is data in core data exist?
        checkData()
        
    }
    
//    func customTitleColor () {
//        let atributetext = NSMutableAttributedString(string: judul)
//
//        atributetext.addAttribute(.foregroundColor, value: UIColor.systemBlue, range: NSRange(location: 1, length: 6))
//
//        atributetext.addAttribute(.foregroundColor, value: UIColor.systemOrange, range: NSRange(location: 6, length: 4))
//
//        judulLabel.attributedText = atributetext
//
//    }
    

    func customComponent () {
        poinLabel.textColor = UIColor.white
        poinLabel.backgroundColor = UIColor.blue
        poinLabel.layer.cornerRadius = 10
        poinLabel.layer.masksToBounds = true
        haloLabel.font = UIFont(name: "Baloo2-SemiBold", size: 18)
//        judulLabel.font = UIFont(name: "Baloo2-ExtraBold", size: 22)
        poinLabel.font = UIFont(name: "Baloo2-ExtraBold", size: 14)
        nameLabel.font = UIFont(name: "Baloo2-Regular", size: 32
        )
        
    }
    
    
    // COREDATA CONFIG
    private func _addData() {
        let entity = NSEntityDescription.entity(forEntityName: "Kosakata", in: self.manageObjectContext)
        let newKosakata = NSManagedObject(entity: entity!, insertInto: self.manageObjectContext)
        
        newKosakata.setValue("yatim", forKey: "kata")
        newKosakata.setValue("sifat", forKey: "kategori")
        newKosakata.setValue("", forKey: "urlVideo")
        newKosakata.setValue("Tidak beribu atau tidak berayah lagi", forKey: "deskripsi")
        newKosakata.setValue(0, forKey: "sudahDipelajari")
        newKosakata.setValue("", forKey: "deskripsiVideo")
        
        newKosakata.setValue("memancing", forKey: "kata")
        newKosakata.setValue("kerja", forKey: "kategori")
        newKosakata.setValue("", forKey: "urlVideo")
        newKosakata.setValue("Menangkap ikan dengan pancing", forKey: "deskripsi")
        newKosakata.setValue(0, forKey: "sudahDipelajari")
        newKosakata.setValue("", forKey: "deskripsiVideo")
        
        newKosakata.setValue("kering", forKey: "kata")
        newKosakata.setValue("sifat", forKey: "kategori")
        newKosakata.setValue("", forKey: "urlVideo")
        newKosakata.setValue("Tidak basah; tidak berair;", forKey: "deskripsi")
        newKosakata.setValue(0, forKey: "sudahDipelajari")
        newKosakata.setValue("", forKey: "deskripsiVideo")
        
        newKosakata.setValue("bertani", forKey: "kata")
        newKosakata.setValue("kerja", forKey: "kategori")
        newKosakata.setValue("", forKey: "urlVideo")
        newKosakata.setValue("Bercocok tanam", forKey: "deskripsi")
        newKosakata.setValue(0, forKey: "sudahDipelajari")
        newKosakata.setValue("", forKey: "deskripsiVideo")
        
        do {
            try manageObjectContext.save()
        } catch let error as NSError {
            print("Gagal save, \(error)")
        }
    }
    
    private func _loadData() {
        let kosakataRequest: NSFetchRequest<Kosakata> = Kosakata.fetchRequest()

        let sort = [NSSortDescriptor(key: "kata", ascending: true)]
        kosakataRequest.sortDescriptors = sort

        do {
            try kosakatas = manageObjectContext.fetch(kosakataRequest)
            
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
            
            
            
            
            
            Stories(id: 1, title: "Legenda Danau Toba", coverImage: "", stories: stories[0], storyIlustrations: [], highlightedWords: highlightedWords[0], videoDetail: kosakatas[0].urlVideo ?? "", descriptionDetail: kosakatas[0].deskripsi ?? "")
            
        } catch {
            print("Gagal load data!")
        }
    }
    
    private func checkData() {
        let dataExist: Int = UserDefaults.standard.integer(forKey: "dataExist")

        if dataExist != 1 {
            self._addData()

            UserDefaults.standard.setValue(1, forKey: "dataExist")
            print("data has been dump!")
        } else {
            print("data exist!")
        }
    }
}
