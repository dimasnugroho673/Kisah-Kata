//
//  ScoreViewController.swift
//  MC2-KisahKata
//
//  Created by Mulazi Azi on 26/06/21.
//

import UIKit

class ScoreViewController: UIViewController {
    
    let userDefault = UserDefaults()
    var quizScore : Int = 0
    @IBOutlet weak var poinLabel: UILabel!
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var ketLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            poinLabel.text = "Score :\(quizScore)"
            poinLabel.font = UIFont(name: "Baloo2-Bold", size: 24)
            homeButton.layer.cornerRadius =  12
            ketLabel.font = UIFont(name: "Baloo2-Bold", size: 36)
//        print(poinScore)
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
