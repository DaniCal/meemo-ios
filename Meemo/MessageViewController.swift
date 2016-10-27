//
//  MessageViewController.swift
//  Meemo
//
//  Created by Daniel Lohse on 10/27/16.
//  Copyright © 2016 Superstudio. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController {

    @IBAction func readMoreDidTouch(_ sender: AnyObject) {
        if let url = URL(string: "http://joinmeemo.com") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }        }
    }
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
