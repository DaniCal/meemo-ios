//
//  SessionViewController.swift
//  Meemo
//
//  Created by Daniel Lohse on 11/11/16.
//  Copyright © 2016 Superstudio. All rights reserved.
//

import UIKit

class SessionViewController: UIViewController {

    @IBOutlet weak var descriptionLabel: UILabel!

    @IBOutlet weak var scrollView: UIScrollView!

    
    var desc:String = "The most successful people share one secret. They constantly train their mind. Your mindset is a powerful thing and with regular food for thought you can stimulate it to make you perform better, faster and more efficient. Enjoy this daily mental push-up and get inspired by  successful people share one secret. They constantly train their mind. Your mindset is a powerful thing and with regular food for thought you can stimulate it to make you perform better, faster and more efficient. Enjoy this daily mental push-up and get inspired by the worlds thought lead the worlds thought leaders."
    
    
    @IBAction func crossDidTouch(_ sender: AnyObject) {
        
        self.dismiss(animated: true, completion: {() -> Void in
        
        })
    }
    
//    
//    func heightForView(text:String, #font:UIFont, #width:CGFloat) -> CGFloat{
//        let label:UILabel = UILabel(frame: CGRectMake(0, 0, width, CGFloat.max))
//        label.numberOfLines = 0
//        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
//        label.font = font
//        label.text = text
//        
//        label.sizeToFit()
//        return label.frame.height
//    }
//    
  

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionLabel.text = desc
        descriptionLabel.sizeToFit()
        scrollView.contentSize.height = 1000
        
        
//        var height = heightForView(description, font: font, width: 100.0)
        
//        descriptionLabel.text = desc
//        descriptionLabel.heigh
        
        
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        appDelegate.navigationController?.setNavigationBarHidden(false, animated: true)

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
