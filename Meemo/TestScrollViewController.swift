//
//  TestScrollViewController.swift
//  Meemo
//
//  Created by Daniel Lohse on 11/12/16.
//  Copyright © 2016 Superstudio. All rights reserved.
//

import UIKit

class TestScrollViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        label.text = "asdasd  asdasd as asd asd asd asd asd asd asd asd asd asd asd aas asd asd asd asd asd asd asd asd asd asd asd aas asd asd asd asd asd asd asd asd asd asd asd aas asd asd asd asd asd asd asd asd asd asd asd aas asd asd asd asd asd asd asd asd asd asd asd aas asd asd asd asd asd asd asd asd asd asd asd aas asd asd asd asd asd asd asd asd asd asd asd aas asd asd asd asd asd asd asd asd asd asd asd aas asd asd asd asd asd asd asd asd asd asd asd aas asd asd asd asd asd asd asd asd asd asd asd a"
        
        label.sizeToFit()
        scrollView.contentSize.height = 1000
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
