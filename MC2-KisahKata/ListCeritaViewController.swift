//
//  ListCeritaViewController.swift
//  MC2-KisahKata
//
//  Created by Farendza Muda on 23/06/21.
//

import UIKit

class ListCeritaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var cerita = ["Legenda Danau Toba", "Lanj. Legenda Danau Toba", "Petani dan Angsa Bertelur Emas", "Lanj. Petani dan Angsa Bertelur Emas", "Legenda Sangkuriang", "Legenda Loro Jonggrang"]

    @IBOutlet weak var ceritaTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        ceritaTableView.delegate = self
        ceritaTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }


    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cerita.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ceritaTableView.dequeueReusableCell(withIdentifier: "ceritaCell") as! CeritaTableViewCell
        let story = cerita[indexPath.row]
        
        cell.ceritaLabel.text = story
        cell.ceritaImage.image = UIImage(named: story)
        
//        cell.ceritaView.layer.cornerRadius = cell.ceritaView.frame.height / 2
//        cell.ceritaImage.layer.cornerRadius = cell.ceritaImage.frame.height / 2
        
        return cell
    }
    

}
