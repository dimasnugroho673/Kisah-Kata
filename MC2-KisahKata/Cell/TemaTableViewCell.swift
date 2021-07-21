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
    @IBOutlet weak var CollectionView: UIView!
    
    weak var cellDelegate: CollectionViewCellDelegate?
    
    var rowList: [JudulModel]?
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let cellNib = UINib(nibName: "JudulCollectionViewCell", bundle: nil)
        self.judulCollectionView.register(cellNib, forCellWithReuseIdentifier: "judulCell")
        
        judulCollectionView.delegate = self
        judulCollectionView.dataSource = self
        judulCollectionView.backgroundColor = UIColor.clear
        
        
        
        
        let flowLayout = UICollectionViewFlowLayout()
//                flowLayout.scrollDirection = .vertical
                
        flowLayout.itemSize = CGSize(width: 330, height: 67)
        flowLayout.minimumLineSpacing = 2.0
        flowLayout.minimumInteritemSpacing = 5.0
        
                
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
        cell.judulLabel.text = self.rowList?[indexPath.row].Judul ?? ""
//        cell.scoreLabel.text = self.rowList?[indexPath.row].Score ?? ""
        return cell
    }
}


