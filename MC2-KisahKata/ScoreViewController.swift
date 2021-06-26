//
//  ScoreViewController.swift
//  MC2-KisahKata
//
//  Created by Mulazi Azi on 26/06/21.
//

import UIKit

class ScoreViewController: UIViewController {
    
    let userDefault = UserDefaults()
    var poinScore = Int()
    @IBOutlet weak var poinLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let data = userDefault.object(forKey: "QuizScore") as? Int {
            
        poinScore = data
        print(poinScore)
        poinLabel.text = "Score :\(poinScore)"
//        print(poinScore)
        }
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
