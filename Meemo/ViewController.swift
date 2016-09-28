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
    
    
    
    @IBOutlet weak var jobTextView: UITextView!
    @IBOutlet weak var authorTextView: UITextView!
    @IBOutlet weak var clockTextView: UITextView!
    @IBOutlet weak var quoteTextView: UITextView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var fileLoadingIndicator: UIActivityIndicatorView!
    
    let rootRef = FIRDatabase.database().reference()
    
    var sound: AVAudioPlayer!

    var urlString: String!
    var quote: String!
    var author: String!
    var job: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        subscribeURL()
        subscribeQuote()
        subscribeAuthor()
        subscribeJob()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func subscribeURL(){
        let conditionRef = rootRef.child("url")
        conditionRef.observe(.value, with: { (snapshot: FIRDataSnapshot) in
            let url = snapshot.value as? String
            if(url != nil){
                self.urlString = url!
                
                if(self.sound != nil){
                    self.sound.pause()
                    self.sound = nil
                    self.playButton.setImage(#imageLiteral(resourceName: "play_button"), for: .normal)
                }
            }
        })
    }
    
    func subscribeQuote(){
        let conditionRef = rootRef.child("quote")
        conditionRef.observe(.value, with: { (snapshot: FIRDataSnapshot) in
            let quote = snapshot.value as? String
            if(quote != nil){
                self.quote = quote!
                self.quoteTextView.text = quote
            }
        })
    }
    
    func subscribeAuthor(){
        let conditionRef = rootRef.child("author")
        conditionRef.observe(.value, with: { (snapshot: FIRDataSnapshot) in
            let author = snapshot.value as? String
            if(author != nil){
                self.author = author!
                self.authorTextView.text = author

            }
        })
    }
    
    func subscribeJob(){
        let conditionRef = rootRef.child("job")
        conditionRef.observe(.value, with: { (snapshot: FIRDataSnapshot) in
            let job = snapshot.value as? String
            if(job != nil){
                self.job = job!
                self.jobTextView.text = job
            }
        })
    }

    
    
    func play(){
        self.playButton.setImage(#imageLiteral(resourceName: "pause_button"), for: .normal)
        self.fileLoadingIndicator.stopAnimating()
        self.sound.play()
        FIRAnalytics.logEvent(withName: "press_play", parameters: nil)
    }
    
    func pause(){
        self.playButton.setImage(#imageLiteral(resourceName: "play_button"), for: .normal)
        self.sound.pause()
    }
    
    func load(){
        playButton.setImage(#imageLiteral(resourceName: "transparent_button"), for: .normal)
        fileLoadingIndicator.startAnimating()
        Alamofire.request(urlString).response { response in
            debugPrint(response)
            if let data = response.data {
                do{
                    self.sound = try AVAudioPlayer(data: data, fileTypeHint: "mp3")
                    self.play()
                }
                catch{
                    //TODO error hanlding creating AVAudioPlayer object with raw data
                }
            }else{
                //TODO error handling hhtp request
            }
        }
    }
    
    @IBAction func playDidTouch(_ sender: AnyObject) {
        if(sound == nil){
            load()
        }else if(sound.isPlaying){
            pause()
        }else if(!sound.isPlaying){
            play()
        }else{
            load()
        }
    }
}
