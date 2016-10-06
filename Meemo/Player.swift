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
}

class Player{
    var player: AVAudioPlayer!
    
    func setFile(file: Data){
        
    }
    
    func setDuration(duration: Int){
        
    }
    
    func play(){
        
    }
    
    func pause(){
        
    }
    
    func isPlaying(){
    
    }
    
    func getSecondsRemaining() -> String{
        return ""
    }
    
    func getMinutesRemaining() -> String{
        return ""
    }
}
