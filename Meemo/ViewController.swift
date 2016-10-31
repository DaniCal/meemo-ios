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
    var content:Content = Content()
    var liked: Bool = false
    let rootRef = FIRDatabase.database().reference()
    var player:Player = Player()
    
    /*------------------------------------------------------------------------
    --------------------PlayerDelegate Functions------------------------------
    ------------------------------------------------------------------------*/
    
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
    

    /*------------------------------------------------------------------------
     --------------------ViewController Functions------------------------------
     ------------------------------------------------------------------------*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.player.delegate = self
        initUI()
        downloadPicture()
        start()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Initializing test data
        let segueName:String = segue.identifier!;
        
        if(segueName ==  "goBack"){
            //Segue when navigated back to journey
            reset()
        }else if(segueName == "showreactionview"){
            //Segue when showing reaction view after finishing playing
            let reactionViewController:ReactionViewController = segue.destination as! ReactionViewController
            reactionViewController.content = self.content
        }
    }
    
    /*------------------------------------------------------------------------
     --------------------UI Functions-------------------------------
     ------------------------------------------------------------------------*/
    
    func initUI(){
        self.quoteTextView.text = content.quote
        self.authorTextView.text = content.author
        self.player.setDuration(duration: content.duration)
        self.timerTextView.text = player.getDurationString()
    }
    
    func stateLoad(){
        playButton.setImage(#imageLiteral(resourceName: "player_empty_button"), for: .normal)
        fileLoadingIndicator.startAnimating()
    }
    
    func statePause(){
        self.playButton.setImage(#imageLiteral(resourceName: "player_play_button"), for: .normal)
        self.fileLoadingIndicator.stopAnimating()
    }
    
    func statePlay(){
        self.playButton.setImage(#imageLiteral(resourceName: "player_pause_button"), for: .normal)
        self.fileLoadingIndicator.stopAnimating()
    }
    
    
    /*------------------------------------------------------------------------
     --------------------Player Functions-------------------------------
     ------------------------------------------------------------------------*/
    
    func start(){
        if(!player.isInitialized()){
            //Load file from server and init Player instance
            self.stateLoad()
            self.downloadFile()
        }else if(self.player.isPlaying()){
            self.pause()
        }else if(!self.player.isPlaying()){
            self.play()
        }else{
            self.stateLoad()
            self.downloadFile()
        }
    }
    
    func play(){
        self.playButton.setImage(#imageLiteral(resourceName: "player_pause_button"), for: .normal)
        self.fileLoadingIndicator.stopAnimating()
        player.play()
        
       let hourOfTheDay = Calendar.current.component(.hour, from: Date())
       FIRAnalytics.logEvent(withName: "press_play", parameters: [kFIRParameterValue: hourOfTheDay as NSObject])
        
    }
    
    func pause(){
        self.playButton.setImage(#imageLiteral(resourceName: "player_play_button"), for: .normal)
        player.pause()
    }
    
    func reset(){
        self.player.reset()
        self.playButton.setImage(#imageLiteral(resourceName: "player_play_button"), for: .normal)
        self.player = Player()
        self.player.setDuration(duration: content.duration)
        self.player.delegate = self
    }
    

    
    /*------------------------------------------------------------------------
     --------------------Downlaod Functions-------------------------------
     ------------------------------------------------------------------------*/
    
    
    //Load audio file from server and starts playing
    func downloadFile(){
        Alamofire.request(content.url).response { response in
            debugPrint(response)
            if let data = response.data {
                self.player.setFile(data: data)
                self.play()
            }else{
                //TODO error handling hhtp request
            }
        }
    }
    
    //Load picture from server
    func downloadPicture(){
        Alamofire.request(content.portrait).response { response in
            debugPrint(response)
            if let data = response.data {
                self.portraitImageView.image = UIImage(data: data)
            }else{
                //TODO error handling hhtp request
            }
        }
    }

    

    /*------------------------------------------------------------------------
     ---------------------------Actions--------------------------------------
     ------------------------------------------------------------------------*/

    
    //Player interactions
    @IBAction func heartDidTouch(_ sender: AnyObject) {
        if(liked == false){
            heartButton.setImage(#imageLiteral(resourceName: "player_heart_full"), for: .normal)
            liked = true
            FIRAnalytics.logEvent(withName: "like", parameters: nil)
        }else{
            heartButton.setImage(#imageLiteral(resourceName: "player_heart_empty"), for: .normal)
            liked = false
        }
    }
    
    @IBAction func replayDidTouch(_ sender: AnyObject) {
        if(player.isInitialized()){
            self.reset()
            self.start()
        }else{
            playButton.setImage(#imageLiteral(resourceName: "player_empty_button"), for: .normal)
            fileLoadingIndicator.startAnimating()
        }
    }
    
    @IBAction func playDidTouch(_ sender: AnyObject) {
        if(!player.isInitialized()){
            playButton.setImage(#imageLiteral(resourceName: "player_empty_button"), for: .normal)
            fileLoadingIndicator.startAnimating()
        }else if(self.player.isPlaying()){
            pause()
        }else if(!self.player.isPlaying()){
            play()
        }else{
            playButton.setImage(#imageLiteral(resourceName: "player_empty_button"), for: .normal)
            fileLoadingIndicator.startAnimating()
        }
    }
}
