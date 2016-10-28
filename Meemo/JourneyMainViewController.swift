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
    let playerSegueIdentifier:String = "showPlayer"
    var scrollViewController:JourneyViewController! = nil
    
    var content:Content = Content()
    
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

    //FirebaseSynchronizerDelegate func fires when content got sync and parsed
    func firebaseDidReceiveJourney(journeyContent: [Content]){
        self.scrollViewController.setProgramContent(programContent: journeyContent)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let segueName:String = segue.identifier!;
        
        if(segueName ==  scrollViewidentifier){
            //capture embed segue to grab the JourneyViewController instance
            self.scrollViewController = segue.destination as! JourneyViewController
            scrollViewController.delegate = self

        }else if(segueName == playerSegueIdentifier){
            //capture showPlayer segue to pass the clicked content data
            let viewController:ViewController = segue.destination as! ViewController
            viewController.content = self.content
        }
    }
    
    //JourneyDelegate func which passes the clicked content
    func playDidTouch(content:Content){
        self.content = content
        performSegue(withIdentifier: playerSegueIdentifier, sender: nil)
    }
}
