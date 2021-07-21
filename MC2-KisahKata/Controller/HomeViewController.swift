//
//  HomeViewController.swift
//  MC2-KisahKata
//
//  Created by Farendza Muda on 19/07/21.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {
    
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var temaTableView: UITableView!
    
    var models = Cerita()
    var tappedCell: JudulCollectionViewCell!
    let cellSpacingHeight: CGFloat = 20
    
    var indexCellTap: Int = 0
    
    // 1.coredata config
    var kosakatas = [Kosakata]()
    var manageObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // CoreData config
        manageObjectContext = appDelegate?.persistentContainer.viewContext as! NSManagedObjectContext
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        // check is data in core data exist?
        _checkData()
        _checkUserIsLogged()

        // Do any additional setup after loading the view.
        let cellNib = UINib(nibName: "TemaTableViewCell", bundle: nil)
        self.temaTableView.register(cellNib, forCellReuseIdentifier: "temaCell")
        temaTableView.delegate = self
        temaTableView.dataSource = self
        temaTableView.separatorStyle = .none
        
    }
    
    // COREDATA CONFIG
    private func _addData() {
        let entity = NSEntityDescription.entity(forEntityName: "Kosakata", in: self.manageObjectContext)
        let newKosakata = NSManagedObject(entity: entity!, insertInto: self.manageObjectContext)
        let newKosakata2 = NSManagedObject(entity: entity!, insertInto: self.manageObjectContext)
        let newKosakata3 = NSManagedObject(entity: entity!, insertInto: self.manageObjectContext)
        let newKosakata4 = NSManagedObject(entity: entity!, insertInto: self.manageObjectContext)
        let newKosakata5 = NSManagedObject(entity: entity!, insertInto: self.manageObjectContext)
        let newKosakata6 = NSManagedObject(entity: entity!, insertInto: self.manageObjectContext)
        let newKosakata7 = NSManagedObject(entity: entity!, insertInto: self.manageObjectContext)
        let newKosakata8 = NSManagedObject(entity: entity!, insertInto: self.manageObjectContext)
        
        newKosakata.setValue("Selamat pagi", forKey: "kata")
        newKosakata.setValue("kerja", forKey: "kategori")
        newKosakata.setValue("sibi_selamatpagi.mp4", forKey: "urlVideo")
        newKosakata.setValue("Mudah-mudahan selamat pada pagi hari (ini)", forKey: "deskripsi")
        newKosakata.setValue(0, forKey: "sudahDipelajari")
        newKosakata.setValue("", forKey: "deskripsiVideo")
        
        newKosakata2.setValue("memperkenalkan", forKey: "kata")
        newKosakata2.setValue("kerja", forKey: "kategori")
        newKosakata2.setValue("sibi_memperkenalkan.mp4", forKey: "urlVideo")
        newKosakata2.setValue("Memberitahukan (nama dan sebagainya) supaya saling ", forKey: "deskripsi")
        newKosakata2.setValue(0, forKey: "sudahDipelajari")
        newKosakata2.setValue("", forKey: "deskripsiVideo")
        
        newKosakata3.setValue("panggil", forKey: "kata")
        newKosakata3.setValue("kerja", forKey: "kategori")
        newKosakata3.setValue("sibi_panggil.mp4", forKey: "urlVideo")
        newKosakata3.setValue("Mengajak (meminta) datang (kembali, mendekat, dan sebagainya)", forKey: "deskripsi")
        newKosakata3.setValue(0, forKey: "sudahDipelajari")
        newKosakata3.setValue("", forKey: "deskripsiVideo")
        
        newKosakata4.setValue("bersaudara", forKey: "kata")
        newKosakata4.setValue("sifat", forKey: "kategori")
        newKosakata4.setValue("sibi_bersaudara.mp4", forKey: "urlVideo")
        newKosakata4.setValue("Mempunyai saudara", forKey: "deskripsi")
        newKosakata4.setValue(0, forKey: "sudahDipelajari")
        newKosakata4.setValue("", forKey: "deskripsiVideo")
        
        newKosakata5.setValue("olahraga", forKey: "kata")
        newKosakata5.setValue("kerja", forKey: "kategori")
        newKosakata5.setValue("sibi_olahraga.mp4", forKey: "urlVideo")
        newKosakata5.setValue("Gerak badan untuk menguatkan dan menyehatkan tubuh (seperti sepak bola, berenang, lempar lembing)", forKey: "deskripsi")
        newKosakata5.setValue(0, forKey: "sudahDipelajari")
        newKosakata5.setValue("", forKey: "deskripsiVideo")
        
        newKosakata6.setValue("bermain", forKey: "kata")
        newKosakata6.setValue("kerja", forKey: "kategori")
        newKosakata6.setValue("sibi_bermain.mp4", forKey: "urlVideo")
        newKosakata6.setValue("Melakukan sesuatu untuk bersenang-senang", forKey: "deskripsi")
        newKosakata6.setValue(0, forKey: "sudahDipelajari")
        newKosakata6.setValue("", forKey: "deskripsiVideo")

        newKosakata7.setValue("cita-cita", forKey: "kata")
        newKosakata7.setValue("kerja", forKey: "kategori")
        newKosakata7.setValue("sibi_cita-cita.mp4", forKey: "urlVideo")
        newKosakata7.setValue("Keinginan (kehendak) yang selalu ada di dalam pikiran | tujuan yang sempurna (yang akan dicapai atau dilaksanakan)", forKey: "deskripsi")
        newKosakata7.setValue(0, forKey: "sudahDipelajari")
        newKosakata7.setValue("", forKey: "deskripsiVideo")
        
        newKosakata8.setValue("membangakan", forKey: "kata")
        newKosakata8.setValue("sifat", forKey: "kategori")
        newKosakata8.setValue("sibi_membanggakan.mp4", forKey: "urlVideo")
        newKosakata8.setValue("Menimbulkan perasaan bangga", forKey: "deskripsi")
        newKosakata8.setValue(0, forKey: "sudahDipelajari")
        newKosakata8.setValue("", forKey: "deskripsiVideo")
        
        do {
            try manageObjectContext.save()
            
            print("data has been dump!")
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
        } else {
//            self._loadData()
            
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
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.objectArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 389
    }

    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = temaTableView.dequeueReusableCell(withIdentifier: "temaCell", for: indexPath)as! TemaTableViewCell
        
        
        
        let urutan = models.objectArray[indexPath.row].Urutan
        cell.urutanLabel.text = urutan
        let tema = models.objectArray[indexPath.row].Tema
        cell.temaLabel.text = tema
        let img = models.objectArray[indexPath.row].ImageTema
        cell.temaImage.image = UIImage(named: img)
        let dataJudul = models.objectArray[indexPath.row].ListJudul
        cell.updateCell(row: dataJudul)
        
        cell.cellDelegate = self
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination.isKind(of: StoryOverviewViewController.self){
            if let storyOverviewVC = segue.destination as? StoryOverviewViewController {
//                storyOverviewVC.indexStory = ceritaTableView.indexPathForSelectedRow!.row
                
                storyOverviewVC.indexStoryReceiver = self.indexCellTap
            }

        }

    }
}

extension HomeViewController: CollectionViewCellDelegate {
    func collectionView(collectionviewcell: JudulCollectionViewCell?, index: Int, didTappedInTableViewCell: TemaTableViewCell) {
        if let judulsRow = didTappedInTableViewCell.rowList{
            
            self.indexCellTap = index
            print("tapped cell", index)
            
            
            performSegue(withIdentifier: "toOverviewStorySegue", sender: nil)
        }
    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//            return cellSpacingHeight
//        }
}
