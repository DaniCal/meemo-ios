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

class ViewController: UIViewController, PlayerDelegate {
    
    
    
    @IBOutlet weak var timerTextView: UITextView!
    @IBOutlet weak var jobTextView: UITextView!
    @IBOutlet weak var authorTextView: UITextView!
    @IBOutlet weak var clockTextView: UITextView!
    @IBOutlet weak var quoteTextView: UITextView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var fileLoadingIndicator: UIActivityIndicatorView!
    
    let rootRef = FIRDatabase.database().reference()
    
    var player:Player = Player()

    var urlString: String!
    var quote: String!
    var author: String!
    var job: String!
    var timer = Timer.init()
    var duration: Int!

    
    //PlayerDelegate func (protocol definition in Player.swift)
    
    func playerDidFinishPlaying(){
        self.playButton.setImage(#imageLiteral(resourceName: "play_button"), for: .normal)
        FIRAnalytics.logEvent(withName: "finished_play", parameters: nil)
        timerTextView.text = ""
    }
    
    func playerErrorDidOccur(){
    }
    
    func playerFileErrorDidOccur(){
    }
    
    func playerUpdateTime(timeLeft: String){
        timerTextView.text = timeLeft
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.player.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        subscribeURL()
        subscribeQuote()
        subscribeAuthor()
        subscribeJob()
        subscribeDuration()
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
                self.player.reset()
                self.playButton.setImage(#imageLiteral(resourceName: "play_button"), for: .normal)
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
    
    func subscribeDuration(){
        let conditionRef = rootRef.child("duration")
        conditionRef.observe(.value, with: { (snapshot: FIRDataSnapshot) in
            let durationData = snapshot.value as? String
            if(durationData != nil){
                let duration:Int = Int(durationData!)!
                self.player.setDuration(duration: duration)
            }
        })
    }

    
    
    func play(){
        self.playButton.setImage(#imageLiteral(resourceName: "pause_button"), for: .normal)
        self.fileLoadingIndicator.stopAnimating()
        player.play()

        let hourOfTheDay = Calendar.current.component(.hour, from: Date())
        FIRAnalytics.logEvent(withName: "press_play", parameters: ["time": hourOfTheDay as NSObject])
        
    }
    
    func pause(){
        self.playButton.setImage(#imageLiteral(resourceName: "play_button"), for: .normal)
        player.pause()
    }
    
    func load(){
        playButton.setImage(#imageLiteral(resourceName: "transparent_button"), for: .normal)
        fileLoadingIndicator.startAnimating()
        Alamofire.request(urlString).response { response in
            debugPrint(response)
            if let data = response.data {
                self.player.setFile(data: data)
                self.play()
            }else{
                //TODO error handling hhtp request
            }
        }
    }
    
    @IBAction func playDidTouch(_ sender: AnyObject) {
        if(!player.isInitialized()){
            load()
        }else if(self.player.isPlaying()){
            pause()
        }else if(!self.player.isPlaying()){
            play()
        }else{
            load()
        }
    }
}
