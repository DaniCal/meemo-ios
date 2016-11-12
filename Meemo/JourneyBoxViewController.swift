//
//  JourneyBoxViewController.swift
//  Meemo
//
//  Created by Daniel Lohse on 10/24/16.
//  Copyright © 2016 Superstudio. All rights reserved.
//

import UIKit

@objc protocol JourneyBoxDelegate{
    @objc optional func playDidTouch(content: Content)
}


class JourneyBoxViewController: UIViewController {
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var overlayOval: UIImageView!
    @IBOutlet weak var boxImage: UIImageView!
    @IBOutlet weak var boxAuthor: UILabel!
    @IBOutlet weak var boxTitle: UILabel!

    var content:Content = Content()
    
    var imageURL: String = ""
    
    var delegate:JourneyBoxDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        boxAuthor.text = ""
        boxTitle.text = ""
        boxImage.image = #imageLiteral(resourceName: "journey_day0")
        playButton.setImage(nil, for: .normal)
        playButton.isEnabled = false
        overlayOval.alpha = 0.6
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setTitle(title: String){
        if(boxTitle != nil){
            boxTitle.text = title
        }
    }
    
    func setAuthor(author: String){
        if(boxAuthor != nil){
            boxAuthor.text = author
        }
    }
    
    func setContent(content: Content){
        self.content = content
//        setTitle(title: content.quote)
//        setAuthor(author: content.author)
//        setImage(index: content.index)
//        if(!content.enabled){
//            disable()
//        }else{
//            enable()
//        }
    }
    
    func setImage(index: Int){
        switch(index){
        case 1:
            boxImage.image = #imageLiteral(resourceName: "journey_day1")
            break
        case 2:
            boxImage.image = #imageLiteral(resourceName: "journey_day2")
            break
        case 3:
            boxImage.image = #imageLiteral(resourceName: "journey_day3")
            break
        case 4:
            boxImage.image = #imageLiteral(resourceName: "journey_day4")
            break
        case 5:
            boxImage.image = #imageLiteral(resourceName: "journey_day5")
            break
        case 6:
            boxImage.image = #imageLiteral(resourceName: "journey_day6")
            break
        case 7:
            boxImage.image = #imageLiteral(resourceName: "journey_day7")
            break
        default:
            boxImage.image = #imageLiteral(resourceName: "journey_day0")
            break
        }
    }
    
    
    func disable(){
            playButton.setImage(#imageLiteral(resourceName: "journey_lock"), for: .normal)
            overlayOval.alpha = 0.6
            playButton.isEnabled = false
    }
    
    func enable(){
        playButton.setImage(#imageLiteral(resourceName: "play_icon"), for: .normal)
        overlayOval.alpha = 0.0
        playButton.isEnabled = true
    }
    
    @IBAction func playDidTouch(_ sender: AnyObject) {
        delegate?.playDidTouch!(content: content)
    }
}
