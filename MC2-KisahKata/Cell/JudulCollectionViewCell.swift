//
//  JudulCollectionViewCell.swift
//  MC2-KisahKata
//
//  Created by Farendza Muda on 19/07/21.
//

import UIKit

class JudulCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var judulLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 14
        // Initialization code
        
        
        
    }

}
