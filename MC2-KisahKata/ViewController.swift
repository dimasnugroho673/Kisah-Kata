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
        let newKosakata2 = NSManagedObject(entity: entity!, insertInto: self.manageObjectContext)
        let newKosakata3 = NSManagedObject(entity: entity!, insertInto: self.manageObjectContext)
        let newKosakata4 = NSManagedObject(entity: entity!, insertInto: self.manageObjectContext)
        let newKosakata5 = NSManagedObject(entity: entity!, insertInto: self.manageObjectContext)
        
        newKosakata.setValue("yatim", forKey: "kata")
        newKosakata.setValue("sifat", forKey: "kategori")
        newKosakata.setValue("https://r3---sn-jcopn2-jb3s.googlevideo.com/videoplayback?expire=1624663800&ei=mBLWYJ_xNe-93LUPnL-luAM&ip=103.87.152.154&id=o-ALax8MmcxVSoigVlBndb5UlmiTRdgyBjLA2jXw3FPKQ0&itag=22&source=youtube&requiressl=yes&mh=YV&mm=31%2C29&mn=sn-jcopn2-jb3s%2Csn-npoe7ned&ms=au%2Crdu&mv=m&mvi=3&pl=23&initcwndbps=261250&vprv=1&mime=video%2Fmp4&ns=sYU07rSELY6zug0zD4WGwqEG&ratebypass=yes&dur=41.145&lmt=1553266888664758&mt=1624641890&fvip=3&fexp=24001373%2C24007246&c=WEB&txp=2216222&n=FtkPdKi35tzM0ZHQ8LqpI&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cvprv%2Cmime%2Cns%2Cratebypass%2Cdur%2Clmt&sig=AOq0QJ8wRQIgHvjXQWQfWImbKoq1xoV7Hiw7OpXMYW53DihJ5a17pv0CIQD1CKxdozR5zrwWzHoLiNZFPpa4K_3T4IA-IOpIguggeA%3D%3D&lsparams=mh%2Cmm%2Cmn%2Cms%2Cmv%2Cmvi%2Cpl%2Cinitcwndbps&lsig=AG3C_xAwRgIhANda1s_apEZGPLr4toTdoX-JICwY5rXVKMPHmElaoSl-AiEA_SeWH98dGDbv059Cikikj4lXuyp9hY3FnPidOqjonag%3D&title=AAA%20Potholes%20video%20ratio%201%201", forKey: "urlVideo")
        newKosakata.setValue("Tidak beribu atau tidak berayah lagi", forKey: "deskripsi")
        newKosakata.setValue(0, forKey: "sudahDipelajari")
        newKosakata.setValue("", forKey: "deskripsiVideo")
        
        newKosakata2.setValue("memancing", forKey: "kata")
        newKosakata2.setValue("kerja", forKey: "kategori")
        newKosakata2.setValue("https://r3---sn-oxuctoxu-n8vl.googlevideo.com/videoplayback?expire=1624663985&ei=URPWYKOqCJyhmgfZtYXAAg&ip=79.111.91.227&id=o-AIg_GVb7t1C9FC5pESVXMOUePg2zMycbr-nvQvqaV5i_&itag=22&source=youtube&requiressl=yes&mh=nr&mm=31%2C26&mn=sn-oxuctoxu-n8vl%2Csn-c0q7lnly&ms=au%2Conr&mv=m&mvi=3&pl=21&initcwndbps=1395000&vprv=1&mime=video%2Fmp4&ns=QioQL0gx9aSIy5SaUGRKpmsG&cnr=14&ratebypass=yes&dur=5.154&lmt=1587239335042012&mt=1624641890&fvip=3&fexp=24001373%2C24007246&c=WEB&txp=6211222&n=uYFUMU9A2UQ8m4EXCWD8F&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cvprv%2Cmime%2Cns%2Ccnr%2Cratebypass%2Cdur%2Clmt&sig=AOq0QJ8wRQIgKko6t82e_Y_x1tlSbBfbuxPvbf7vV9xdACgmVz5oqIMCIQCCmPNi1-_Kw_wO9pLOgqWBgFdSN1UURueeTGfy0TDwIw%3D%3D&lsparams=mh%2Cmm%2Cmn%2Cms%2Cmv%2Cmvi%2Cpl%2Cinitcwndbps&lsig=AG3C_xAwRQIhANs3SGScq6oCSZajDSDKOD4x6fMZgzJWhv-ZUPDHGGSWAiAtsKUMt0-I8Mf5VVvXzYxGWqqp4oAIZa12hU0G8fAkIA%3D%3D&title=1%3A1%20aspect%20ratio%20test%20video", forKey: "urlVideo")
        newKosakata2.setValue("Menangkap ikan dengan pancing", forKey: "deskripsi")
        newKosakata2.setValue(0, forKey: "sudahDipelajari")
        newKosakata2.setValue("", forKey: "deskripsiVideo")
        
        newKosakata3.setValue("kering", forKey: "kata")
        newKosakata3.setValue("sifat", forKey: "kategori")
        newKosakata3.setValue("https://r2---sn-npoeenlk.googlevideo.com/videoplayback?expire=1624664023&ei=dxPWYNztINyK4t4P7rC3uA4&ip=103.158.23.148&id=o-AD0AE8DZBGcRAf4MJdoIywK8MRyrkRPDsAfw5TE1Ir11&itag=22&source=youtube&requiressl=yes&mh=ys&mm=31%2C26&mn=sn-npoeenlk%2Csn-30a7rn7l&ms=au%2Conr&mv=u&mvi=2&pl=24&vprv=1&mime=video%2Fmp4&ns=F_2UHrbYRZyMzCSHdKPTfscG&cnr=14&ratebypass=yes&dur=20.108&lmt=1472114542300110&mt=1624642143&fvip=2&fexp=24001373%2C24007246&beids=9466586&c=WEB&n=Ly-SQa3vhH6hzI057r94O&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cvprv%2Cmime%2Cns%2Ccnr%2Cratebypass%2Cdur%2Clmt&sig=AOq0QJ8wRQIgFu5pwQZyAW3tv03xenlzST0zzF5BA2qRjiLDIUgfaYQCIQDI5m6sa_72BZJeyoQWHDBIE0Qgabzc98vRp9_UERf3Gg%3D%3D&lsparams=mh%2Cmm%2Cmn%2Cms%2Cmv%2Cmvi%2Cpl&lsig=AG3C_xAwRQIgF4S-4bGT7Dr12VxOwQuU9l9a1-QLhn75yTDh87hhO4gCIQCsRW-U9rcFgtx4OomZlMgPbMoer8XaiMNFz6o1lAM8vw%3D%3D&title=HD%201080p%20Free%20Video%20Test%20File%20with%201%3A1%20aspect%20ratio", forKey: "urlVideo")
        newKosakata3.setValue("Tidak basah; tidak berair;", forKey: "deskripsi")
        newKosakata3.setValue(0, forKey: "sudahDipelajari")
        newKosakata3.setValue("", forKey: "deskripsiVideo")
        
        newKosakata4.setValue("bertani", forKey: "kata")
        newKosakata4.setValue("kerja", forKey: "kategori")
        newKosakata4.setValue("https://r4---sn-q4fl6ne7.googlevideo.com/videoplayback?expire=1624664102&ei=xhPWYJCoL_Kaj-8Pht2ZiA4&ip=102.129.153.142&id=o-AG9chOCnfk9B1k5yRZt_l2DUDAM14-DqeVuKsmIAyT7F&itag=22&source=youtube&requiressl=yes&mh=am&mm=31%2C29&mn=sn-q4fl6ne7%2Csn-q4flrner&ms=au%2Crdu&mv=m&mvi=4&pl=25&initcwndbps=726250&vprv=1&mime=video%2Fmp4&ns=VKEBwsLhj1xC5FACJX-gNZ8G&cnr=14&ratebypass=yes&dur=5.131&lmt=1572102153131113&mt=1624642127&fvip=4&fexp=24001373%2C24007246&beids=9466585&c=WEB&txp=2211222&n=etk1qKLEryQf072O88yIX&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cvprv%2Cmime%2Cns%2Ccnr%2Cratebypass%2Cdur%2Clmt&sig=AOq0QJ8wRQIhAJqOLyTU1e0FYglQQHG4Cay3fgWsWDt2OQoE-9RgjWE7AiBfoyPMD3TBo6ktSCeaqi_0yhaMMjpO7THSuHK1MUGaug%3D%3D&lsparams=mh%2Cmm%2Cmn%2Cms%2Cmv%2Cmvi%2Cpl%2Cinitcwndbps&lsig=AG3C_xAwRgIhAJqpOZcpwZ-f7ACf-uQ4DmaUXtq5iR8RGwcppzX3l1YlAiEA9ORpIMzERz6wQbeFPz6tG-3rHVBcI_cBV3EOnXock84%3D&title=square%20aspect%20ratio%201%3A1%20test%20on%20Youtube%20(in%202018%2F2019)", forKey: "urlVideo")
        newKosakata4.setValue("Bercocok tanam", forKey: "deskripsi")
        newKosakata4.setValue(0, forKey: "sudahDipelajari")
        newKosakata4.setValue("", forKey: "deskripsiVideo")
        
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
    
    private func checkData() {
        let dataExist: Int = UserDefaults.standard.integer(forKey: "dataExist")

        if dataExist != 1 {
            self._addData()

            UserDefaults.standard.setValue(1, forKey: "dataExist")
            print("data has been dump!")
        } else {
//            print("data exist!")
        }
    }
}
