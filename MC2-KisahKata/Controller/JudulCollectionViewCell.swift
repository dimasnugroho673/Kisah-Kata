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
    @IBOutlet weak var numberTitleLabel: UILabel!
    
    @IBOutlet weak var scoreImage: UIImageView!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 14
        // Initialization code
        
        judulLabel.font = UIFont(name: "Baloo2-Bold", size: 16)
        
        
        
    }

}
