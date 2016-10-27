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
//    var contentManager: ContentManager = ContentManager()
    let testURL = "https://storage.googleapis.com/meemo/tomorrow.mp3"
    
    //ContentManagerDelegate func (protocol definition in ContentManager.swift)
//    func contentDidUpdate(){
//        self.quoteTextView.text = contentManager.content.quote
//        self.authorTextView.text = contentManager.content.author
//        self.player.setDuration(duration: contentManager.content.duration)
//        self.timerTextView.text = player.getDurationString()
//        
//    }
    
//    func fileDidUpdate(){
////        self.player.reset()
////        self.playButton.setImage(#imageLiteral(resourceName: "player_play_button"), for: .normal)
//    }
    
//    func fileDidLoad(){
//        player.setFile(data: self.contentManager.content.file)
//        play()
//    }
    
    
//    func pictureDidLoad(){
//        portraitImageView.image = UIImage(data: self.contentManager.content.picture)
//    }
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Initializing test data
        
        let segueName:String = segue.identifier!;
        if(segueName ==  "goBack"){
            self.player.pause()
            self.playButton.setImage(#imageLiteral(resourceName: "player_play_button"), for: .normal)
            self.player = Player()
        }else if(segueName == "showreactionview"){
            let reactionViewController:ReactionViewController = segue.destination as! ReactionViewController
            reactionViewController.content = self.content
        }
    }

    
    //ControllerDelegate func
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.player.delegate = self
//        self.contentManager.delegate = self
        self.quoteTextView.text = content.quote
        self.authorTextView.text = content.author
        self.player.setDuration(duration: content.duration)
        self.timerTextView.text = player.getDurationString()
        downloadPicture()
        start()
        
        
        
    }
    
    func start(){
        if(!player.isInitialized()){
            playButton.setImage(#imageLiteral(resourceName: "player_empty_button"), for: .normal)
            fileLoadingIndicator.startAnimating()
            downloadFile(url: testURL)
        }else if(self.player.isPlaying()){
            pause()
        }else if(!self.player.isPlaying()){
            play()
        }else{
            playButton.setImage(#imageLiteral(resourceName: "player_empty_button"), for: .normal)
            fileLoadingIndicator.startAnimating()
            downloadFile(url: testURL)
        }

    }
    
    func downloadFile(url: String){
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

    
    override func viewDidAppear(_ animated: Bool) {

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
            FIRAnalytics.logEvent(withName: "like", parameters: nil)
        }else{
            heartButton.setImage(#imageLiteral(resourceName: "player_heart_empty"), for: .normal)
            liked = false
        }
    }
    
    @IBAction func replayDidTouch(_ sender: AnyObject) {
        if(player.isInitialized()){
            self.player.reset()
//            player.setFile(data: self.contentManager.content.file)
            play()
        }else{
            playButton.setImage(#imageLiteral(resourceName: "player_empty_button"), for: .normal)
            fileLoadingIndicator.startAnimating()
//            self.contentManager.downloadFile()
        }
    }
    
    @IBAction func playDidTouch(_ sender: AnyObject) {
        if(!player.isInitialized()){
            playButton.setImage(#imageLiteral(resourceName: "player_empty_button"), for: .normal)
            fileLoadingIndicator.startAnimating()
//            self.contentManager.downloadFile()
        }else if(self.player.isPlaying()){
            pause()
        }else if(!self.player.isPlaying()){
            play()
        }else{
            playButton.setImage(#imageLiteral(resourceName: "player_empty_button"), for: .normal)
            fileLoadingIndicator.startAnimating()
//            self.contentManager.downloadFile()
        }
    }
}
