//
//  QuizViewController.swift
//  MC2-KisahKata
//
//  Created by Mulazi Azi on 26/06/21.
//

import UIKit

class QuizViewController: UIViewController {
    @IBOutlet weak var thumbImage: UIImageView!
    @IBOutlet weak var optionA: UIButton!
    @IBOutlet weak var optionB: UIButton!
    @IBOutlet weak var optionC: UIButton!
    @IBOutlet weak var optionD: UIButton!
    @IBOutlet weak var pertanyaanLabel: UILabel!
    @IBOutlet var popupBenarView: UIView!
    @IBOutlet var blurVIew: UIVisualEffectView!
    @IBOutlet var popupSalahView: UIView!
    @IBOutlet weak var nextButtonBenar: UIButton!
    @IBOutlet weak var nextButtonSalah: UIButton!
    @IBOutlet weak var jawabanLabel: UILabel!
    
    let allQuestions = QuestionBank()
    var questionNumber: Int = 0
    var score: Int = 0
    var selectedAnswer: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        blurVIew.bounds =  self.view.bounds
        
        popupBenarView.bounds = CGRect(x: 0, y: 0, width: self.view.bounds.width * 0.9, height: self.view.bounds.height * 0.4)
        
        popupSalahView.bounds = CGRect(x: 0, y: 0, width: self.view.bounds.width * 0.9, height: self.view.bounds.height * 0.4)
        // Do any additional setup after loading the view.
        
        updateQuestion()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func answerPressed(_ sender: UIButton) {
        if sender.tag == selectedAnswer {
            animateScaleIn(desiredView: blurVIew)
            animateScaleIn(desiredView: popupBenarView)
            score += 50
            print("Masuk")



        }else{
            
            animateScaleIn(desiredView: blurVIew)
            animateScaleIn(desiredView: popupSalahView)
            
        }
        
    }
    
    @IBAction func nextButtonBenar(_ sender: Any) {
        if questionNumber <= allQuestions.list.count - 1{
        animateScaleOut(desiredView: blurVIew)
        animateScaleOut(desiredView: popupBenarView)
        questionNumber += 1
            updateQuestion()
        
    }
}
    @IBAction func nextButtonSalah(_ sender: Any) {
        if questionNumber <= allQuestions.list.count - 1{
        animateScaleOut(desiredView: blurVIew)
        jawabanLabel.text = "Jawaban Benar : \(allQuestions.list[questionNumber].jawabanQuiz)"
        animateScaleOut(desiredView: popupSalahView)
        questionNumber += 1
            updateQuestion()
    }
        
}
    
    func updateQuestion(){
        
        if questionNumber <= allQuestions.list.count - 1{
            thumbImage.image = UIImage(named:(allQuestions.list[questionNumber].questionImage))
//            questionLabel.text = allQuestions.list[questionNumber].question
            optionA.setTitle(allQuestions.list[questionNumber].optionA, for: UIControl.State.normal)
            optionB.setTitle(allQuestions.list[questionNumber].optionB, for: UIControl.State.normal)
            optionC.setTitle(allQuestions.list[questionNumber].optionC, for: UIControl.State.normal)
            optionD.setTitle(allQuestions.list[questionNumber].optionD, for: UIControl.State.normal)
            selectedAnswer = allQuestions.list[questionNumber].correctAnswer
            
            print(selectedAnswer)
//            updateUI()
            
        }
        else {
            let vc = storyboard?.instantiateViewController(identifier: "ScoreViewController") as! ScoreViewController
            let poin = UserDefaults.standard.set(score, forKey: "QuizScore")
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
            print("Selesai")
            
            
        }
        
        print(questionNumber)
        print(allQuestions.list.count)
    }
    
    func animateScaleIn(desiredView: UIView) {
        let backgroundView = self.view!
        backgroundView.addSubview(desiredView)
        desiredView.center = backgroundView.center
        desiredView.isHidden = false
        
        desiredView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        desiredView.alpha = 0
        
        UIView.animate(withDuration: 0.2) {
            desiredView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            desiredView.alpha = 1
            desiredView.transform = CGAffineTransform.identity
        }
    }
    
    /// Animates a view to scale out remove from the display
    func animateScaleOut(desiredView: UIView) {
        UIView.animate(withDuration: 0.2, animations: {
            desiredView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            desiredView.alpha = 0
        }, completion: { (success: Bool) in
            desiredView.removeFromSuperview()
        })
        
        UIView.animate(withDuration: 0.2, animations: {
            
        }, completion: { _ in
            
        })
    }

}
