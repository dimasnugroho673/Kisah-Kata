//
//  HomeViewController.swift
//  MC2-KisahKata
//
//  Created by Farendza Muda on 19/07/21.
//

import UIKit
import SwiftUI

class HomeViewController: UIViewController {
    
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var temaTableView: UITableView!
    
    var models = Cerita()
    var tappedCell: JudulCollectionViewCell!
    let cellSpacingHeight: CGFloat = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let cellNib = UINib(nibName: "TemaTableViewCell", bundle: nil)
        self.temaTableView.register(cellNib, forCellReuseIdentifier: "temaCell")
        temaTableView.delegate = self
        temaTableView.dataSource = self
        
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
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.destination.isKind(of: StorytellingViewController.self){
//            if let storyVC = segue.destination as? StorytellingViewController {
//                storyVC.indexStory = ceritaTableView.indexPathForSelectedRow!.row
//                storyVC.story = storiesData.list[ceritaTableView.indexPathForSelectedRow!.row]
//            }
//
//        }
//
//    }
}

extension HomeViewController: CollectionViewCellDelegate {
    func collectionView(collectionviewcell: JudulCollectionViewCell?, index: Int, didTappedInTableViewCell: TemaTableViewCell) {
        if let judulsRow = didTappedInTableViewCell.rowList{
//            self.tappedCell = judulsRow[index]
            
            print("delegate active")
            
            
            performSegue(withIdentifier: "toOverviewStorySegue", sender: nil)
        }
    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//            return cellSpacingHeight
//        }
}
