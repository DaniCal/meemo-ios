//
//  ProgramViewController.swift
//  Meemo
//
//  Created by Daniel Lohse on 11/12/16.
//  Copyright © 2016 Superstudio. All rights reserved.
//

import UIKit
import Alamofire
import Mixpanel

class ProgramViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, PlayerDelegate  {

    @IBOutlet weak var headerContainer: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var loaderAnimation: UIActivityIndicatorView!
    @IBOutlet weak var teaserButton: UIButton!
    @IBOutlet weak var overviewPicture: UIImageView!
    @IBOutlet weak var numberSessionsLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let segueIdentifier = "goToPlayer"
    var showPlayer = false
    var program:Program!
    var player:Player = Player()

    
    /*------------------------------------------------------------------------
     --------------------Delegate Functions-------------------------------
     ------------------------------------------------------------------------*/
    
    
    func playerUpdateTime(timeLeft: String){
    
    }
    
    func playerDidFinishPlaying(){
        Mixpanel.sharedInstance().track("teaser_finished", properties: ["name" : program.title])
        teaserButton.setImage(#imageLiteral(resourceName: "program_teaser_button"), for: .normal)
    }
    
    func playerErrorDidOccur(){
    }
    
    func playerFileErrorDidOccur(){
    }
    
    /*------------------------------------------------------------------------
     --------------------Lifecycle Functions-------------------------------
     ------------------------------------------------------------------------*/
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = program.title
        descriptionLabel.text = program.descr
        descriptionLabel.sizeToFit()
        var newSize = CGSize()
        newSize.width = headerContainer.frame.width
        newSize.height = self.descriptionLabel.frame.origin.y + self.descriptionLabel.frame.height + 8
        headerContainer.frame.size = newSize
        numberSessionsLabel.text = String(program.sessions.count) + " Episodes"
        if(program.PictureOverviewData == nil){
            loadOverviewPicture()
        }else{
            self.overviewPicture.image = UIImage(data: program.PictureOverviewData)
        }
        
        self.player.delegate = self
        initUI()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
        var newSize = CGSize()
        newSize.width = headerContainer.frame.width
        newSize.height = self.descriptionLabel.frame.origin.y + self.descriptionLabel.frame.height + 8
        headerContainer.frame.size = newSize
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if(showPlayer){
            showPlayer = false
        }else{
            self.navigationController?.setNavigationBarHidden(true, animated: true)
            self.reset()
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.reset()
        
        if  segue.identifier == segueIdentifier,
            let destination = segue.destination as? TestScrollViewController,
            let blogIndex = tableView.indexPathForSelectedRow?.row
        {
            self.showPlayer = true
            destination.session = program.sessions[blogIndex]
            destination.program = program
            
        }
    }

    /*------------------------------------------------------------------------
     --------------------UI Functions-------------------------------
     ------------------------------------------------------------------------*/
    
    func initUI(){
        initNavigationBar()
        //TODO Player does need duration to function properly
        player.setDuration(duration: 100)
    }
    
    func stateLoad(){
        teaserButton.setImage(#imageLiteral(resourceName: "session_listen_empty"), for: .normal)
        loaderAnimation.startAnimating()
    }
    
    func statePause(){
        self.teaserButton.setImage(#imageLiteral(resourceName: "program_teaser_button"), for: .normal)
        self.loaderAnimation.stopAnimating()
    }
    
    func statePlay(){
        self.teaserButton.setImage(#imageLiteral(resourceName: "program_teaser_button_pause"), for: .normal)
        self.loaderAnimation.stopAnimating()
    }
    
    func initNavigationBar(){
        //Make the navigation bar appear
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        //replace the back button image item
        var backBtn = UIImage(named: "nav_back_icon")
        backBtn = backBtn?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        self.navigationController?.navigationBar.backIndicatorImage =  backBtn
        self.navigationController!.navigationBar.backIndicatorTransitionMaskImage = backBtn;
        
        //replace the back button title
        self.navigationController?.navigationBar.backItem?.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
    }
    
    
    /*------------------------------------------------------------------------
     --------------------Player Functions-------------------------------
     ------------------------------------------------------------------------*/
    
    func start(){
        if(!player.isInitialized()){
            //Load file from server and init Player instance
            self.stateLoad()
            if(self.program.teaserData == nil){
                self.downloadFile()
            }else{
                play(data: self.program.teaserData)
            }
        }else if(self.player.isPlaying()){
            self.pause()
        }else if(!self.player.isPlaying()){
            //self.play()
        }else{
            self.stateLoad()
            if(self.program.teaserData == nil){
                self.downloadFile()
            }else{
                play(data: self.program.teaserData)
            }
        }
    }
    
    func play(data:Data){
        Mixpanel.sharedInstance().track("play_teaser", properties: ["Program Name" : program.title])
        self.program.teaserData = data
        self.player.setFile(data: data)
        self.teaserButton.setImage(#imageLiteral(resourceName: "program_teaser_button_pause"), for: .normal)
        self.loaderAnimation.stopAnimating()
        player.play()
    }
    
    func continuePlaying(){
        self.teaserButton.setImage(#imageLiteral(resourceName: "program_teaser_button_pause"), for: .normal)
        self.loaderAnimation.stopAnimating()
        player.play()
    }
    
    func pause(){
        self.teaserButton.setImage(#imageLiteral(resourceName: "program_teaser_button"), for: .normal)
        player.pause()
    }
    
    func reset(){
        self.player.reset()
        self.teaserButton.setImage(#imageLiteral(resourceName: "program_teaser_button"), for: .normal)
        self.player = Player()
        self.player.delegate = self
    }
    
    /*------------------------------------------------------------------------
     --------------------Downlaod Functions-------------------------------
     ------------------------------------------------------------------------*/
    
    func downloadFile(){
        Alamofire.request(program.teaser).response { response in
            debugPrint(response)
            if let data = response.data {
                self.program.teaserData = data
                self.play(data:data)
            }else{
                //TODO error handling hhtp request
            }
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
 
    /*------------------------------------------------------------------------
     --------------------Action Functions-------------------------------
     ------------------------------------------------------------------------*/
    
    
    @IBAction func teaserDidTouch(_ sender: AnyObject) {
        if(!player.isInitialized()){
            teaserButton.setImage(#imageLiteral(resourceName: "session_listen_empty"), for: .normal)
            loaderAnimation.startAnimating()
            start()
        }else if(self.player.isPlaying()){
            pause()
        }else if(!self.player.isPlaying()){
            continuePlaying()
        }else{
            teaserButton.setImage(#imageLiteral(resourceName: "session_listen_empty"), for: .normal)
            loaderAnimation.startAnimating()
        }
    }
    
    /*------------------------------------------------------------------------
     --------------------Table Functions-------------------------------
     ------------------------------------------------------------------------*/
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return program.sessions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "sessionCell", for: indexPath) as! SessionTableViewCell
        cell.setTitle(program.sessions[indexPath.row].title)
        cell.setAuthor(program.sessions[indexPath.row].author)
        
        let playedBefore = UserDefaults.standard.bool(forKey: program.title + "_" + program.sessions[indexPath.row].title)

        if(playedBefore){
            cell.picture.image = UIImage(named: "program_played")
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "goToPlayer" , sender: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
