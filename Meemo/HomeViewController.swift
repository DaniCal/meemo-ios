//
//  HomeViewController.swift
//  Meemo
//
//  Created by Daniel Lohse on 11/11/16.
//  Copyright © 2016 Superstudio. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var navItem: UINavigationItem!
    @IBOutlet weak var tableView: UITableView!
    var content:Content!

    let programSegueIdentifier = "goToProgram"
    let pushupSegueIdentifier = "goToPushUp"
    
    var titles = ["First", "Second", "Third"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.content = appDelegate.content
        

//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        appDelegate.navigationController?.setNavigationBarHidden(true, animated: true)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        }
        

    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content.programs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "programCell", for: indexPath) as! ProgramTableViewCell
        cell.setTitle(content.programs[indexPath.row].title)
        cell.setSubtitle(content.programs[indexPath.row].subtitle)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "goToProgram" , sender: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

}
