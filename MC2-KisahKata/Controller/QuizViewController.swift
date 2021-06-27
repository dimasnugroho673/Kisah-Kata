//
//  QuizViewController.swift
//  MC2-KisahKata
//
//  Created by Mulazi Azi on 26/06/21.
//

import UIKit
import AVFoundation

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
    
    @IBOutlet weak var videoContainerView: UIView!
    
    
    let allQuestions = QuestionBank()
    var questionNumber: Int = 0
    var score: Int = 0
    var selectedAnswer: Int = 0
    var quiz: Question? = nil
    var activePart: Int = 0
    
    
    // score from story
    var expWordResult: Int = 0

    var expTotal : Int = 0
    
    var playerLayer = AVPlayerLayer()
    
    let playVideoButton = UIButton(frame: CGRect(x: 100, y: 400, width: 200, height: 60))
    
    var imageTemp: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Kuis"
        
        videoContainerView.roundedBorder(cornerRadius: 12)

        blurVIew.bounds =  self.view.bounds

        optionA.roundedBorder(cornerRadius: 12)
        optionA.titleLabel?.font = UIFont(name: "Baloo2-Bold", size: 16)
        optionB.roundedBorder(cornerRadius: 12)
        optionB.titleLabel?.font = UIFont(name: "Baloo2-Bold", size: 16)
        optionC.roundedBorder(cornerRadius: 12)
        optionC.titleLabel?.font = UIFont(name: "Baloo2-Bold", size: 16)
        optionD.roundedBorder(cornerRadius: 12)
        optionD.titleLabel?.font = UIFont(name: "Baloo2-Bold", size: 16)
        
        nextButtonBenar.roundedBorder(cornerRadius: 12)
        nextButtonSalah.roundedBorder(cornerRadius: 12)
        
        pertanyaanLabel.font = UIFont(name: "Baloo2-Bold", size: 18)
        
        popupBenarView.bounds = CGRect(x: 0, y: 0, width: self.view.bounds.width * 0.9, height: self.view.bounds.height * 0.4)
        popupBenarView.roundedBorder(cornerRadius: 24)
        
        popupSalahView.bounds = CGRect(x: 0, y: 0, width: self.view.bounds.width * 0.9, height: self.view.bounds.height * 0.45)
        popupSalahView.roundedBorder(cornerRadius: 24)
        
        // Do any additional setup after loading the view.
        
        updateQuestion()
        // Do any additional setup after loading the view.
        
//        thumbImage.image = UIImage(named: "img_S_1_1")?.roundedImage
        quizPageControl.numberOfPages = allQuestions.list.count
        
        imageTemp = allQuestions.list[questionNumber].questionImage
        
        
    }
    
    private func _fetchPageControl(page: Int) {
       
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
            
            UIImpactFeedbackGenerator(style: .heavy).impactOccurred()

        }else{
            
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
            
            
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
            self.activePart += 1
            
            updateQuestion()
            _fetchPageControl(page: self.activePart)
    }
}
    @IBAction func nextButtonSalah(_ sender: Any) {
        if questionNumber <= allQuestions.list.count - 1{
            animateScaleOut(desiredView: blurVIew)
            animateScaleOut(desiredView: popupSalahView)
            questionNumber += 1
            self.activePart += 1
            
            updateQuestion()
            _fetchPageControl(page: self.activePart)

    }
        
}
    
    
    func updateQuestion(){
        
        
        if questionNumber <= allQuestions.list.count - 1{
            _fetchIlustration(image: allQuestions.list[questionNumber].questionImage)
            
//            thumbImage.image = UIImage(named:(allQuestions.list[questionNumber].questionImage))
            pertanyaanLabel.text = allQuestions.list[questionNumber].question
            optionA.setTitle(allQuestions.list[questionNumber].optionA, for: UIControl.State.normal)
            optionB.setTitle(allQuestions.list[questionNumber].optionB, for: UIControl.State.normal)
            optionC.setTitle(allQuestions.list[questionNumber].optionC, for: UIControl.State.normal)
            optionD.setTitle(allQuestions.list[questionNumber].optionD, for: UIControl.State.normal)
            selectedAnswer = allQuestions.list[questionNumber].correctAnswer
            
            _fetchIlustration(image: allQuestions.list[questionNumber].questionImage)
            
            imageTemp = allQuestions.list[questionNumber].questionImage
            
//            print(selectedAnswer)
//            updateUI()
            
        
            
        }
        else {
            let vc = storyboard?.instantiateViewController(identifier: "ScoreViewController") as! ScoreViewController
            vc.quizScore = self.score
            let poin = UserDefaults.standard.set(expTotal, forKey: "QuizScore")
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
            
            NotificationCenter.default.removeObserver(self)
            
            
//            print("Selesai")
            
            
        }
        
//        print(questionNumber)
//        print(allQuestions.list.count)
    }
    
    private func _fetchIlustration(image: String) {
        
        print("image ilustration", image)
        
        playVideoButton.isHidden = true
        
        /// kalo videonya offline
        let file = image.components(separatedBy: ".")

        guard let filePath = Bundle.main.path(forResource: file[0], ofType:file[1]) else {
              debugPrint( "\(file.joined(separator: ".")) not found")
              return
        }
        
        /// video offline
        let videoURL = URL(fileURLWithPath: filePath)
        
       
        
        let player = AVPlayer(url: videoURL)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.backgroundColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        playerLayer.frame.size.width = videoContainerView.bounds.width
        playerLayer.frame.size.height = videoContainerView.bounds.height
        playerLayer.videoGravity = .resizeAspectFill
        
        playVideoButton.setImage(UIImage(named: "button_play_dark"), for: .normal)
        playVideoButton.tintColor = UIColor.white
        playVideoButton.layer.frame = CGRect(x: videoContainerView.frame.width / 2 - 30, y: videoContainerView.frame.height / 2 - 30, width: 60, height: 60)
        playVideoButton.addTarget(self,
                            action: #selector(buttonAction),
                            for: .touchUpInside)
        playVideoButton.contentHorizontalAlignment = .fill
        playVideoButton.contentVerticalAlignment = .fill
        
        videoContainerView.roundedBorder(cornerRadius: 12)
        videoContainerView.layer.addSublayer(playerLayer)
        videoContainerView.addSubview(playVideoButton)

        NotificationCenter.default.addObserver(self, selector: #selector(videoDidEnd), name:
        NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
        
        player.isMuted = true
        player.play()
        
    }
    
    @objc
    func buttonAction() {
        _fetchIlustration(image: imageTemp)
    }
    
    
    // OBSERVER
    @objc func videoDidEnd(notification: NSNotification) {
        playVideoButton.isHidden = false
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
