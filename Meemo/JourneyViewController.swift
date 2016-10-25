//
//  JourneyViewController.swift
//  Meemo
//
//  Created by Daniel Lohse on 10/12/16.
//  Copyright © 2016 Superstudio. All rights reserved.
//

import Foundation
import UIKit

class JourneyViewController: UIViewController{

    
    @IBOutlet weak var day5: UIView!
    @IBOutlet weak var day4: UIView!
    @IBOutlet weak var day7: UIView!
    @IBOutlet weak var day6: UIView!
    @IBOutlet weak var day3: UIView!
    @IBOutlet weak var day2: UIView!
    @IBOutlet weak var day1: UIView!
    
    
    let day1Identifier:String = "day1_embed"
    let day2Identifier:String = "day2_embed"
    let day3Identifier:String = "day3_embed"
    let day4Identifier:String = "day4_embed"
    let day5Identifier:String = "day5_embed"
    let day6Identifier:String = "day6_embed"
    let day7Identifier:String = "day7_embed"
    
    
    
    var day1ViewController: JourneyBoxViewController! = nil
    var day2ViewController: JourneyBoxViewController! = nil
    var day3ViewController: JourneyBoxViewController! = nil
    var day4ViewController: JourneyBoxViewController! = nil
    var day5ViewController: JourneyBoxViewController! = nil
    var day6ViewController: JourneyBoxViewController! = nil
    var day7ViewController: JourneyBoxViewController! = nil

    
    var programDaysViewController = [JourneyBoxViewController?](repeating: nil, count: 7)
    var programContent: [Content]! = []
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        scrollView.contentSize.height = 1000
        let bottomOffset: CGPoint = CGPoint(x: 0, y: self.scrollView.contentSize.height);
        scrollView.setContentOffset(bottomOffset, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool){
    }
    
    override func didReceiveMemoryWarning() {
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let segueName:String = segue.identifier!;
        switch(segueName){
        case self.day1Identifier:
            programDaysViewController[0] = segue.destination as! JourneyBoxViewController
            day1ViewController = segue.destination as! JourneyBoxViewController
            break
        case self.day2Identifier:
            day2ViewController = segue.destination as! JourneyBoxViewController
            break
        case self.day3Identifier:
            day3ViewController = segue.destination as! JourneyBoxViewController
            break
        case self.day4Identifier:
            day4ViewController = segue.destination as! JourneyBoxViewController
            break
        case self.day5Identifier:
            day5ViewController = segue.destination as! JourneyBoxViewController
            break
        case self.day6Identifier:
            day6ViewController = segue.destination as! JourneyBoxViewController
            break
        case self.day7Identifier:
            day7ViewController = segue.destination as! JourneyBoxViewController
            break
        default:
            break
        }
    }
    
    func setProgramContent(programContent: [Content]){
        self.programContent = programContent
        initDayContent(day: self.day1ViewController, content: self.programContent[0])
        initDayContent(day: self.day2ViewController, content: self.programContent[1])
        initDayContent(day: self.day3ViewController, content: self.programContent[2])
        initDayContent(day: self.day4ViewController, content: self.programContent[3])
        initDayContent(day: self.day5ViewController, content: self.programContent[4])
        initDayContent(day: self.day6ViewController, content: self.programContent[5])
        initDayContent(day: self.day7ViewController, content: self.programContent[6])
    }
    
    func initDayContent(day: JourneyBoxViewController, content: Content){
        day.setContent(content: content)
    }
}
