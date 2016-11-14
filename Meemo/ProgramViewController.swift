//
//  ProgramViewController.swift
//  Meemo
//
//  Created by Daniel Lohse on 11/12/16.
//  Copyright © 2016 Superstudio. All rights reserved.
//

import UIKit
import Alamofire

class ProgramViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, PlayerDelegate  {

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
    
    var showPlayer = false
    
    @IBOutlet weak var loaderAnimation: UIActivityIndicatorView!
    @IBOutlet weak var teaserButton: UIButton!
    @IBOutlet weak var overviewPicture: UIImageView!
    @IBOutlet weak var numberSessionsLabel: UILabel!
    @IBOutlet weak var decriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let segueIdentifier = "goToPlayer"
    var program:Program!
    
    var player:Player = Player()

    func playerUpdateTime(timeLeft: String){
    
    }
    

    
    func playerDidFinishPlaying(){
        //        self.playButton.setImage(#imageLiteral(resourceName: "player_play_button"), for: .normal)
        //        FIRAnalytics.logEvent(withName: "finished_play", parameters: nil)
        //        timerTextView.text = ""
        //        performSegue(withIdentifier: "showreactionview", sender: self)
    }
    
    func playerErrorDidOccur(){
    }
    
    func playerFileErrorDidOccur(){
    }
    
    /*------------------------------------------------------------------------
     --------------------UI Functions-------------------------------
     ------------------------------------------------------------------------*/
    
    func initUI(){
        player.setDuration(duration: 100)
//        self.timeLabel.text = player.getDurationString()
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
        self.program.teaserData = data
        self.player.setFile(data: data)
        self.teaserButton.setImage(#imageLiteral(resourceName: "program_teaser_button_pause"), for: .normal)
        self.loaderAnimation.stopAnimating()
        player.play()
        
        //        let hourOfTheDay = Calendar.current.component(.hour, from: Date())
        //        FIRAnalytics.logEvent(withName: String("press_play_" + String(hourOfTheDay)), parameters: nil)
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
        //        //self.player.setDuration(duration: content.duration)
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
        
        self.player.delegate = self
        initUI()
        
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
//        appDelegate.navigationController?.setNavigationBarHidden(false, animated: true)

        self.navigationController?.setNavigationBarHidden(false, animated: true)

        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        

        var backBtn = UIImage(named: "nav_back_icon")
        backBtn = backBtn?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        self.navigationController?.navigationBar.backIndicatorImage =  backBtn
        self.navigationController!.navigationBar.backIndicatorTransitionMaskImage = backBtn;

        
        self.navigationController?.navigationBar.backItem?.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: #selector(self.backDidTouch))



        //self.navigationController?.navigationBar.barStyle = UIBarStyle.
    }
    
    
    func backDidTouch(){
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        if(showPlayer){
            showPlayer = false
        }else{
            self.navigationController?.setNavigationBarHidden(true, animated: true)
            self.reset()
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
