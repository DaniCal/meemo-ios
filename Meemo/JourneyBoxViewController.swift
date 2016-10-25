//
//  JourneyBoxViewController.swift
//  Meemo
//
//  Created by Daniel Lohse on 10/24/16.
//  Copyright © 2016 Superstudio. All rights reserved.
//

import UIKit

class JourneyBoxViewController: UIViewController {

    @IBOutlet weak var boxImage: UIImageView!
    @IBOutlet weak var boxAuthor: UILabel!
    @IBOutlet weak var boxTitle: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    override func viewDidAppear(_ animated: Bool) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    func setTitle(title: String){
        if(boxTitle != nil){
            boxTitle.text = title
        }
    }

    

}
