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
    @IBOutlet weak var judulLabel: UILabel!
    @IBOutlet weak var haloLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var poinLabel: UILabel!
    @IBOutlet weak var ceritaButton: UIButton!
    let userDefault = UserDefaults()
    
    let judul = "✨KisahKata"
    let score : Int = 0
    var expWordResult: Int = 0
    var quizScore : Int = 0
    
    // 1.coredata config
    var kosakatas = [Kosakata]()
    var manageObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // CoreData config
        manageObjectContext = appDelegate?.persistentContainer.viewContext as! NSManagedObjectContext
        
        customComponent()
        customTitleColor()
        
        // check is data in core data exist?
        _checkData()
        _checkUserIsLogged()
        
        nameLabel.text = UserDefaults.standard.string(forKey: "username") ?? ""
        
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        poinLabel.backgroundColor = UIColor(named: "PrimaryColor")
        nameLabel.textColor = UIColor(named: "SecondaryColor")
        
    }
    
    
//     HIDING NAVIGATION BAR
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func customTitleColor () {
        let atributetext = NSMutableAttributedString(string: judul)

        atributetext.addAttribute(.foregroundColor, value: UIColor.systemBlue, range: NSRange(location: 1, length: 6))

        atributetext.addAttribute(.foregroundColor, value: UIColor.systemOrange, range: NSRange(location: 6, length: 4))

        judulLabel.attributedText = atributetext
        

    }
    

    func customComponent () {
        
        if let data = userDefault.object(forKey: "QuizScore") as? Int {
            poinLabel.textColor = UIColor.white
            poinLabel.backgroundColor = UIColor.blue
            poinLabel.layer.cornerRadius = 10
            poinLabel.text = "Poin Terkumpul : \(data) 🔥"
            poinLabel.layer.masksToBounds = true
            haloLabel.font = UIFont(name: "Baloo2-SemiBold", size: 18)
            judulLabel.font = UIFont(name: "Baloo2-ExtraBold", size: 22)
            poinLabel.font = UIFont(name: "Baloo2-ExtraBold", size: 14)
        }
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
        newKosakata.setValue("sibi_yatim.mp4", forKey: "urlVideo")
        newKosakata.setValue("Tidak beribu atau tidak berayah lagi", forKey: "deskripsi")
        newKosakata.setValue(0, forKey: "sudahDipelajari")
        newKosakata.setValue("sibi_penjelasan_yatim.mp4", forKey: "deskripsiVideo")
        
        newKosakata2.setValue("memancing", forKey: "kata")
        newKosakata2.setValue("kerja", forKey: "kategori")
        newKosakata2.setValue("sibi_memancing.mp4", forKey: "urlVideo")
        newKosakata2.setValue("Menangkap ikan dengan pancing", forKey: "deskripsi")
        newKosakata2.setValue(0, forKey: "sudahDipelajari")
        newKosakata2.setValue("sibi_penjelasan_memancing.mp4", forKey: "deskripsiVideo")
        
        newKosakata3.setValue("kering", forKey: "kata")
        newKosakata3.setValue("sifat", forKey: "kategori")
        newKosakata3.setValue("sibi_kering.mp4", forKey: "urlVideo")
        newKosakata3.setValue("Tidak basah; tidak berair;", forKey: "deskripsi")
        newKosakata3.setValue(0, forKey: "sudahDipelajari")
        newKosakata3.setValue("sibi_penjelasan_kering.mp4", forKey: "deskripsiVideo")
        
        newKosakata4.setValue("bertani", forKey: "kata")
        newKosakata4.setValue("kerja", forKey: "kategori")
        newKosakata4.setValue("sibi_bertani.mp4", forKey: "urlVideo")
        newKosakata4.setValue("Bercocok tanam; mengusahakan tanah dengan tanam-menanam;", forKey: "deskripsi")
        newKosakata4.setValue(0, forKey: "sudahDipelajari")
        newKosakata4.setValue("sibi_penjelasan_bertani.mp4", forKey: "deskripsiVideo")
        
        newKosakata5.setValue("tampan", forKey: "kata")
        newKosakata5.setValue("sifat", forKey: "kategori")
        newKosakata5.setValue("sibi_tampan.mp4", forKey: "urlVideo")
        newKosakata5.setValue("Elok (rupanya, sikapnya, bentuknya, letaknya); gagah", forKey: "deskripsi")
        newKosakata5.setValue(0, forKey: "sudahDipelajari")
        newKosakata5.setValue("sibi_penjelasan_tampan.mp4", forKey: "deskripsiVideo")
        
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
    
    private func _checkData() {
        let dataExist: Int = UserDefaults.standard.integer(forKey: "dataExist")

        if dataExist != 1 {
            self._addData()

            UserDefaults.standard.setValue(1, forKey: "dataExist")
            print("data has been dump!")
        } else {
//            print("data exist!")
        }
    }
    
    private func _checkUserIsLogged() {
        let username: String = UserDefaults.standard.string(forKey: "username") ?? ""
        
        if username == "" {
            let controller = storyboard?.instantiateViewController(withIdentifier: "loginScreen") as! IntroViewController
            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .coverVertical
            present(controller, animated: true, completion: nil)
        }
    }
}
