//
//  HomeViewController.swift
//  Meemo
//
//  Created by Daniel Lohse on 11/11/16.
//  Copyright © 2016 Superstudio. All rights reserved.
//

import UIKit
import Alamofire


class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var navItem: UINavigationItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pushUpPicture: UIImageView!

    var content:Content!

    let programSegueIdentifier = "goToProgram"
    let pushupSegueIdentifier = "goToPushUp"
    
    var titles = ["First", "Second", "Third"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.content = appDelegate.content
        if(content.dailyPushUp.pictureOverviewData == nil){
            loadPushupPicture()
        }else{
            self.pushUpPicture.image = UIImage(data: content.dailyPushUp.pictureOverviewData)
  
        }
        
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        self.navigationController?.navigationBar.isTranslucent = true
        
        //loadPushupPicture()

        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        
//        let delegate = UIApplication.shared.delegate as! AppDelegate
//        
//        delegate.navigationController?.setNavigationBarHidden(true, animated: true)


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {

        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == programSegueIdentifier,
            let destination = segue.destination as? ProgramViewController,
            let blogIndex = tableView.indexPathForSelectedRow?.row
        {
            destination.program = content.programs[blogIndex]
        }
        
        
        if  segue.identifier == pushupSegueIdentifier,
            let destination = segue.destination as? TestScrollViewController
        {
            let session = Session()
            session.title = content.dailyPushUp.title
            session.author = content.dailyPushUp.author
            session.desc = content.dailyPushUp.desc
            session.biography = content.dailyPushUp.biography
            session.time = content.dailyPushUp.time
            session.file = content.dailyPushUp.file
            session.readMore = content.dailyPushUp.readMore
            destination.session = session
            
            //TODO: Refactor!
            content.dailyPushUp.program.picturePlayer = content.dailyPushUp.picturePlayer
            destination.program = content.dailyPushUp.program
            destination.dailyPushUp = content.dailyPushUp
            destination.pushUp = true
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
