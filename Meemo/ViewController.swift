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
    
    @IBOutlet weak var portraitImageView: UIImageView!
    
    
    @IBOutlet weak var timerTextView: UITextView!    
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var authorTextView: UITextView!
    @IBOutlet weak var clockTextView: UITextView!
    @IBOutlet weak var quoteTextView: UITextView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var fileLoadingIndicator: UIActivityIndicatorView!
    
    var liked: Bool = false
    let rootRef = FIRDatabase.database().reference()
    var player:Player = Player()
    var contentManager: ContentManager = ContentManager()
    
    //ContentManagerDelegate func (protocol definition in ContentManager.swift)
    func contentDidUpdate(){
        self.quoteTextView.text = contentManager.content.quote
        self.authorTextView.text = contentManager.content.author
        self.player.setDuration(duration: contentManager.content.duration)
        self.timerTextView.text = player.getDurationString()
        
    }
    
    func fileDidUpdate(){
        self.player.reset()
        self.playButton.setImage(#imageLiteral(resourceName: "player_play_button"), for: .normal)
    }
    
    func fileDidLoad(){
        player.setFile(data: self.contentManager.content.file)
        play()
    }
    
    
    func pictureDidLoad(){
        portraitImageView.image = UIImage(data: self.contentManager.content.picture)
    }
    
    //PlayerDelegate func (protocol definition in Player.swift)
    func playerDidFinishPlaying(){
        self.playButton.setImage(#imageLiteral(resourceName: "player_play_button"), for: .normal)
        FIRAnalytics.logEvent(withName: "finished_play", parameters: nil)
        timerTextView.text = ""
        performSegue(withIdentifier: "showreactionview", sender: self)
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
        self.playButton.setImage(#imageLiteral(resourceName: "player_pause_button"), for: .normal)
        self.fileLoadingIndicator.stopAnimating()
        player.play()

        let hourOfTheDay = Calendar.current.component(.hour, from: Date())
        FIRAnalytics.logEvent(withName: "press_play", parameters: ["time": hourOfTheDay as NSObject])
        
    }
    
    func pause(){
        self.playButton.setImage(#imageLiteral(resourceName: "player_play_button"), for: .normal)
        player.pause()
    }
    
    @IBAction func heartDidTouch(_ sender: AnyObject) {
        if(liked == false){
            heartButton.setImage(#imageLiteral(resourceName: "player_heart_full"), for: .normal)
            liked = true
        }else{
            heartButton.setImage(#imageLiteral(resourceName: "player_heart_empty"), for: .normal)
            liked = false
        }
    }
    
    @IBAction func replayDidTouch(_ sender: AnyObject) {
        if(player.isInitialized()){
            self.player.reset()
            player.setFile(data: self.contentManager.content.file)
            play()
        }else{
            playButton.setImage(#imageLiteral(resourceName: "player_empty_button"), for: .normal)
            fileLoadingIndicator.startAnimating()
            self.contentManager.downloadFile()
        }
    }
    
    @IBAction func playDidTouch(_ sender: AnyObject) {
        if(!player.isInitialized()){
            playButton.setImage(#imageLiteral(resourceName: "player_empty_button"), for: .normal)
            fileLoadingIndicator.startAnimating()
            self.contentManager.downloadFile()
        }else if(self.player.isPlaying()){
            pause()
        }else if(!self.player.isPlaying()){
            play()
        }else{
            playButton.setImage(#imageLiteral(resourceName: "player_empty_button"), for: .normal)
            fileLoadingIndicator.startAnimating()
            self.contentManager.downloadFile()
        }
    }
}
