//
//  JourneyMainViewController.swift
//  Meemo
//
//  Created by Daniel Lohse on 10/25/16.
//  Copyright © 2016 Superstudio. All rights reserved.
//

import UIKit

class JourneyMainViewController: UIViewController,JourneyDelegate, FirebaseSynchornizeDelegate{

    let scrollViewidentifier:String = "scrollView_embed"
    var scrollViewController:JourneyViewController! = nil
    
    
    
    //TestData
    
    let day1Content:Content! = Content()
    let day2Content:Content! = Content()
    let day3Content:Content! = Content()
    let day4Content:Content! = Content()
    let day5Content:Content! = Content()
    let day6Content:Content! = Content()
    let day7Content:Content! = Content()

    
    func playDidTouch(){
        performSegue(withIdentifier: "showPlayer", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FirebaseSynchronizer.delegate = self

        FirebaseSynchronizer.subscribeToJourney()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }

    func firebaseDidRevceiveJourney(journeyContent: [Content]){
        self.scrollViewController.setProgramContent(programContent: journeyContent)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Initializing test data
        //...
        day1Content.quote = "Day 1"
        day1Content.author = "Leon Mueller"
        day2Content.quote = "Day 2"
        day2Content.author = "Leon Mueller"
        day3Content.quote = "Day 3"
        day3Content.author = "Leon Mueller"
        day4Content.quote = "Day 4"
        day4Content.author = "Leon Mueller"
        day5Content.quote = "Day 5"
        day5Content.author = "Leon Mueller"
        day6Content.quote = "Day 6"
        day6Content.author = "Leon Mueller"
        day7Content.quote = "Day 7"
        day7Content.author = "Leon Mueller"
        
        
        let segueName:String = segue.identifier!;
        if(segueName ==  scrollViewidentifier){
            self.scrollViewController = segue.destination as! JourneyViewController
            scrollViewController.delegate = self

        }
    }
    

}
