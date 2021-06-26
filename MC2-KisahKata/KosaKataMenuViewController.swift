//
//  KosaKataMenuViewController.swift
//  MC2-KisahKata
//
//  Created by Farendza Muda on 26/06/21.
//

import UIKit

class KosaKataMenuViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var dataKosaKata = [KosaKata]()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collectionView.dataSource = self
        collectionView.delegate = self
        
        initDataKosakata()
    }
    
    func initDataKosakata(){
        let angka = KosaKata(title: "Angka", imageName: "angka")
        let huruf = KosaKata(title: "Huruf", imageName: "huruf")
        let katabenda = KosaKata(title: "Kata Benda", imageName: "katabenda")
        let katasifat = KosaKata(title: "kata Sifat", imageName: "katasifat")
        let katakerja = KosaKata(title: "Kata Kerja", imageName: "katakerja")
        
        dataKosaKata.append(angka)
        dataKosaKata.append(huruf)
        dataKosaKata.append(katabenda)
        dataKosaKata.append(katasifat)
        dataKosaKata.append(katakerja)
        
        collectionView.reloadData()
    }

}

extension KosaKataMenuViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataKosaKata.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "viewCellKosaKataMenu", for: indexPath)as! KosaKataMenuCollectionViewCell
        
        let kosakata = dataKosaKata[indexPath.row]
        cell.KosaKataImage.image = UIImage (named: kosakata.imageName!)
        cell.KosaKataLabel.text = kosakata.title
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 120)
    }
    
    
}
