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
    @IBOutlet weak var quizPageControl: UIPageControl!
    
    let allQuestions = QuestionBank()
    var questionNumber: Int = 0
    var score: Int = 0
    var selectedAnswer: Int = 0
    var quiz: Question? = nil
    var activePart: Int = 0
    
    
    // score from story
    var expWordResult: Int = 0

    var expTotal : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("total\(expWordResult)")
        
        

        blurVIew.bounds =  self.view.bounds

        optionA.layer.cornerRadius = 12
        optionA.titleLabel?.font = UIFont(name: "Baloo2-Bold", size: 16)
        optionB.layer.cornerRadius = 12
        optionB.titleLabel?.font = UIFont(name: "Baloo2-Bold", size: 16)
        optionC.layer.cornerRadius = 12
        optionC.titleLabel?.font = UIFont(name: "Baloo2-Bold", size: 16)
        optionD.layer.cornerRadius = 12
        optionD.titleLabel?.font = UIFont(name: "Baloo2-Bold", size: 16)
        
        nextButtonBenar.layer.cornerRadius = 12
        nextButtonSalah.layer.cornerRadius = 12
        
        pertanyaanLabel.font = UIFont(name: "Baloo2-Bold", size: 24)
        
        popupBenarView.bounds = CGRect(x: 0, y: 0, width: self.view.bounds.width * 0.9, height: self.view.bounds.height * 0.4)
        popupBenarView.roundedBorder(cornerRadius: 24)
        
        popupSalahView.bounds = CGRect(x: 0, y: 0, width: self.view.bounds.width * 0.9, height: self.view.bounds.height * 0.45)
        popupSalahView.roundedBorder(cornerRadius: 24)
        
        // Do any additional setup after loading the view.
        
        updateQuestion()
        // Do any additional setup after loading the view.
        
        thumbImage.image = UIImage(named: "img_S_1_1")?.roundedImage
        
        
    }
    
    private func _fetchPageControl(page: Int) {
        quizPageControl.numberOfPages = allQuestions.list.count
        quizPageControl.frame(forAlignmentRect: CGRect(x: 0, y: 0, width: 16, height: 4))
        quizPageControl?.currentPage = Int(page)
    }
    
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        print("Hasil\(score)")
//        if let quizVC = segue.destination as? ScoreViewController {
//            quizVC.quizScore = self.score
//
//        }
//    }
    
    @IBAction func answerPressed(_ sender: UIButton) {
        if sender.tag == selectedAnswer {
            animateScaleIn(desiredView: blurVIew)
            animateScaleIn(desiredView: popupBenarView)
            score += 50
            expTotal = score + expWordResult
//            print("Masuk")



        }else{
            jawabanLabel.text = "Jawaban Benar : \(allQuestions.list[questionNumber].jawabanQuiz)"
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
            _fetchPageControl(page: self.activePart)
        
    }
}
    @IBAction func nextButtonSalah(_ sender: Any) {
        if questionNumber <= allQuestions.list.count - 1{
        animateScaleOut(desiredView: blurVIew)
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
            vc.quizScore = self.score
            let poin = UserDefaults.standard.set(expTotal, forKey: "QuizScore")
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
            
            
//            print("Selesai")
            
            
        }
        
//        print(questionNumber)
//        print(allQuestions.list.count)
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
