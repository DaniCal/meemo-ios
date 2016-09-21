//
//  ViewController.swift
//  Meemo
//
//  Created by Daniel Lohse on 9/21/16.
//  Copyright © 2016 Superstudio. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    
    var sound: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()

        
     
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func playButtonClick(_ sender: AnyObject) {
//        var bombSoundEffect: AVAudioPlayer!

        
        
        do {
            let path = Bundle.main.path(forResource: "sound", ofType: "mp3")!
            let url = URL(fileURLWithPath: path)
            sound = try AVAudioPlayer(contentsOf: url)

            sound.play()
        } catch {
            // couldn't load file :(
        }
    }

}

