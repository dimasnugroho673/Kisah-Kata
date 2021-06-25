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
    
    let scriptStory = ActiveLabel()

    
    var story: Stories? = nil
    var indexStory: Int = 0
    
    @IBOutlet weak var storyPageControl: UIPageControl!
    @IBOutlet weak var ilustrationStoryImage: UIImageView!
    
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var detailPopUpView: UIView!
    @IBOutlet weak var blurDetailPopUpView: UIView!
    
    
    @IBOutlet weak var videoContainerView: UIView!
    @IBOutlet weak var descriptionDetailContainerView: UIView!
    @IBOutlet weak var titleDetailPopUpLabel: UILabel!
    @IBOutlet weak var descriptionDetailPopUpLabel: UILabel!
    @IBOutlet weak var closeDetailPopUpButton: UIButton!
    
    var playerLayer = AVPlayerLayer()
    
    let playVideoButton = UIButton(frame: CGRect(x: 100, y: 400, width: 200, height: 60))
    
    
//    init(indexStory: Int) {
//        self.indexStory = indexStory
//        super.init(nibName: nil, bundle: nil)
//    }
    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = story!.title
        
//        print(story!.stories)
        
        prevButton.roundedBorder(cornerRadius: 12)
        prevButton.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        prevButton.tintColor = UIColor.darkGray
        
        if self.activePart == 0 {
            prevButton.isHidden = true
        }
        
        nextButton.roundedBorder(cornerRadius: 12)
        nextButton.setTitle("Selanjutnya", for: .normal)
        

        
        _generateContent()
        
        videoContainerView.roundedBorder(cornerRadius: 12)
        
        // set blur width to bounds
        blurDetailPopUpView.bounds = self.view.bounds
        blurDetailPopUpView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        
        detailPopUpView.bounds = CGRect(x: 0, y: 0, width: self.view.bounds.width * 0.9, height: self.view.bounds.height * 0.75)
        detailPopUpView.roundedBorder(cornerRadius: 24)
       
        descriptionDetailContainerView.backgroundColor = UIColor.white
        
        closeDetailPopUpButton.roundedBorder(cornerRadius: 12)
        
//        nextButton.setImage(UIImage(systemName: "chevron.forward"), for: .normal)
//        nextButton.contentHorizontalAlignment = .left
        
//        let button = UIButton(type: UIButton.ButtonType.system) as UIButton
//
//               let xPostion:CGFloat = 400
//               let yPostion:CGFloat = 100
//               let buttonWidth:CGFloat = 150
//               let buttonHeight:CGFloat = 45
//
//        button.frame = CGRect(x:20, y:view.frame.height - 100, width:buttonWidth, height:buttonHeight)
//
////        button.translatesAutoresizingMaskIntoConstraints = false
//
//               button.backgroundColor = UIColor.lightGray
//               button.setTitle("Tap me", for: UIControl.State.normal)
//               button.tintColor = UIColor.black
////               button.addTarget(self, action: #selector(self.buttonAction), for: .touchUpInside)
//
//               self.view.addSubview(button)
//
//        NSLayoutConstraint.activate([
//
//            button.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
//            button.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
//            button.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor,constant: -buttonHeight),
//            button.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
//        ])
            
    }
    
    

//    private func _loadData() {
//        let kosakataRequest: NSFetchRequest<Kosakata> = Kosakata.fetchRequest()
//
////        let sort = [NSSortDescriptor(key: "kata", ascending: true)]
////        kosakataRequest.sortDescriptors = sort
//        let filter = "products"
//        let predicate = NSPredicate(format: "type = %@", filter)
//
//        do {
//            try kosakatas = manageObjectContext.fetch(kosakataRequest)
//
//        } catch {
//            print("Gagal load data!")
//        }
//    }
    
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
                    default: ()
                        
                    }
                    
                    return atts
                }
            }
            
        }
        
        scriptStory.frame = CGRect(x: 25, y: 450, width: view.frame.width - 30, height: 270)
        
        // text showing
        scriptStory.text = story!.stories[self.activePart]
        scriptStory.font = UIFont(name: "Baloo2-Medium", size: 17)
        scriptStory.lineBreakMode = .byWordWrapping
        
        view.addSubview(scriptStory)
    }
    
    private func _fetchButton() {
        if self.activePart == 0 {
            prevButton.isHidden = true
        } else {
            prevButton.isHidden = false
        }
    }
    
    
    private func _openPopUpDescription(_ word: String) {
        // set haptic feedback
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        
        _animateIn(desiredView: blurDetailPopUpView)
        _animateIn(desiredView: detailPopUpView)
        
        titleDetailPopUpLabel.text = word.capitalized
        _fetchVideo()
    }

    private func _fetchPageControl(page: Int) {
        storyPageControl.frame(forAlignmentRect: CGRect(x: 0, y: 0, width: 16, height: 4))
        storyPageControl.numberOfPages = story!.stories.count
        storyPageControl?.currentPage = Int(page)
    }
    
    private func _fetchVideo() {
        
        playVideoButton.isHidden = true
        
        /// kalo videonya offline
//        let file = "video_sibi_tampan.mov".components(separatedBy: ".")
//
//        guard let filePath = Bundle.main.path(forResource: file[0], ofType:file[1]) else {
//              debugPrint( "\(file.joined(separator: ".")) not found")
//              return
//        }
        
        // video offline
//        let videoURL = URL(fileURLWithPath: filePath)
        
        // video online
        let videoURL = URL(string: "https://r4---sn-q4fl6ne7.googlevideo.com/videoplayback?expire=1624664102&ei=xhPWYJCoL_Kaj-8Pht2ZiA4&ip=102.129.153.142&id=o-AG9chOCnfk9B1k5yRZt_l2DUDAM14-DqeVuKsmIAyT7F&itag=22&source=youtube&requiressl=yes&mh=am&mm=31%2C29&mn=sn-q4fl6ne7%2Csn-q4flrner&ms=au%2Crdu&mv=m&mvi=4&pl=25&initcwndbps=726250&vprv=1&mime=video%2Fmp4&ns=VKEBwsLhj1xC5FACJX-gNZ8G&cnr=14&ratebypass=yes&dur=5.131&lmt=1572102153131113&mt=1624642127&fvip=4&fexp=24001373%2C24007246&beids=9466585&c=WEB&txp=2211222&n=etk1qKLEryQf072O88yIX&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cvprv%2Cmime%2Cns%2Ccnr%2Cratebypass%2Cdur%2Clmt&sig=AOq0QJ8wRQIhAJqOLyTU1e0FYglQQHG4Cay3fgWsWDt2OQoE-9RgjWE7AiBfoyPMD3TBo6ktSCeaqi_0yhaMMjpO7THSuHK1MUGaug%3D%3D&lsparams=mh%2Cmm%2Cmn%2Cms%2Cmv%2Cmvi%2Cpl%2Cinitcwndbps&lsig=AG3C_xAwRgIhAJqpOZcpwZ-f7ACf-uQ4DmaUXtq5iR8RGwcppzX3l1YlAiEA9ORpIMzERz6wQbeFPz6tG-3rHVBcI_cBV3EOnXock84%3D&title=square%20aspect%20ratio%201%3A1%20test%20on%20Youtube%20(in%202018%2F2019)")!
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
    @IBAction func prevPart(_ sender: Any) {
        if self.activePart == 0 {
            
            self.activePart = 0
            _generateContent()
            _fetchPageControl(page: self.activePart)
         
            
        } else if self.activePart <= story!.stories.count - 1 {
            
            self.activePart -= 1
            _generateContent()
            _fetchPageControl(page: self.activePart)
            
        }
    }

    
    @IBAction func nextPart(_ sender: Any) {
        if self.activePart < story!.stories.count - 1 {
            self.activePart += 1
            _generateContent()
            _fetchPageControl(page: self.activePart)
            
        }
    }
    
    @IBAction func closeDetailPopUpView(_ sender: Any) {
        _animateOut(desiredView: detailPopUpView)
        _animateOut(desiredView: blurDetailPopUpView)
        
        NotificationCenter.default.removeObserver(self)
     
        playVideoButton.isHidden = true
    }
    
    @objc
    func buttonAction() {
        _fetchVideo()
    }
    
    
}
