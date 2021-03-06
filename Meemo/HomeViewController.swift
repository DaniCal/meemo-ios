//
//  HomeViewController.swift
//  Meemo
//
//  Created by Daniel Lohse on 11/11/16.
//  Copyright © 2016 Superstudio. All rights reserved.
//

import UIKit
import Alamofire
import Mixpanel


class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var navItem: UINavigationItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pushUpPicture: UIImageView!

    var content:Content!

    let programSegueIdentifier = "goToProgram"
    let pushupSegueIdentifier = "goToPushUp"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadContentInstance()
        loadPushupPicture()
        hideNavigationBar()
    }
    
    func loadContentInstance(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.content = appDelegate.content
    }
    
    func loadPushUpPicture(){
        if(content.dailyPushUp.pictureOverviewData == nil){
            loadPushupPicture()
        }else{
            self.pushUpPicture.image = UIImage(data: content.dailyPushUp.pictureOverviewData)
        }
    }
    
    
    func hideNavigationBar(){
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //Triggers when segues to ProgramView
        if  segue.identifier == programSegueIdentifier,
            let destination = segue.destination as? ProgramViewController,
            let blogIndex = tableView.indexPathForSelectedRow?.row
        {
            destination.program = content.programs[blogIndex]
            Mixpanel.sharedInstance().track("program_entered", properties: ["name" : content.programs[blogIndex].title])

        }
        
        
        //Trigger when segues to Player (incl Pushup Data)
        if  segue.identifier == pushupSegueIdentifier,
            let destination = segue.destination as? PlayerScrollViewController
        {
            
            //TODO: Refactor! Integrate DailyPush into the Session format  
            let session = Session()
            session.title = content.dailyPushUp.title
            session.author = content.dailyPushUp.author
            session.desc = content.dailyPushUp.desc
            session.biography = content.dailyPushUp.biography
            session.time = content.dailyPushUp.time
            session.file = content.dailyPushUp.file
            session.readMore = content.dailyPushUp.readMore
            destination.session = session
            content.dailyPushUp.program.picturePlayer = content.dailyPushUp.picturePlayer
            destination.program = content.dailyPushUp.program
            destination.dailyPushUp = content.dailyPushUp
            destination.pushUp = true
            
            Mixpanel.sharedInstance().track("pushup_entered", properties: ["name" : session.title])

        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content.programs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "programCell", for: indexPath) as! ProgramTableViewCell
        cell.setTitle(content.programs[indexPath.row].title)
        cell.setSubtitle(content.programs[indexPath.row].subtitle)
        if(content.programs[indexPath.row].pictureSquareData == nil){
            loadProgramSquare(cell: cell, url: content.programs[indexPath.row].pictureSquare)
        }else{
            cell.setImageData(data: content.programs[indexPath.row].pictureSquareData)
        }
        
        
        return cell
    }
    
    func loadProgramSquare(cell: ProgramTableViewCell, url:String){
        Alamofire.request(url).response { response in
            debugPrint(response)
            if let data = response.data {
                cell.setImageData(data: data)
            }else{
                //TODO error handling hhtp request
            }
        }
        
    }
    
    func loadPushupPicture(){
        Alamofire.request(content.dailyPushUp.pictureOverview).response { response in
            debugPrint(response)
            if let data = response.data {
                self.content.dailyPushUp.pictureOverviewData = data
                self.pushUpPicture.image = UIImage(data: data)
            }else{
                //TODO error handling hhtp request
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "goToProgram" , sender: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

}
