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
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        scrollView.contentSize.height = 1000
        let bottomOffset: CGPoint = CGPoint(x: 0, y: self.scrollView.contentSize.height);
        scrollView.setContentOffset(bottomOffset, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func didReceiveMemoryWarning() {
    }

}
