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
        FIRAnalytics.logEvent(withName: "life_section_stress", parameters: nil)
    }
    
    @IBAction func lifeGoalDidTouch(_ sender: AnyObject) {
        FIRAnalytics.logEvent(withName: "life_section_life_goal", parameters: nil)
    }
    @IBAction func habitDidTouch(_ sender: AnyObject) {
        FIRAnalytics.logEvent(withName: "life_section_habit", parameters: nil)
    }
    @IBAction func relationDidTouch(_ sender: AnyObject) {
        FIRAnalytics.logEvent(withName: "life_section_relationship", parameters: nil)
    }

    @IBAction func careerDidTouch(_ sender: AnyObject) {
        FIRAnalytics.logEvent(withName: "life_section_career", parameters: nil)
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
