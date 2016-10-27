//
//  JourneyBoxViewController.swift
//  Meemo
//
//  Created by Daniel Lohse on 10/24/16.
//  Copyright © 2016 Superstudio. All rights reserved.
//

import UIKit

@objc protocol JourneyBoxDelegate{
    @objc optional func playDidTouch()
}


class JourneyBoxViewController: UIViewController {
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var overlayOval: UIImageView!

    @IBOutlet weak var boxImage: UIImageView!
    @IBOutlet weak var boxAuthor: UILabel!
    @IBOutlet weak var boxTitle: UILabel!

    var imageURL: String = ""
    
    var delegate:JourneyBoxDelegate?

    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        setTitle(title: content.quote)
        setAuthor(author: content.author)
        if(!content.enabled){
            disable()
        }
    }
    
    func disable(){
            playButton.setImage(#imageLiteral(resourceName: "player_heart_full"), for: .normal)
            overlayOval.alpha = 0.6
            playButton.isEnabled = false
    }
    
    
    @IBAction func playDidTouch(_ sender: AnyObject) {
        delegate?.playDidTouch!()
    }

    

}
