//
//  Player.swift
//  Meemo
//
//  Created by Daniel Lohse on 10/6/16.
//  Copyright © 2016 Superstudio. All rights reserved.
//
//  The Player class contains all necessary functionalities and configurations to play
//  a MP3 audio file and giving useful information about it
//
//

import Foundation
import AVFoundation


@objc protocol PlayerDelegate{
    @objc optional func playerDidFinishPlaying()
    @objc optional func playerErrorDidOccur(_: String)
    @objc optional func playerFileErrorDidOccur(_: String)
    @objc optional func playerUpdateTime(timeLeft: String)
}

class Player: NSObject, AVAudioPlayerDelegate{
    var player: AVAudioPlayer!
    var delegate:PlayerDelegate?
    var duration:Int!
    var timer = Timer.init()

    
    //----------------------INIT Functions--------------------------------------

    override init(){
        super.init()
        self.setOptions()
    }
    
    //Audio player options
    func setOptions(){
        do{
            //Audio file keeps playing when app goes into background mode
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
        }catch{
            self.delegate?.playerErrorDidOccur!("Error while setting AVAudioSession options")
        }
    }
    
    //----------------------AVAudioPLayerDelegate--------------------------------------
    
    //Event fires when audio file has finished playing
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool){
        self.player = nil
        timer.invalidate()
        self.delegate?.playerDidFinishPlaying!()
    }
    
    //Event fires when a decoding error occured within the AVAudioPlayer instance
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?){
        self.delegate?.playerErrorDidOccur!("Error while decoding audio file")
    }
    

    //----------------------Main Functions--------------------------------------
    
    //Start playing the passed audio file and schedules a timer to update the player's clock
    func play(){
        if(self.player != nil){
            self.player.play()
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(Player.updateTime), userInfo: nil,repeats: true)
        }
    }

    //Pauses the currently played audio file and disbaled the scheduled timer
    func pause(){
        if(self.player != nil){
            self.player.pause()
            timer.invalidate()
        }
    }
    
    //Resets the player instance by giving it a nil value
    func reset(){
        self.pause()
        player = nil
    }
    
    
    //Event is fired by scheduled timer to update the time left and pass to the delegate protocol
    func updateTime(){
        let timeLeft: Int = calculateTimeLeft()
        let timeLeftInMinutes = Int(timeLeft/60)
        let timeLeftInSeconds:Int = Int(timeLeft - (timeLeftInMinutes * 60))
        let timeLeftString:String = "\(transformTo2Digits(number: timeLeftInMinutes)):\(transformTo2Digits(number: timeLeftInSeconds))"
        self.delegate?.playerUpdateTime!(timeLeft: timeLeftString)
        
    }
    
    
    //----------------------GET Functions--------------------------------------

    func isPlaying() -> Bool{
        if(player != nil){
            return self.player.isPlaying
        }else{
            return false
        }
    }
    
    //Check if AVAudioPlayer instance has been initilialized
    func isInitialized()-> Bool{
        if(player == nil){
            return false
        }else{
            return true
        }
    }
    
    //----------------------SET Functions--------------------------------------

    
    //To make the duration safely available it can be passed through this function
    func setDuration(duration: Int){
        self.duration = duration
    }
    
    //Initializing the AVAudioPlayer instance with the raw data
    func setFile(data: Data){
        do{
            self.player = try AVAudioPlayer(data: data, fileTypeHint: "mp3")
            self.player.delegate = self
        }
        catch{
            self.delegate?.playerFileErrorDidOccur!("Error while initializing AVAudioPlayer instance")
        }
        
    }

    //----------------------HELP Functions--------------------------------------

    func calculateTimeLeft() -> Int{
        let duration: Int = self.duration
        let currentTime: Int =  Int(self.player.currentTime)
        let timeLeft: Int = duration - currentTime
        return timeLeft
    }
    
    func transformTo2Digits(number: Int) -> String{
        if(number < 10){
            return String("0\(number)")
        }else{
            return String("\(number)")
        }
    }
}
