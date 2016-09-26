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

    @IBOutlet weak var fileLoadingIndicator: UIActivityIndicatorView!
    var urlString = "https://storage.googleapis.com/meemo/awakening.mp3"
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
        fileLoadingIndicator.startAnimating()
        Alamofire.request(urlString).response { response in
            
            debugPrint(response)
            if let data = response.data {
                do{
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
