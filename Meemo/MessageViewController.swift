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
