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
        
            poinLabel.text = "Exp : \(quizScore)"
            poinLabel.font = UIFont(name: "Baloo2-Bold", size: 24)
            homeButton.roundedBorder(cornerRadius: 12)
            ketLabel.font = UIFont(name: "Baloo2-Bold", size: 36)
//        print(poinScore)
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func pressToHome(_ sender: UIButton) {
        
        self._animateSpringView(sender)
        
        let vc = storyboard?.instantiateViewController(identifier: "homeScreen") as! ViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    // file private function
    fileprivate func _animateSpringView(_ viewToAnimate: UIView) {
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
    
            viewToAnimate.transform = CGAffineTransform(scaleX: 0.97, y: 0.97)

        }) { (_) in
            
            UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
                
                viewToAnimate.transform = CGAffineTransform(scaleX: 1, y: 1)
                
            }, completion: nil)
            
        }
        
    }
   
}
