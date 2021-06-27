//
//  StoryEndViewController.swift
//  MC2-KisahKata
//
//  Created by Dimas Putro on 26/06/21.
//

import UIKit
import AVFoundation

class StoryEndViewController: UIViewController {

    @IBOutlet weak var wordLearnedLabel: UILabel!
    @IBOutlet weak var expWordLearned: UILabel!
    @IBOutlet weak var startQuizButton: UIButton!
    
    var expWordResult: Int = 0
    var wordLearned: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
        
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        startQuizButton.roundedBorder(cornerRadius: 12)
        
        wordLearnedLabel.text = "\(wordLearned) Kosakata baru dipelajari"
        expWordLearned.text = "+\(expWordResult) exp"
    }
    
    @IBAction func startQuizAction(_ sender: UIButton) {
        self._animateSpringView(sender)
        
        performSegue(withIdentifier: "quizSegue", sender: nil)
    }
    
    
    // PREPARE SEGUE
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let quizVC = segue.destination as? QuizViewController {
            quizVC.expWordResult = self.expWordResult
        }
        
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
