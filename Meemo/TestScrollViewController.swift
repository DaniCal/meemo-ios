//
//  TestScrollViewController.swift
//  Meemo
//
//  Created by Daniel Lohse on 11/12/16.
//  Copyright © 2016 Superstudio. All rights reserved.
//

import UIKit

class TestScrollViewController: UIViewController {

    @IBAction func crossDidTouch(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: {() -> Void in
            
        })        
    }
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var readMoreButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        label.text = "The most successful people share one secret. They constantly train their mind. Your mindset is a powerful thing and with regular food for thought you can stimulate it to make you perform better, faster and more efficient. Enjoy this daily mental push-up and get inspired by the world’s thought leaders."
        
        
        authorLabel.text = "The most successful people share one secret. They constantly train their mind. Your mindset is a powerful thing and with regular food for thought you can stimulate it to make you perform better, faster and more efficient. Enjoy this daily mental push-up and get inspired by the world’s thought leaders."
        
        authorLabel.sizeToFit()
        label.sizeToFit()
        scrollView.contentSize.height = 1000
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        scrollView.contentSize.height = readMoreButton.frame.origin.y + readMoreButton.frame.height + 20
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
