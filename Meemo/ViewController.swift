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

class ViewController: UIViewController {
    
    var sound: AVAudioPlayer!

    var urlString = "https://storage.googleapis.com/meemo/sound.mp3"
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func completion(){
        print("here")
    }
    
    @IBAction func loadFileClick(_ sender: AnyObject) {
        Alamofire.request(urlString).response { response in
            
            debugPrint(response)
            if let data = response.data {
                do{
                    self.sound = try AVAudioPlayer(data: data, fileTypeHint: "mp3")
                }
                catch{
                    //TODO error hanlding creating AVAudioPlayer object with raw data
                }
            }else{
                //TODO error handling hhtp request
            }
        }

    }
    @IBAction func playButtonClick(_ sender: AnyObject) {
        if(self.sound != nil){
            self.sound.play()
        }
    }
}
