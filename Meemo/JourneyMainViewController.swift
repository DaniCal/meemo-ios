//
//  JourneyMainViewController.swift
//  Meemo
//
//  Created by Daniel Lohse on 10/25/16.
//  Copyright © 2016 Superstudio. All rights reserved.
//

import UIKit

class JourneyMainViewController: UIViewController {

    let scrollViewidentifier:String = "scrollView_embed"
    var scrollViewController:JourneyViewController! = nil
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let segueName:String = segue.identifier!;
        if(segueName ==  scrollViewidentifier){
            self.scrollViewController = segue.destination as! JourneyViewController
        }
    }
    

}
