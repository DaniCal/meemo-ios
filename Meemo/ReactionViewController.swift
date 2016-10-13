//
//  ReationViewController.swift
//  Meemo
//
//  Created by Daniel Lohse on 10/13/16.
//  Copyright © 2016 Superstudio. All rights reserved.
//

import UIKit
import Firebase


class ReactionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func rockinDidTouch(_ sender: AnyObject) {
        FIRAnalytics.logEvent(withName: "press_reaction", parameters: ["emotion": "rockin the day" as NSString])
    }
    
    @IBAction func downDidTouch(_ sender: AnyObject) {
        FIRAnalytics.logEvent(withName: "press_reaction", parameters: ["emotion": "totally down" as NSString])
    }
    
    @IBAction func kickAssDidTouch(_ sender: AnyObject) {
        FIRAnalytics.logEvent(withName: "press_reaction", parameters: ["emotion": "ready to kick asses" as NSString])
    }
    
    @IBAction func notSeriousDidTouch(_ sender: AnyObject) {
        FIRAnalytics.logEvent(withName: "press_reaction", parameters: ["emotion": "can't take this serious" as NSString])

    }
    
    @IBAction func brainwashDidTouch(_ sender: AnyObject) {
        FIRAnalytics.logEvent(withName: "press_reaction", parameters: ["emotion": "are you trying to brainwash me?g" as NSString])

    }
}
