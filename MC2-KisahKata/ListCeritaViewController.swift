//
//  ListCeritaViewController.swift
//  MC2-KisahKata
//
//  Created by Farendza Muda on 23/06/21.
//

import UIKit

class ListCeritaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var cerita = ["Legenda Danau Toba", "Lanj. Legenda Danau Toba", "Petani dan Angsa Bertelur Emas", "Lanj. Petani dan Angsa Bertelur Emas", "Legenda Sangkuriang", "Legenda Loro Jonggrang"]
    var thumbnail = ["Danau Toba.img", "Danau Toba.img", "duck egg.img", "duck egg.img", "Tangkuban Perahu.img", "Candi Prambanan.img"]

    @IBOutlet weak var ceritaTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        ceritaTableView.delegate = self
        ceritaTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 168
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cerita.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ceritaTableView.dequeueReusableCell(withIdentifier: "ceritaCell") as! CeritaTableViewCell
        let story = cerita[indexPath.row]
        let img = thumbnail[indexPath.row]
        
        cell.ceritaLabel.text = story
        cell.ceritaImage.image = UIImage(named: img)
        
//        cell.ceritaView.layer.cornerRadius = cell.ceritaView.frame.height / 2
//        cell.ceritaImage.layer.cornerRadius = cell.ceritaImage.frame.height / 2
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "storyTellingSegue", sender: nil)
    }
    

}
