//
//  ProgramViewController.swift
//  Meemo
//
//  Created by Daniel Lohse on 11/12/16.
//  Copyright © 2016 Superstudio. All rights reserved.
//

import UIKit
import Alamofire

class ProgramViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {

    @IBOutlet weak var overviewPicture: UIImageView!
    @IBOutlet weak var numberSessionsLabel: UILabel!
    @IBOutlet weak var decriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let segueIdentifier = "goToPlayer"
    var program:Program!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = program.title
        decriptionLabel.text = program.descr
        numberSessionsLabel.text = String(program.sessions.count) + " Episodes"
        if(program.PictureOverviewData == nil){
            loadOverviewPicture()
        }else{
            self.overviewPicture.image = UIImage(data: program.PictureOverviewData)
        }
        
    }
    
    
    func loadOverviewPicture(){
        Alamofire.request(program.pictureOverview).response { response in
            debugPrint(response)
            if let data = response.data {
                self.program.PictureOverviewData = data
                self.overviewPicture.image = UIImage(data: data)
            }else{
                //TODO error handling hhtp request
            }
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == segueIdentifier,
            let destination = segue.destination as? TestScrollViewController,
            let blogIndex = tableView.indexPathForSelectedRow?.row
        {
            destination.session = program.sessions[blogIndex]
            destination.program = program
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return program.sessions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "sessionCell", for: indexPath) as! SessionTableViewCell
        cell.setTitle(program.sessions[indexPath.row].title)
        cell.setAuthor(program.sessions[indexPath.row].author)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "goToPlayer" , sender: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
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
