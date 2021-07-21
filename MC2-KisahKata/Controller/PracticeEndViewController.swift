//
//  PracticeEndViewController.swift
//  storySignLanguageTest2
//
//  Created by Dimas Putro on 19/07/21.
//

import UIKit
import AVFoundation

class PracticeEndViewController: UIViewController {

    @IBOutlet weak var imageEggy1: UIImageView!
    @IBOutlet weak var imageEggy2: UIImageView!
    @IBOutlet weak var labelLearningResult: UILabel!
    @IBOutlet weak var viewStarContainer: UIView!
    @IBOutlet weak var labelLearningResultAppreciate: UILabel!
    @IBOutlet weak var buttonClose: UIButton!
    @IBOutlet weak var imageStarPoint: UIImageView!
    
    var expWordResult: Int = 0
    var wordLearned: Int = 0
    var totalAllWordHighlightInStory: Int = 0
    
    var indexStoryReceiver: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Selesai"
        UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
        
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)

        // Do any additional setup after loading the view.
        buttonClose.roundedBorder(cornerRadius: 12)
        viewStarContainer.roundedBorder(cornerRadius: 12)
        
        print("expWordResult : ", expWordResult)
        print("wordLearned : ", wordLearned)
        
        switch expWordResult {
        case 0:
            imageStarPoint.image = UIImage(named: "star_0")
            
        case 10...20:
            imageStarPoint.image = UIImage(named: "star_2")

        case 30...40:
            imageStarPoint.image = UIImage(named: "star_3")

        default:
            print("Mantapp")
        }
        
        // save score
        UserDefaults.standard.set(expWordResult, forKey: "ScoreStory\(indexStoryReceiver)")
        
        // tes get score
//        print("User default scorestory\(indexStoryReceiver) : ", UserDefaults.standard.string(forKey: "ScoreStory\(indexStoryReceiver)") ?? "")
    }
    
    @IBAction func buttonCloseTap(_ sender: Any) {
        // untuk balik ke home tanpa ada tombol back / tanpa pushviewcontroller
        self.navigationController?.popToRootViewController(animated: true)
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
