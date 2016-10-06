//
//  Player.swift
//  Meemo
//
//  Created by Daniel Lohse on 10/6/16.
//  Copyright © 2016 Superstudio. All rights reserved.
//

import Foundation
import AVFoundation


@objc protocol PlayerDelegate{
    @objc optional func playerDidFinishPlaying()
    @objc optional func playerErrorDidOccur()
    @objc optional func playerFileErrorDidOccur()
    @objc optional func playerUpdateTime(timeLeft: String)
}

class Player: NSObject, AVAudioPlayerDelegate{
    var player: AVAudioPlayer!
    var delegate:PlayerDelegate?
    var duration:Int!
    var timer = Timer.init()

    
    override init(){
        super.init()
        self.setOptions()
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool){
        self.player = nil
        timer.invalidate()
        self.delegate?.playerDidFinishPlaying!()
    }
    
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?){
        self.delegate?.playerErrorDidOccur!()
    }
    
    func setOptions(){
        do{
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
        }catch{
            //TODO error handling
        }
    }
    
    func isInitialized()-> Bool{
        if(player == nil){
            return false
        }else{
            return true
        }
    }
    
    func setFile(data: Data){
        do{
            self.player = try AVAudioPlayer(data: data, fileTypeHint: "mp3")
            self.player.delegate = self
        }
        catch{
            //TODO error hanlding creating AVAudioPlayer object with raw data
        }

    }
    
    func setDuration(duration: Int){
        self.duration = duration
    }
    
    
    
    func play(){
        if(self.player != nil){
            self.player.play()
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(Player.updateTime), userInfo: nil,repeats: true)
        }
    }
    
    func updateTime(){
        let duration: Int = self.duration
        let currentTime: Int =  Int(self.player.currentTime)
        let timeLeft: Int = duration - currentTime
        let timeLeftInMinutes = Int(timeLeft/60)
        let timeLeftInSeconds:Int = Int(timeLeft - (timeLeftInMinutes * 60))
        let timeLeftString:String = "\(transformTo2Digits(number: timeLeftInMinutes)):\(transformTo2Digits(number: timeLeftInSeconds))"
        self.delegate?.playerUpdateTime!(timeLeft: timeLeftString)
        
    }
    
    func transformTo2Digits(number: Int) -> String{
        if(number < 10){
            return String("0\(number)")
        }else{
            return String("\(number)")
        }
    }
    
    func pause(){
        if(self.player != nil){
            self.player.pause()
            timer.invalidate()
        }
    }
    
    func reset(){
        self.pause()
        player = nil
    }
    
    func isPlaying() -> Bool{
        if(player != nil){
            return self.player.isPlaying
        }else{
            return false
        }
    }
    
    func getSecondsRemaining() -> String{
        return ""
    }
    
    func getMinutesRemaining() -> String{
        return ""
    }
}
