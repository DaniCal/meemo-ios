//
//  JourneyBoxView.swift
//  Meemo
//
//  Created by Daniel Lohse on 10/21/16.
//  Copyright © 2016 Superstudio. All rights reserved.
//

import UIKit

class JourneyBoxView: UIView {
    @IBOutlet var journeyBoxView: UIView!

    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        Bundle.main.loadNibNamed("JourneyBoxView", owner: self, options: nil)
        let constraint = NSLayoutConstraint(item: journeyBoxView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)

        
        self.journeyBoxView.addConstraint(constraint)
        self.addSubview(self.journeyBoxView)

    }


}
