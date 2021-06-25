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
    
    // 1. initializing entity
    var kosakatas = [Kosakata]()
    // 2. initializing managedObjectContext
    var manageObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    private func _addData() {
        let entity = NSEntityDescription.entity(forEntityName: "Kosakata", in: self.manageObjectContext)
        let newKosakata = NSManagedObject(entity: entity!, insertInto: self.manageObjectContext)
        
        newKosakata.setValue("yatim", forKey: "kata")
        newKosakata.setValue("sifat", forKey: "kategori")
        newKosakata.setValue("https://r1---sn-ab5sznlk.googlevideo.com/videoplayback?expire=1624485192&ei=6FjTYLnmLcjIhwa_4JWYCw&ip=209.127.99.130&id=o-ANXh0nsgfR73gVdNezir-j79igfcXVFN80uIQbY-hZ4L&itag=22&source=youtube&requiressl=yes&mh=t9&mm=31%2C29&mn=sn-ab5sznlk%2Csn-ab5l6nsy&ms=au%2Crdu&mv=m&mvi=1&pl=22&initcwndbps=546250&vprv=1&mime=video%2Fmp4&ns=M2e0Ck47Pwgm8vn8NSLIcyQF&cnr=14&ratebypass=yes&dur=3.459&lmt=1617914063885360&mt=1624463332&fvip=1&fexp=24001373%2C24007246&c=WEB&txp=6316222&n=yPtzc0xhWf0qGp98h&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cvprv%2Cmime%2Cns%2Ccnr%2Cratebypass%2Cdur%2Clmt&sig=AOq0QJ8wRgIhAOoLs3g9wZSfyDRkDjjI_ag7U-ZQhyb_2t801hwkuTlmAiEAmRKR46MNBiwyOkIHFgSrHvU8rs77baOy7Tzb7PCsM40%3D&lsparams=mh%2Cmm%2Cmn%2Cms%2Cmv%2Cmvi%2Cpl%2Cinitcwndbps&lsig=AG3C_xAwRAIhAJF-9k26edNRocvJ2wFpeFc3Y8DB8qkOyf5ZHWvRnmmQAh8VyJXBMTU0qKNELg6C914OLfdPKvxfarpqb4KFYfVp&title=This%20Video%20has%201%3A1%20ratio", forKey: "urlVideo")
        newKosakata.setValue("Tidak beribu atau tidak berayah lagi", forKey: "deskripsi")
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
        } catch {
            print("Gagal load data!")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // CoreData config
        manageObjectContext = appDelegate?.persistentContainer.viewContext as! NSManagedObjectContext
        
        
        customComponent()
//        customTitleColor()

        // Do any additional setup after loading the view.
//        self._loadData()
        
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
