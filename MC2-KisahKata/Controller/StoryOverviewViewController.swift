//
//  StoryOverviewViewController.swift
//  storySignLanguageTest2
//
//  Created by Dimas Putro on 19/07/21.
//

import UIKit

class StoryOverviewViewController: UIViewController {

    @IBOutlet weak var viewOverviewContainer: UIView!
    @IBOutlet weak var viewStarContainer: UIView!
    @IBOutlet weak var buttonReadStory: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewOverviewContainer.roundedBorder(cornerRadius: 24)
        viewStarContainer.roundedBorder(cornerRadius: 12)
        
        buttonReadStory.roundedBorder(cornerRadius: 12)
        buttonReadStory.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        
        
//        buttonReadStory.layer.borderWidth = 2.0
//        buttonReadStory.layer.borderColor = UIColor(hue: 211, saturation: 100, brightness: 21, alpha: 1).cgColor
//        buttonReadStory.layer.shadowColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
//        buttonReadStory.layer.shadowOpacity = 1.0
//        buttonReadStory.layer.shadowRadius = 1.0
//        buttonReadStory.layer.shadowOffset = CGSize(width: 0, height: 3)
        
        
//        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//            if segue.destination.isKind(of: StorytellingViewController.self){
//                if let storyVC = segue.destination as? StorytellingViewController {
//                    storyVC.indexStory = ceritaTableView.indexPathForSelectedRow!.row
//                    storyVC.story = storiesData.list[ceritaTableView.indexPathForSelectedRow!.row]
//                }
//
//            }
//
//        }
        
    }
    

}
