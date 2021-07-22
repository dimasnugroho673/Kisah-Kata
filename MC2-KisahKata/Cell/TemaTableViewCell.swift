//
//  TemaTableViewCell.swift
//  MC2-KisahKata
//
//  Created by Farendza Muda on 19/07/21.
//

import UIKit

protocol CollectionViewCellDelegate: class {
    func collectionView(collectionviewcell: JudulCollectionViewCell?, index: Int, didTappedInTableViewCell: TemaTableViewCell)
}

class TemaTableViewCell: UITableViewCell {
    @IBOutlet weak var urutanLabel: UILabel!
    @IBOutlet weak var temaLabel: UILabel!
    @IBOutlet weak var temaImage: UIImageView!
    @IBOutlet weak var judulCollectionView: UICollectionView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var ContentView: UIView!
    
    weak var cellDelegate: CollectionViewCellDelegate?
    
    var rowList: [JudulModel]?
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let cellNib = UINib(nibName: "JudulCollectionViewCell", bundle: nil)
        self.judulCollectionView.register(cellNib, forCellWithReuseIdentifier: "judulCell")
        
        bgView.layer.cornerRadius = 20
        
        judulCollectionView.delegate = self
        judulCollectionView.dataSource = self
        judulCollectionView.backgroundColor = UIColor.clear
        ContentView.backgroundColor =  UIColor.clear
        
        
        
        
        let flowLayout = UICollectionViewFlowLayout()
//                flowLayout.scrollDirection = .vertical
                
        flowLayout.itemSize = CGSize(width: 330, height: 67)
        flowLayout.minimumLineSpacing = 10.0
        flowLayout.minimumInteritemSpacing = 20.0
        
                
                self.judulCollectionView.collectionViewLayout = flowLayout
                self.judulCollectionView.showsVerticalScrollIndicator = false
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
}

extension TemaTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func updateCell(row: [JudulModel]){
        self.rowList = row
        self.judulCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)as! JudulCollectionViewCell
//        if indexPath.row < 1 {
//            print("item select")
//        } else {
//            var dialogMessage = UIAlertController(title: "Cerita masih terkunci", message: "Cerita masih terkunci, kamu harus menyelesaikan cerita sebelumnya untuk membuka cerita ini", preferredStyle: .alert)
//        }
        
        
        print("I'm tapping the \(indexPath.item)")
        self.cellDelegate?.collectionView(collectionviewcell: cell, index: indexPath.item, didTappedInTableViewCell: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.rowList?.count ?? 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "judulCell", for: indexPath)as! JudulCollectionViewCell
        cell.judulLabel.text = self.rowList?[indexPath.item].Judul ?? ""
        
        let scoreStory: Int = Int(UserDefaults.standard.string(forKey: "ScoreStory\(indexPath)") ?? "") ?? 0
        
        switch scoreStory {
        case 0:
            cell.scoreImage.image = UIImage(named: "star_0")
            
        case 10...20:
            cell.scoreImage.image = UIImage(named: "star_2")

        case 30...40:
            cell.scoreImage.image = UIImage(named: "star_3")

        default:
            print("Mantapp")
        }
//        cell.scoreLabel.text = self.rowList?[indexPath.row].Score ?? ""
        return cell
    }
}


