//
//  TestScrollViewController.swift
//  Meemo
//
//  Created by Daniel Lohse on 11/12/16.
//  Copyright © 2016 Superstudio. All rights reserved.
//

import UIKit
import Alamofire

class TestScrollViewController: UIViewController, PlayerDelegate{
    @IBOutlet weak var loaderAnimation: UIActivityIndicatorView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var listenButton: UIButton!
    

    @IBOutlet weak var biographyLabel: UILabel!
    @IBOutlet weak var playerPicture: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var readMoreButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var session:Session!
    var program:Program!
    var dailyPushUp:DailyPushUp!
    var pushUp = false

    var player:Player = Player()

    /*------------------------------------------------------------------------
        --------------------PlayerDelegate Functions------------------------------
    ------------------------------------------------------------------------*/
    
    func playerDidFinishPlaying(){
//        self.playButton.setImage(#imageLiteral(resourceName: "player_play_button"), for: .normal)
//        FIRAnalytics.logEvent(withName: "finished_play", parameters: nil)
//        timerTextView.text = ""
//        performSegue(withIdentifier: "showreactionview", sender: self)
    }
    
    func playerErrorDidOccur(){
    }
    
    func playerFileErrorDidOccur(){
    }
    
    func playerUpdateTime(timeLeft: String){
        self.timeLabel.text = timeLeft
    }

    
    /*------------------------------------------------------------------------
     --------------------UI Functions-------------------------------
     ------------------------------------------------------------------------*/
    
    func initUI(){
        player.setDuration(duration: Int(self.session.time)!)
        self.timeLabel.text = player.getDurationString()
    }
    
    func stateLoad(){
        listenButton.setImage(#imageLiteral(resourceName: "session_listen_empty"), for: .normal)
        loaderAnimation.startAnimating()
    }
    
    func statePause(){
        self.listenButton.setImage(#imageLiteral(resourceName: "session_listen_empty"), for: .normal)
        self.loaderAnimation.stopAnimating()
    }
    
    func statePlay(){
        self.listenButton.setImage(#imageLiteral(resourceName: "session_pause_button"), for: .normal)
        self.loaderAnimation.stopAnimating()
    }
    

    
    @IBAction func crossDidTouch(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: {() -> Void in
            self.reset()
        })
    }
    
    /*------------------------------------------------------------------------
     --------------------Player Functions-------------------------------
     ------------------------------------------------------------------------*/
    
    func start(){
        if(!player.isInitialized()){
            //Load file from server and init Player instance
            self.stateLoad()
            if(!pushUp){
                if(self.session.fileData == nil){
                    self.downloadFile()
                }else{
                    play(data: self.session.fileData)
                }
            }else{
                if(self.dailyPushUp.fileData == nil){
                    self.downloadFile()
                }else{
                    play(data: self.dailyPushUp.fileData)
                }
            }
            
            
        }else if(self.player.isPlaying()){
            self.pause()
        }else if(!self.player.isPlaying()){
            //self.play()
        }else{
            self.stateLoad()
            if(self.session.fileData == nil){
                self.downloadFile()
            }else{
                play(data: self.session.fileData)
            }
        }
    }
    
    func play(data:Data){
        self.session.fileData = data
        self.player.setFile(data: data)
        self.listenButton.setImage(#imageLiteral(resourceName: "session_pause_button"), for: .normal)
        self.loaderAnimation.stopAnimating()
        player.play()

//        let hourOfTheDay = Calendar.current.component(.hour, from: Date())
//        FIRAnalytics.logEvent(withName: String("press_play_" + String(hourOfTheDay)), parameters: nil)
        
    }
    
    func continuePlaying(){
        self.listenButton.setImage(#imageLiteral(resourceName: "session_pause_button"), for: .normal)
        self.loaderAnimation.stopAnimating()
        player.play()
    }
    
    func pause(){
        self.listenButton.setImage(#imageLiteral(resourceName: "session_play_button"), for: .normal)
        player.pause()
    }
    
    func reset(){
        self.player.reset()
        self.listenButton.setImage(#imageLiteral(resourceName: "session_play_button"), for: .normal)
        self.player = Player()
//        //self.player.setDuration(duration: content.duration)
        self.player.delegate = self
    }

    /*------------------------------------------------------------------------
     --------------------Downlaod Functions-------------------------------
     ------------------------------------------------------------------------*/
    
    func downloadFile(){
        Alamofire.request(session.file).response { response in
            debugPrint(response)
            if let data = response.data {
                if(self.pushUp){
                    self.dailyPushUp.fileData = data
                }else{
                    self.session.fileData = data
                }
                
                
                self.play(data:data)
            }else{
                //TODO error handling hhtp request
            }
        }
    }

    
    func loadPlayerPicture(){
        Alamofire.request(self.program.picturePlayer).response { response in
            debugPrint(response)
            if let data = response.data {
                self.program.picturePlayerData = data
                self.playerPicture.image = UIImage(data: data)
            }else{
                //TODO error handling hhtp request
            }
        }
    }
    
    
    @IBAction func listenDidTouch(_ sender: AnyObject) {
                if(!player.isInitialized()){
                    listenButton.setImage(#imageLiteral(resourceName: "session_listen_empty"), for: .normal)
                    loaderAnimation.startAnimating()
                    start()
                }else if(self.player.isPlaying()){
                    pause()
                }else if(!self.player.isPlaying()){
                    continuePlaying()
                }else{
                    listenButton.setImage(#imageLiteral(resourceName: "session_listen_empty"), for: .normal)
                    loaderAnimation.startAnimating()
                }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if(session != nil){
            authorLabel.text = session.author
            titleLabel.text = session.title
            timeLabel.text = session.time
            
            descriptionLabel.text = session.desc
            descriptionLabel.sizeToFit()
            
            biographyLabel.text = session.biography
            biographyLabel.sizeToFit()
            
            if(program.picturePlayerData == nil){
                loadPlayerPicture()
            }else{
                self.playerPicture.image = UIImage(data: program.picturePlayerData)
            }
            
        }
        
        self.player.delegate = self
        initUI()
//        start()
//        
//        
//        
//        label.text = "The most successful people share one secret. They constantly train their mind. Your mindset is a powerful thing and with regular food for thought you can stimulate it to make you perform better, faster and more efficient. Enjoy this daily mental push-up and get inspired by the world’s thought leaders."
//        
//        
//        authorLabel.text = "The most successful people share one secret. They constantly train their mind. Your mindset is a powerful thing and with regular food for thought you can stimulate it to make you perform better, faster and more efficient. Enjoy this daily mental push-up and get inspired by the world’s thought leaders."
//        
//        authorLabel.sizeToFit()
//        label.sizeToFit()
//        scrollView.contentSize.height = 1000
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        scrollView.contentSize.height = readMoreButton.frame.origin.y + readMoreButton.frame.height + 20
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
