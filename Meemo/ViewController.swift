//
//  ViewController.swift
//  Meemo
//
//  Created by Daniel Lohse on 9/21/16.
//  Copyright © 2016 Superstudio. All rights reserved.
//

import UIKit
import AVFoundation
import Alamofire
import Firebase

class ViewController: UIViewController {
    
    
    let rootRef = FIRDatabase.database().reference()
    
    var sound: AVAudioPlayer!

    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var fileLoadingIndicator: UIActivityIndicatorView!
    var urlString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        let conditionRef = rootRef.child("url")
        conditionRef.observe(.value, with: { (snapshot: FIRDataSnapshot) in
            let url = snapshot.value as? String
            if(url != nil){
                self.urlString = url!
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loadFileClick(_ sender: AnyObject) {
        playButton.setImage(#imageLiteral(resourceName: "transparent_button"), for: .normal)
        fileLoadingIndicator.startAnimating()
        Alamofire.request(urlString).response { response in
            
            debugPrint(response)
            if let data = response.data {
                do{
                    self.playButton.setImage(#imageLiteral(resourceName: "pause_button"), for: .normal)
                    self.fileLoadingIndicator.stopAnimating()
                    self.sound = try AVAudioPlayer(data: data, fileTypeHint: "mp3")
                    self.sound.play()
                }
                catch{
                    //TODO error hanlding creating AVAudioPlayer object with raw data
                }
            }else{
                //TODO error handling hhtp request
            }
        }

    }
   
}
