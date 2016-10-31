//
//  LifeSectionViewController.swift
//  Meemo
//
//  Created by Daniel Lohse on 10/31/16.
//  Copyright © 2016 Superstudio. All rights reserved.
//

import UIKit
import Firebase

class LifeSectionViewController: UIViewController {
    @IBAction func stresstDidTouch(_ sender: AnyObject) {
        FIRAnalytics.logEvent(withName: "life_section", parameters: [kFIRParameterValue: "stress" as NSString])
    }
    
    @IBAction func lifeGoalDidTouch(_ sender: AnyObject) {
        FIRAnalytics.logEvent(withName: "life_section", parameters: [kFIRParameterValue: "life_goal" as NSString])
    }
    @IBAction func habitDidTouch(_ sender: AnyObject) {
        FIRAnalytics.logEvent(withName: "life_section", parameters: [kFIRParameterValue: "habit" as NSString])
    }
    @IBAction func relationDidTouch(_ sender: AnyObject) {
        FIRAnalytics.logEvent(withName: "life_section", parameters: [kFIRParameterValue: "relationship" as NSString])
    }

    @IBAction func careerDidTouch(_ sender: AnyObject) {
        FIRAnalytics.logEvent(withName: "life_section", parameters: [kFIRParameterValue: "careerg" as NSString])
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
