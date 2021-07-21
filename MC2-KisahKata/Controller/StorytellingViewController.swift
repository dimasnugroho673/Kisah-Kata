//
//  StorytellingViewController.swift
//  MC2-KisahKata
//
//  Created by Dimas Putro on 24/06/21.
//

import UIKit
import CoreData
import ActiveLabel
import AVFoundation

class StorytellingViewController: UIViewController {
    
    var activePart: Int = 0
    var wordTemp: String = ""
    
    let scriptStory = ActiveLabel()

    var indexStoryReceiver: Int = 0
    
    var story: Stories? = nil
    var indexStory: Int = 0
    
    @IBOutlet weak var storyPageControl: UIPageControl!
    @IBOutlet weak var ilustrationStoryImage: UIImageView!
    
//    @IBOutlet weak var prevButton: UIButton!
//    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var detailPopUpView: UIView!
    @IBOutlet weak var blurDetailPopUpView: UIView!
    
    
    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet weak var viewHintBgBlur: UIVisualEffectView!
    @IBOutlet weak var videoContainerView: UIView!
    @IBOutlet weak var labelTtitleHint: UILabel!
    @IBOutlet weak var textviewDescriptionSignLanguage: UITextView!
    @IBOutlet weak var buttonCloseHint: UIButton!
    
    var playerLayer = AVPlayerLayer()
    
    let playVideoButton = UIButton(frame: CGRect(x: 100, y: 400, width: 200, height: 60))
    
//    var tempPoint: Int
//    var wordClickedCounter: Int
    
    var wordClicked: Set<String> = []
    
    private let nextFloatingButton: UIButton = {
        let button = UIButton()
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 30
        button.backgroundColor = UIColor.init(named: "buttonColorBlue")
        
        
        let image = UIImage(systemName: "arrow.right.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32, weight: .medium))
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let prevFloatingButton: UIButton = {
        let button = UIButton()
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 30
        button.backgroundColor = .white
        
        
        let image = UIImage(systemName: "arrow.backward.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32, weight: .medium))
        button.setImage(image, for: .normal)
        button.tintColor = .gray
        button.setTitleColor(.gray, for: .normal)
        return button
    }()
    
    
    var kosakatas = [Kosakata]()
    var manageObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manageObjectContext = appDelegate?.persistentContainer.viewContext as! NSManagedObjectContext
        
        self.title = story!.title
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        _generateContent()
        
        videoContainerView.roundedBorder(cornerRadius: 12)
        
        backgroundView.roundedBorder(cornerRadius: 24)
        view.addSubview(nextFloatingButton)
        view.addSubview(prevFloatingButton)
        nextFloatingButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        prevFloatingButton.addTarget(self, action: #selector(didTapPrevButton), for: .touchUpInside)
        
        
        // set blur width to bounds
        viewHintBgBlur.bounds = self.view.bounds
        viewHintBgBlur.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        
        buttonCloseHint.roundedBorder(cornerRadius: 12)
        buttonCloseHint.semanticContentAttribute = .forceRightToLeft
        buttonCloseHint.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        
        videoContainerView.roundedBorder(cornerRadius: 12)
            
    }
    
    override func viewDidLayoutSubviews() {
        if self.activePart == 0 {
            self.nextFloatingButton.frame = CGRect(x: self.view.frame.size.width / 2 - 30 , y: self.view.frame.size.height - 100, width: 60, height: 60)
            UIButton.animate(withDuration: 1.0, animations: {
                self.nextFloatingButton.frame = CGRect(x: self.view.frame.size.width / 2 - 30 , y: self.view.frame.size.height - 100, width: 60, height: 60)
                self.prevFloatingButton.frame = CGRect(x: self.view.frame.size.width / 2 - 30 , y: self.view.frame.size.height - 100, width: 60, height: 60)
                self.prevFloatingButton.isHidden = true
            })
            
        } else {
            prevFloatingButton.isHidden = false
            UIButton.animate(withDuration: 1.0, animations: {
                self.nextFloatingButton.frame = CGRect(x: self.view.frame.size.width / 2 + 20, y: self.view.frame.size.height - 100, width: 60, height: 60)
                self.prevFloatingButton.frame = CGRect(x: self.view.frame.size.width / 2 - 80 , y: self.view.frame.size.height - 100, width: 60, height: 60)
                
            })
            
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func _generateContent() {
        _fetchPageControl(page: self.activePart)
        _fetchIlustration()
        _fetchScriptStory()
        _fetchButton()

    }
    
    private func _fetchIlustration() {
        if story!.storyIlustrations[indexStory].hasPrefix("story") {
            ilustrationStoryImage.image = UIImage(named: story!.storyIlustrations[self.activePart])
            ilustrationStoryImage.layer.cornerRadius = 12
            ilustrationStoryImage.contentMode = .scaleAspectFill
        } else if story!.storyIlustrations[indexStory].hasPrefix("gif") {
            ilustrationStoryImage.image = UIImage.gifImageWithName(story!.storyIlustrations[self.activePart])
            ilustrationStoryImage.layer.cornerRadius = 24
            ilustrationStoryImage.animationRepeatCount = 1
        }
    }
    
    private func _fetchScriptStory() {
        
        // asign word highlighted
        for word in story!.highlightedWords {
            scriptStory.enabledTypes.append(ActiveType.custom(pattern: "\\s\(word)\\b"))
        }
        
        scriptStory.customize{ label in
            label.numberOfLines = 0
            label.lineSpacing = 4
            label.textColor = UIColor(red: 102.0/255, green: 117.0/255, blue: 127.0/255, alpha: 1)
            
            for word in story!.highlightedWords {
                label.customColor[ActiveType.custom(pattern: "\\s\(word)\\b")] = UIColor.systemBlue
                label.customSelectedColor[ActiveType.custom(pattern: "\\s\(word)\\b")] = UIColor.gray
                
                // handle tapped word
                label.handleCustomTap(for: ActiveType.custom(pattern: "\\s\(word)\\b")) {
                    self._openPopUpDescription($0)
                }
                
                label.configureLinkAttribute = { (type, attributes, isSelected) in
                    var atts = attributes
                    switch type {
                    case ActiveType.custom(pattern: "\\s\(word)\\b"):
                        atts[NSAttributedString.Key.font] = UIFont(name: "Baloo2-Medium", size: 17)
//                        atts[NSAttributedString.Key.underlineStyle] =
//                        NSAttributedString(string: word, attributes:
//                            [.underlineStyle: NSUnderlineStyle.single.rawValue]
                    default: ()
                        
                    }
                    
                    return atts
                }
            }
            
        }
        
        scriptStory.frame = CGRect(x: 40, y: 380, width: view.frame.width - 60, height: 270)
        
        // text showing
        scriptStory.text = story!.stories[self.activePart]
        scriptStory.font = UIFont(name: "Baloo2-Medium", size: 17)
        scriptStory.lineBreakMode = .byWordWrapping
        
        view.addSubview(scriptStory)
    }
    
    private func _fetchButton() {
        if self.activePart == 0 {
            
        } else {
            
            
            if self.activePart == story!.stories.count - 1 {
//                print("cerita mentok!!")
                nextFloatingButton.backgroundColor = UIColor.init(named: "buttonColorGreen")
                let image = UIImage(systemName: "checkmark.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32, weight: .medium))
                nextFloatingButton.setImage(image, for: .normal)
                
            } else {
                let image = UIImage(systemName: "arrow.right.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32, weight: .medium))
                nextFloatingButton.setImage(image, for: .normal)
                nextFloatingButton.backgroundColor = UIColor.init(named: "buttonColorBlue")
                
            }
            
        }
    }
    
    
    private func _openPopUpDescription(_ word: String) {
        // set haptic feedback
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        
        _animateIn(desiredView: viewHintBgBlur)
        
        wordTemp = word
        labelTtitleHint.text = word.capitalized
        _fetchVideo(word: word)
        _fetchDescription(word: word)
    }

    private func _fetchPageControl(page: Int) {
        storyPageControl.frame(forAlignmentRect: CGRect(x: 0, y: 0, width: 16, height: 4))
        storyPageControl.numberOfPages = story!.stories.count
        storyPageControl?.currentPage = Int(page)
    }
    
    private func _fetchDescription(word: String) {
        
        let kosakataRequest: NSFetchRequest<Kosakata> = Kosakata.fetchRequest()
        kosakataRequest.predicate = NSPredicate(format: "kata = %@", word)
        kosakataRequest.returnsObjectsAsFaults = false
        
        do {
            try kosakatas = manageObjectContext.fetch(kosakataRequest)
        
            textviewDescriptionSignLanguage.text = kosakatas[self.indexStoryReceiver].deskripsi!
        } catch {
            print("Gagal load data deskrpsi!")
        }
       
    }
    
    private func _fetchVideo(word: String) {
        
        playVideoButton.isHidden = true
        
        let kosakataRequest: NSFetchRequest<Kosakata> = Kosakata.fetchRequest()
        kosakataRequest.predicate = NSPredicate(format: "kata = %@", word)
        kosakataRequest.returnsObjectsAsFaults = false
        
        do {
            try kosakatas = manageObjectContext.fetch(kosakataRequest)
            
            /// video online
//            let videoURL = URL(string: kosakatas[0].urlVideo!)!
            
            /// kalo videonya offline
            let file = kosakatas[self.indexStoryReceiver].urlVideo!.components(separatedBy: ".")
//            let file = "sibi_bermain.mp4".components(separatedBy: ".")
    
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
            
        } catch {
            print("Gagal load data video!")
        }
    }
    
    // animate in popup
    private func _animateIn(desiredView: UIView) {
        let backgroundView = self.view!
        
        // attach our desired view to the screen
        backgroundView.addSubview(desiredView)
        
        // set view to scalling to be 120%
        desiredView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        desiredView.alpha = 0
        desiredView.center = backgroundView.center
        
        // animate the effect
        UIView.animate(withDuration: 0.3, animations: {
            desiredView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            desiredView.alpha = 1
           
        })
    }
    
    private func _animateOut(desiredView: UIView) {
        // animate the effect
        UIView.animate(withDuration: 0.3, animations: {
            desiredView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            desiredView.alpha = 0
        }, completion: {_ in
            desiredView.removeFromSuperview()
        })
    }
    
    
    // OBSERVER
    @objc func videoDidEnd(notification: NSNotification) {
        playVideoButton.isHidden = false
    }
    
    
    
    
    
    
    // IBACTION
    @IBAction func prevPart(_ sender: UIButton) {
        if self.activePart == 0 {
            
            self.activePart = 0
            _generateContent()
            _fetchPageControl(page: self.activePart)
         
            self._animateSpringView(sender)
            
        } else if self.activePart <= story!.stories.count - 1 {
            
            self.activePart -= 1
            _generateContent()
            _fetchPageControl(page: self.activePart)
            
            self._animateSpringView(sender)
            
        }
        
        UIImpactFeedbackGenerator(style: .soft).impactOccurred()
    }
    
    @objc private func didTapPrevButton(_ sender: UIButton){
        if self.activePart == 0 {
            
            self.activePart = 0
            _generateContent()
            _fetchPageControl(page: self.activePart)
         
            self._animateSpringView(sender)
            
        } else if self.activePart <= story!.stories.count - 1 {
            
            self.activePart -= 1
            _generateContent()
            _fetchPageControl(page: self.activePart)
            
            self._animateSpringView(sender)
            
        }
        
        UIImpactFeedbackGenerator(style: .soft).impactOccurred()
    }

    
   
    
    @objc private func didTapNextButton(_ sender: UIButton){
        if self.activePart < story!.stories.count - 1 {
            self.activePart += 1
            _generateContent()
            _fetchPageControl(page: self.activePart)
            
            self._animateSpringView(sender)
        } else if self.activePart == story!.stories.count - 1 {
            self._animateSpringView(sender)
//            performSegue(withIdentifier: "scoreStorySegue", sender: nil)
            performSegue(withIdentifier: "endStorySegue", sender: nil)
        }
        
        UIImpactFeedbackGenerator(style: .soft).impactOccurred()
        
    }
    
    
    @IBAction func buttonClosePopUpView(_ sender: UIButton) {
        _animateOut(desiredView: viewHintBgBlur)
        
        NotificationCenter.default.removeObserver(self)
     
        playVideoButton.isHidden = true
        
        let kosakataRequest: NSFetchRequest<Kosakata> = Kosakata.fetchRequest()
        kosakataRequest.predicate = NSPredicate(format: "kata = %@", wordTemp)
        kosakataRequest.returnsObjectsAsFaults = false
        
        do {
            try kosakatas = manageObjectContext.fetch(kosakataRequest)
            
            kosakatas[self.indexStoryReceiver].sudahDipelajari = 1
//            print("\(wordTemp) berhasil dipelajari")
            self.wordClicked.insert(wordTemp)
            print("word click count", wordClicked.count)
            
            self._animateSpringView(sender)
        } catch {
            print("\(wordTemp) belum berhasil dipelajari")
        }
    }
    
    @IBAction func closeDetailPopUpView(_ sender: UIButton) {
        _animateOut(desiredView: detailPopUpView)
        _animateOut(desiredView: blurDetailPopUpView)
        
        NotificationCenter.default.removeObserver(self)
     
        playVideoButton.isHidden = true
        
        let kosakataRequest: NSFetchRequest<Kosakata> = Kosakata.fetchRequest()
        kosakataRequest.predicate = NSPredicate(format: "kata = %@", wordTemp)
        kosakataRequest.returnsObjectsAsFaults = false
        
        do {
            try kosakatas = manageObjectContext.fetch(kosakataRequest)
            
            kosakatas[self.indexStoryReceiver].sudahDipelajari = 1
//            print("\(wordTemp) berhasil dipelajari")
            self.wordClicked.insert(wordTemp)
            print("word click count", wordClicked.count)
            
            self._animateSpringView(sender)
        } catch {
            print("\(wordTemp) belum berhasil dipelajari")
        }
        
        
    }
    
    @objc
    func buttonAction() {
        _fetchVideo(word: wordTemp)
    }
    
    
    
    
    
    // PREPARE SEGUE
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let endStoryVC = segue.destination as? StoryEndViewController {
            endStoryVC.expWordResult = self.wordClicked.count * 10
            endStoryVC.wordLearned = self.wordClicked.count
        } else if let endStoryVC = segue.destination as? PracticeEndViewController {
            endStoryVC.expWordResult = self.wordClicked.count * 10
            endStoryVC.wordLearned = self.wordClicked.count
            endStoryVC.totalAllWordHighlightInStory = story!.highlightedWords.count
            endStoryVC.indexStoryReceiver = self.indexStoryReceiver
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
