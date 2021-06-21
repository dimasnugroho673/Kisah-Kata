//
//  ViewController.swift
//  MC2-KisahKata
//
//  Created by Dimas Putro on 17/06/21.
//

import UIKit

class ViewController: UIViewController {
//    @IBOutlet weak var judulLabel: UILabel!
    @IBOutlet weak var haloLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var poinLabel: UILabel!
    @IBOutlet weak var ceritaButton: UIButton!
    
    let judul = "✨KisahKata"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customComponent()
//        customTitleColor()

        // Do any additional setup after loading the view.
    }
    
//    func customTitleColor () {
//        let atributetext = NSMutableAttributedString(string: judul)
//
//        atributetext.addAttribute(.foregroundColor, value: UIColor.systemBlue, range: NSRange(location: 1, length: 6))
//
//        atributetext.addAttribute(.foregroundColor, value: UIColor.systemOrange, range: NSRange(location: 6, length: 4))
//
//        judulLabel.attributedText = atributetext
//
//    }
    

    func customComponent () {
        poinLabel.textColor = UIColor.white
        poinLabel.backgroundColor = UIColor.blue
        poinLabel.layer.cornerRadius = 10
        poinLabel.layer.masksToBounds = true
        haloLabel.font = UIFont(name: "Baloo2-SemiBold", size: 18)
//        judulLabel.font = UIFont(name: "Baloo2-ExtraBold", size: 22)
        poinLabel.font = UIFont(name: "Baloo2-ExtraBold", size: 14)
        nameLabel.font = UIFont(name: "Baloo2-Regular", size: 32
        )
        
    }
}
