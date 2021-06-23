//
//  CeritaTableViewCell.swift
//  MC2-KisahKata
//
//  Created by Farendza Muda on 23/06/21.
//

import UIKit

class CeritaTableViewCell: UITableViewCell {

    @IBOutlet weak var ceritaView: UIView!
    @IBOutlet weak var ceritaImage: UIImageView!
    @IBOutlet weak var ceritaLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
