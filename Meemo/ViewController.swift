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

class ViewController: UIViewController, PlayerDelegate, ContentManagerDelegate {
    
    
    
    @IBOutlet weak var timerTextView: UITextView!
    @IBOutlet weak var jobTextView: UITextView!
    @IBOutlet weak var authorTextView: UITextView!
    @IBOutlet weak var clockTextView: UITextView!
    @IBOutlet weak var quoteTextView: UITextView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var fileLoadingIndicator: UIActivityIndicatorView!
    
    let rootRef = FIRDatabase.database().reference()
    
    var player:Player = Player()

    var contentManager: ContentManager = ContentManager()
    
    //ContentManagerDelegate func (protocol definition in ContentManager.swift)
    
    func contentDidUpdate(){
        self.quoteTextView.text = contentManager.content.quote
        self.authorTextView.text = contentManager.content.author
        self.jobTextView.text = contentManager.content.job
        self.player.setDuration(duration: contentManager.content.duration)
    }
    
    func fileDidUpdate(){
        self.player.reset()
        self.playButton.setImage(#imageLiteral(resourceName: "play_button"), for: .normal)
    }
    
    func fileDidLoad(){
        player.setFile(data: self.contentManager.content.file)
        play()
    }
    
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
    
    //ControllerDelegate func
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.player.delegate = self
        self.contentManager.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        contentManager.connectToDB()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //Player interactions
    
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
    
    
    @IBAction func playDidTouch(_ sender: AnyObject) {
        if(!player.isInitialized()){
            playButton.setImage(#imageLiteral(resourceName: "transparent_button"), for: .normal)
            fileLoadingIndicator.startAnimating()
            self.contentManager.downloadFile()
        }else if(self.player.isPlaying()){
            pause()
        }else if(!self.player.isPlaying()){
            play()
        }else{
            playButton.setImage(#imageLiteral(resourceName: "transparent_button"), for: .normal)
            fileLoadingIndicator.startAnimating()
            self.contentManager.downloadFile()
        }
    }
}
