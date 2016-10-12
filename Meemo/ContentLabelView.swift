//
//  ContentLabelView.swift
//  Meemo
//
//  Created by Daniel Lohse on 10/12/16.
//  Copyright © 2016 Superstudio. All rights reserved.
//

import UIKit

class ContentLabelView: UIView {

    @IBOutlet var view: UIView!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        Bundle.main.loadNibNamed("ContentLabelView", owner: self, options: nil)
        self.addSubview(self.view)
    }
}
