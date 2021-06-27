//
//  ListCeritaViewController.swift
//  MC2-KisahKata
//
//  Created by Farendza Muda on 23/06/21.
//

import UIKit

class ListCeritaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var cerita = ["Legenda Danau Toba", "Lanj. Legenda Danau Toba", "Petani dan Angsa Bertelur Emas", "Lanj. Petani dan Angsa Bertelur Emas", "Legenda Sangkuriang", "Legenda Loro Jonggrang"]
    var thumbnail = ["Danau Toba.img", "Danau Toba.img", "duck egg.img", "duck egg.img", "Tangkuban Perahu.img", "Candi Prambanan.img"]
    
    let storiesData = StoriesData()

    @IBOutlet weak var ceritaTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Kisah"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = UIColor.white

       
        ceritaTableView.delegate = self
        ceritaTableView.dataSource = self
        
        
        
        ceritaTableView.separatorStyle = .none
        ceritaTableView.showsVerticalScrollIndicator = false
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 168
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return cerita.count
        return storiesData.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ceritaTableView.dequeueReusableCell(withIdentifier: "ceritaCell") as! CeritaTableViewCell

        let story = storiesData.list[indexPath.row].title
        let img = storiesData.list[indexPath.row].coverImage
        
        cell.ceritaLabel.text = story
        cell.ceritaImage.image = UIImage(named: img)
        cell.ceritaView.roundedBorder()
        
        cell.selectionStyle = .none
        
        if indexPath.row == 0 {
            
            cell.ceritaView.backgroundColor = UIColor(named: "VeryLowInterferenceColor")
        } else {
            cell.ceritaView.backgroundColor = UIColor(named: "LowInterferenceColor")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row < 1 {
            performSegue(withIdentifier: "storyTellingSegue", sender: nil)
        } else {
            
            // Create new Alert
            var dialogMessage = UIAlertController(title: "Cerita masih terkunci", message: "Cerita masih terkunci, kamu harus mencapai poin minimun untuk membuka cerita ini", preferredStyle: .alert)
            
            // Create OK button with action handler
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
             })
            
//            let imgViewTitle = UIImageView(frame: CGRect(x: 10, y: 10, width: 30, height: 30))
//               imgViewTitle.image = UIImage(systemName: "lock.rectangle.stack")
//            dialogMessage.view.addSubview(imgViewTitle)
            
            //Add OK button to a dialog message
            dialogMessage.addAction(ok)
            // Present Alert to
            self.present(dialogMessage, animated: true, completion: nil)
            
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination.isKind(of: StorytellingViewController.self){
            if let storyVC = segue.destination as? StorytellingViewController {
                storyVC.indexStory = ceritaTableView.indexPathForSelectedRow!.row
                storyVC.story = storiesData.list[ceritaTableView.indexPathForSelectedRow!.row]
            }
            
        }
        
    }
    

}
