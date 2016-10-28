//
//  MessageViewController.swift
//  Meemo
//
//  Created by Daniel Lohse on 10/27/16.
//  Copyright © 2016 Superstudio. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController {
    
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var messageLabel: UITextView!
    var content:Content = Content()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageLabel.text = content.message
        doneButton.setTitle(content.button, for: .normal)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Opens url in Browser
    func openURLLink(){
        if let url = URL(string: content.link) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    @IBAction func readMoreDidTouch(_ sender: AnyObject) {
        openURLLink()
    }
}
