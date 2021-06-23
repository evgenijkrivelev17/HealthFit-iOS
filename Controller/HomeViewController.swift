//
//  HomeViewController.swift
//  VLCPlayer
//
//  Created by rabbit_mac on 2/18/20.
//  Copyright © 2020 rabbit_mac. All rights reserved.
//

import UIKit
import Alamofire
import DatePickerDialog
import iOSDropDown
import AVKit
class HomeViewController: UIViewController, VLCMediaPlayerDelegate  {
 
    @IBOutlet weak var optionDropdown: DropDown!
    @IBOutlet weak var mode_title: UILabel!
 
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    var vlcPlayer: VLCMediaPlayer = VLCMediaPlayer()
    let playerViewController = AVPlayerViewController()
    
    var arrlist  = NSMutableArray()
    var movieIndex = 0
    var datePicker_timeStamp = 0
    var default_length_second = 1800
    var length = 0
    var full_mode_flag : Bool = false
    var land_mode_flag : Bool = false
    var left_arrow_icon_flag: Bool = false
    var right_arrow_icon_flag: Bool = false
    var contraint_landscape : NSLayoutConstraint!
    var contraint_portrait : NSLayoutConstraint!
    
    var av_status_flag = 0 // 0 :pause 1: play 2:stop
    @IBOutlet weak var pause_imgView: UIImageView!
    
    @IBOutlet weak var control_fullmode: UIImageView!
    @IBOutlet weak var control_text: UILabel!
    @IBOutlet weak var control_right: UIImageView!
    @IBOutlet weak var control_left: UIImageView!
    @IBOutlet weak var control_stop: UIImageView!
    @IBOutlet weak var control_play: UIImageView!
    @IBOutlet weak var right_imgView: UIImageView!
    @IBOutlet weak var left_imgView: UIImageView!
    @IBOutlet weak var movieView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var play_imgView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let value = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        // Do any additional setup after loading the view.
        initUI()
        setupVlcMediaPlayer()
        ws_get_camera_list()
        displayDropdown()
        setDropDwonValue()
        //Add rotation observer
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.rotated),
            name: UIDevice.orientationDidChangeNotification,
            object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(finishVideoPlayback), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.fullscreen_success), name: NSNotification.Name.init("FULL_SCREEN_SUCCESS"), object: nil)
    
        contraint_portrait = self.containerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -200)
        contraint_landscape = self.containerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0)
    }

  
    override var shouldAutorotate: Bool {
        return true
    }
    @objc func rotated() {
        
        if UIDevice.current.orientation == UIDeviceOrientation.landscapeLeft{
            contraint_portrait.isActive = false
            contraint_landscape.isActive = true
        
            print("Switched to landscapeLeft")
            self.land_mode_flag = true
            self.optionDropdown.isHidden = true
            DispatchQueue.main.async {
                let radians = 90 / 180.0 * CGFloat.pi
                    self.containerView.transform = CGAffineTransform(rotationAngle: radians)
            }

            if (full_mode_flag == true){
                        DispatchQueue.main.async {
                         self.containerView.widthConstaint?.constant = self.view.frame.height + 50
                         self.containerView.heightConstaint?.constant = self.view.frame.width
                        }
                     
            }
            else{
                        DispatchQueue.main.async {
                            self.containerView.widthConstaint?.constant = self.view.frame.height - 30
                            self.containerView.heightConstaint?.constant = self.view.frame.width
                        }
                   
            }
        }
        else if UIDevice.current.orientation == UIDeviceOrientation.landscapeRight{
            contraint_portrait.isActive = false
            contraint_landscape.isActive = true
            self.land_mode_flag = true
            self.optionDropdown.isHidden = true
            DispatchQueue.main.async {
                let radians = -90 / 180.0 * CGFloat.pi
                self.containerView.transform = CGAffineTransform(rotationAngle: radians)
                                             
            }
            if (full_mode_flag == true){
                                  DispatchQueue.main.async {
                                   self.containerView.widthConstaint?.constant = self.view.frame.height + 50
                                   self.containerView.heightConstaint?.constant = self.view.frame.width
                                  }
                               
            }
              else{
                          DispatchQueue.main.async {
                              self.containerView.widthConstaint?.constant = self.view.frame.height - 30
                              self.containerView.heightConstaint?.constant = self.view.frame.width
                          }
                     
              }
        }
   
        else if UIDevice.current.orientation == UIDeviceOrientation.portrait{
            self.land_mode_flag = false
            print("Switched to portrait")
      
                
       
            self.optionDropdown.isHidden = false
                DispatchQueue.main.async {
                    let radians = 0 / 180.0 * CGFloat.pi
                    self.containerView.transform = CGAffineTransform(rotationAngle: radians)
                                   
                }
                
                if (full_mode_flag == true){
                    contraint_portrait.isActive = false
                    contraint_landscape.isActive = true
                            DispatchQueue.main.async {
                                self.containerView.widthConstaint?.constant = self.view.frame.width + 50
                                self.containerView.heightConstaint?.constant = self.view.frame.height
                            }
                         
                }
                else{
                          contraint_landscape.isActive = false
                          contraint_portrait.isActive = true
                            DispatchQueue.main.async {
                                self.containerView.widthConstaint?.constant = self.view.frame.width - 10
                                self.containerView.heightConstaint?.constant = 330
                            }
                       
                }
        }
      


       
     }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: .AVPlayerItemDidPlayToEndTime, object:nil)
    }
    private func addAVPlayerToVideoView() {
           if let viewWithTag = self.movieView.viewWithTag(100) {
               print("Removing old video from view")
               viewWithTag.removeFromSuperview()
           } else {
               print("No subview found with tag")
           }
            playerViewController.view.frame = movieView.bounds
           let view = playerViewController.view!
           view.tag = 100
           movieView.addSubview(view)
    }
    private func getAvPlayer_playback(urlStr: String) -> AVPlayer? {
           guard let url = URL(string: urlStr) else {
               return nil
           }
     
        
           return AVPlayer(url: url)
    }
    @objc func finishVideoPlayback(){
            print(av_status_flag)
            if(av_status_flag == 1){
                stopVideo()
                self.datePicker_timeStamp = self.datePicker_timeStamp + length
                playVideo()
            }
        
    }
   
    
    
    
    private func play_AV(urlStr: String) {
        playerViewController.showsPlaybackControls = false
        
        
        playerViewController.player?.pause()
        playerViewController.player = nil
        playerViewController.player = getAvPlayer_playback(urlStr: urlStr)
        playerViewController.player!.addObserver(self, forKeyPath: "status", options: [.old, .new], context: nil)
        if #available(iOS 10.0, *) {
            playerViewController.player!.addObserver(self, forKeyPath: "timeControlStatus", options: [.old, .new], context: nil)
        } else {
            playerViewController.player!.addObserver(self, forKeyPath: "rate", options: [.old, .new], context: nil)
        }
        addAVPlayerToVideoView()
        
        playerViewController.videoGravity = .resizeAspect
        
        playerViewController.player?.play()
    
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if object as AnyObject? === playerViewController.player {
            if keyPath == "status" {
             
            } else if keyPath == "timeControlStatus" {
                if #available(iOS 10.0, *) {
                    if playerViewController.player!.timeControlStatus == .playing {
                           //playing
                        self.loadingIndicator.isHidden = true
                        self.loadingIndicator.stopAnimating()
                        self.av_status_flag = 1
                    } else {
                        self.av_status_flag = 0
                    }
                }
            } else if keyPath == "rate" {
                if playerViewController.player!.rate > 0 {
                    //playing
                    self.loadingIndicator.isHidden = true
                    self.loadingIndicator.stopAnimating()
                    self.av_status_flag = 1
                } else {
                     self.av_status_flag = 0
                }
            }
        }
    }
    func displayDropdown() {
        optionDropdown.isSearchEnable = false
        optionDropdown.listWillAppear { self.view.gestureRecognizers?.forEach(self.view.removeGestureRecognizer)
            
        }
        optionDropdown.didSelect{(selectedText , index ,id) in
            self.optionDropdown.text = selectedText
               self.stopVideo()
            if index == 0{
             
                self.mode_title.text = "Online Camera Video"
            }else{
                self.selectDate()
            }
        }
    }
    func selectDate() {
        DatePickerDialog(locale: Locale(identifier: "ru_MD"), showCancelButton: false).show("Выбор даты и времени", doneButtonTitle: "Выполнено",maximumDate: Date(), datePickerMode: .dateAndTime) {
             (date) -> Void in
             if let dt = date {
                let distance = Int(Date().timeIntervalSince1970) - Int(dt.timeIntervalSince1970)
                if(distance <= 0){
                    
                }
                else{
                    self.datePicker_timeStamp = Int(dt.timeIntervalSince1970)
                    self.mode_title.text = "Playback Camera Video"
                }
            }
         }
     }

    func showInputDialog() {
        //Creating UIAlertController and
        //Setting title and message for the alert dialog
        let alertController = UIAlertController(title: "Регистрация камеры", message: "Вам необходимо зарегистрировать камеру. Если вы используете SpaceCam, пожалуйста введите 16 -символьный код с обратной стороны камеры. Если у вас камера другой марки, обратитесь в службу поддержки", preferredStyle: .alert)
        
        //the confirm action taking the inputs
        let confirmAction = UIAlertAction(title: "Ok", style: .default) { (_) in
            
            //getting the input values from user
            let key = alertController.textFields?[0].text
            if( key == ""){
                alertWindow("You should enter the key")
            }
            else{
                self.ws_register_camera(key: key!)
            }
            
        }
        
        //the cancel action doing nothing
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel) { (_) in }
        
        //adding textfields to our dialog box
        alertController.addTextField { (textField) in
            textField.placeholder = "введите номер камеры"
        }
        
        //adding the action to dialogbox
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        //finally presenting the dialog box
        self.present(alertController, animated: true, completion: nil)
    }
    
   
    
    func setDropDwonValue(){
         optionDropdown.optionArray = ["Online", "Playback"]
         optionDropdown.optionIds = [0, 1]
         optionDropdown.selectedIndex = 0
         optionDropdown.text = "Online"
     }
    func initUI(){
        containerView.layer.cornerRadius = 8
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor =  UIColor.init(red: 250/255, green: 250/255, blue: 250/255, alpha: 1).cgColor
        movieView.layer.cornerRadius = 8
        
        let tap = UITapGestureRecognizer(target: self, action:  #selector(self.videoPlay(sender:)))
        self.play_imgView.isUserInteractionEnabled = true
        self.play_imgView.addGestureRecognizer(tap)
   
        
        let right = UITapGestureRecognizer(target: self, action:  #selector(self.rightMovie(sender:)))
        let right_control = UITapGestureRecognizer(target: self, action:  #selector(self.rightMovie(sender:)))
        self.right_imgView.isUserInteractionEnabled = true
        self.right_imgView.addGestureRecognizer(right)
        self.control_right.isUserInteractionEnabled = true
        self.control_right.addGestureRecognizer(right_control)
        
        let left = UITapGestureRecognizer(target: self, action:  #selector(self.leftMovie(sender:)))
        let left_control = UITapGestureRecognizer(target: self, action:  #selector(self.leftMovie(sender:)))
        self.left_imgView.isUserInteractionEnabled = true
        self.left_imgView.addGestureRecognizer(left)
        self.control_left.isUserInteractionEnabled = true
        self.control_left.addGestureRecognizer(left_control)
        
        
        let stop_control = UITapGestureRecognizer(target: self, action:  #selector(self.controlStop(sender:)))
        self.control_stop.isUserInteractionEnabled = true
        self.control_stop.addGestureRecognizer(stop_control)
 
        let control_tap = UITapGestureRecognizer(target: self, action:  #selector(self.controlPlayPause(sender:)))
        self.control_play.isUserInteractionEnabled = true
        self.control_play.addGestureRecognizer(control_tap)
        
        let control_full = UITapGestureRecognizer(target: self, action:  #selector(self.controlFullVideo(sender:)))
        self.control_fullmode.isUserInteractionEnabled = true
        self.control_fullmode.addGestureRecognizer(control_full)
        
        
        updateUI()
        
          self.containerView.widthConstaint?.constant = self.view.frame.width - 10
        
        
    }
    
    @objc func fullscreen_success() {
            if (full_mode_flag == false){
                full_mode_flag = true
                
                contraint_portrait.isActive = false
                contraint_landscape.isActive = true
                
                
                if(self.land_mode_flag == false){
                    DispatchQueue.main.async {
                        self.containerView.widthConstaint?.constant = self.view.frame.width + 50
                        self.containerView.heightConstaint?.constant = self.view.frame.height
                    }
                }else{
                    DispatchQueue.main.async {
                        self.containerView.widthConstaint?.constant = self.view.frame.height + 50
                        self.containerView.heightConstaint?.constant = self.view.frame.width
                    }
                }
                self.left_arrow_icon_flag = self.left_imgView.isHidden
                self.right_arrow_icon_flag = self.right_imgView.isHidden
                self.left_imgView.isHidden = true
                self.right_imgView.isHidden = true
              }
              else{
                
                self.left_imgView.isHidden = self.left_arrow_icon_flag
                self.right_imgView.isHidden =  self.right_arrow_icon_flag
                
                full_mode_flag = false
                if(self.land_mode_flag == false){
                      contraint_landscape.isActive = false
                      contraint_portrait.isActive = true
                      DispatchQueue.main.async {

                          self.containerView.widthConstaint?.constant = self.view.frame.width - 10
                    
                          self.containerView.heightConstaint?.constant = 330
                      }
                }else{
                    
                    contraint_portrait.isActive = false
                    contraint_landscape.isActive = true
                
                    DispatchQueue.main.async {
                        self.containerView.widthConstaint?.constant = self.view.frame.height - 30
                        self.containerView.heightConstaint?.constant = self.view.frame.width
                    }
                }
                
              }
    }
    @objc func controlFullVideo(sender:UITapGestureRecognizer){
        
        let info:[String: Bool] = ["SelectedIndex": !full_mode_flag]
        NotificationCenter.default.post(name: NSNotification.Name.init("FULL_SCREEN"), object: nil, userInfo: info)
      
//        let dict = arrlist.object(at: movieIndex) as! NSDictionary
//        if dict.count>0{
//            let urlStr = string(dict, "Url")
//            let url = URL(string:urlStr)
////            if(url != nil){
////                  let vc = self.storyboard?.instantiateViewController(withIdentifier: "FullCameraViewController") as! FullCameraViewController
////                  vc.url = url
////
////                  self.navigationController?.pushViewController(vc, animated: true)
////            }
//
//
//
//        }
  
    }
    func makePlaybackUrl()->String{
        var url = "http://171.25.232.16/nvr/hls/ecc5f6a38139426786f26ce87a42a358/1582009015/120/index.m3u8"
        
        let dict = arrlist.object(at: movieIndex) as! NSDictionary
          if dict.count>0{

            let ProviderCameraUid = string(dict, "ProviderCameraUid")
              if (ProviderCameraUid == ""){
                  return ""
              }
            let camera_ip =  string(dict, "Url").split(separator: ":")[1]
              
            let timestamp = self.datePicker_timeStamp  - (Int(truncating: number(dict,"utsOffset")) * 3600) + (3 * 3600)
            length = default_length_second
            let currentDateTime = Date()
            let distance = Int(currentDateTime.timeIntervalSince1970) - self.datePicker_timeStamp
            if (distance < default_length_second && distance > 0){
                length = distance
            }
            
               url = "http:" + camera_ip + "/nvr/hls/" + ProviderCameraUid + "/" + "\(timestamp)" + "/" + "\(length)" + "/index.m3u8"
              return url
          }
          else{
            return ""
          }
        
  
    }
    func playVideo(){
        
        if(arrlist.count == 0) {
            let value = UIInterfaceOrientation.portrait.rawValue
            UIDevice.current.setValue(value, forKey: "orientation")
            let alert = UIAlertController(title: "Warning", message: "Camera List didn't load, yet.", preferredStyle: .alert)
               alert.view.tintColor = UIColor.black
             alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(void) in
                 return
             }))
         
             self.present(alert, animated: true, completion: nil)
            return
        }
        
        let dict = arrlist.object(at: movieIndex) as! NSDictionary
                         if dict.count>0{
                                 var urlStr = string(dict, "Url")
                                if (self.optionDropdown.selectedIndex == 1){
                                    urlStr = makePlaybackUrl()
                                }
                            
                            
                                 let url = URL(string:urlStr)

                                 if (url == nil || urlStr == ""){
                                     print("Invalid URL")
                                    let value = UIInterfaceOrientation.portrait.rawValue
                                    UIDevice.current.setValue(value, forKey: "orientation")
                                     self.play_imgView.isHidden = false
                                  
                                    
                                      let alert = UIAlertController(title: "Внимание!", message: "Не удалось подключиться к камере, проверьте соединение", preferredStyle: .alert)
                                             alert.view.tintColor = UIColor.black
                                           alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(void) in
                                            self.showInputDialog()
                                               return
                                           }))
                                       
                                           self.present(alert, animated: true, completion: nil)
                                     return
                                 }

                            self.pause_imgView.isHidden = true
                            self.play_imgView.isHidden = true
                            self.control_play.image = UIImage(systemName: "pause.circle.fill")
                            self.loadingIndicator.isHidden = false
                            self.loadingIndicator.startAnimating()
                            if (self.optionDropdown.selectedIndex == 0){
                                let media = VLCMedia(url: url!)

                                media.addOptions(["network-caching": 300])
                                vlcPlayer.media = media
                                vlcPlayer.play()
                             
                            }
                            else{
                                play_AV(urlStr:urlStr)
                            }
                            print(urlStr)
                         }
    }
    @objc func controlPlayPause(sender:UITapGestureRecognizer){
        if(vlcPlayer.isPlaying || av_status_flag == 1){
            if (self.optionDropdown.selectedIndex == 0){
                vlcPlayer.pause()
            }
            else{
                playerViewController.player?.pause()
            }
            self.pause_imgView.isHidden = false
            self.control_play.image = UIImage(systemName: "play.circle.fill")
        }
        else{
            if(self.pause_imgView.isHidden){
                playVideo()
            }
            else{
                if (self.optionDropdown.selectedIndex == 0){
                           vlcPlayer.play()
                }
                else{
                         playerViewController.player?.play()
                }
                self.pause_imgView.isHidden = true
                self.control_play.image = UIImage(systemName: "pause.circle.fill")
            }
          
        }
    }
    @objc func controlStop(sender:UITapGestureRecognizer){
        stopVideo()
    }
    func stopVideo(){
       // if(vlcPlayer.isPlaying){
            self.play_imgView.isHidden = false
            self.pause_imgView.isHidden = true
         
            self.control_play.image = UIImage(systemName: "play.circle.fill")
        
            vlcPlayer.stop()
        
            if(av_status_flag == 1){
                if let viewWithTag = self.movieView.viewWithTag(100) {
                              print("Removing old video from view av_status_flag == 1")
                              viewWithTag.removeFromSuperview()
                }else {
                              print("No subview found with tag av_status_flag == 1")
                }
                playerViewController.player?.pause()
                playerViewController.player?.seek(to: CMTimeMakeWithSeconds(0, preferredTimescale: 1))
            }
        
     //   }
    }
    
    @objc func leftMovie(sender:UITapGestureRecognizer){
        if(movieIndex == 0) {
            return
        }
        movieIndex = movieIndex - 1
        self.play_imgView.isHidden = false
        stopVideo()
     
        updateUI()

    }
    @objc func rightMovie(sender:UITapGestureRecognizer){
        if(movieIndex == self.arrlist.count - 1) {
            return
        }
        movieIndex = movieIndex + 1
        self.play_imgView.isHidden = false
        stopVideo()
       
        updateUI()
    }
    @objc func videoPlay(sender:UITapGestureRecognizer){
       playVideo()
    }
    
    func updateUI(){
        if (movieIndex == 0){
            self.left_imgView.isHidden = true
            
            self.right_imgView.isHidden = false
        }
        if(movieIndex == self.arrlist.count - 1 && self.arrlist.count != 0){
            self.left_imgView.isHidden = false
            self.right_imgView.isHidden = true

        }
        if(movieIndex > 0 && movieIndex < self.arrlist.count - 1){
            self.left_imgView.isHidden = false
            self.right_imgView.isHidden = false
            
        }
        if(self.arrlist.count < 2){
                  self.left_imgView.isHidden = true
                  self.right_imgView.isHidden = true
        }
        control_text.text = "\(movieIndex + 1)" + "/" + "\(self.arrlist.count)" + " Camera Selected"
        self.control_play.image = UIImage(systemName: "play.circle.fill")
    }
    func setupVlcMediaPlayer(){
            vlcPlayer.delegate = self
            vlcPlayer.drawable = self.movieView
              
        
             
    }
    func ws_get_camera_list(){
          if Connectivity.isConnectedToInternet {
              var paramDict = [String:Any]()
              
            paramDict["userId"] = AccountService.shared.currentAccount?.Id
         
              print(paramDict)
              
              guard let url = URL(string: cameraList) else {return}
            
              
              
            Alamofire.request(url,method: .get,parameters: paramDict).responseJSON{ (response) in
          
                  switch response.result {
                  case .success:
                      print(response)
                      let dictResponse = response.result.value as! NSDictionary
                        if let arrData = dictResponse.object(forKey: "data") as? NSArray{
                            self.arrlist = arrData.mutableCopy() as! NSMutableArray
                            self.updateUI()
                        }
                        else {
                          Http.alert("", string(dictResponse, "Message"))
                        }
                      
                      break
                  case .failure(let error):
                      alertWindow(kCouldnotconnect)
                      print(error)
                  }
                  
              }
              
              
              
          } else {
              alertWindow(kInternetNotAvailable)
          }
      }
    func ws_register_camera(key:String){
             if Connectivity.isConnectedToInternet {
                let dict = arrlist.object(at: movieIndex) as! NSDictionary
                if dict.count>0{
                        var paramDict = [String:Any]()
                                    
                                    paramDict["userId"] =  string(dict, "userId")
                                    paramDict["cameraId"] =  string(dict, "Id")
                                    paramDict["key"] =  key
                                    paramDict["isTest"] =  "true"
                                    paramDict["isSuccess"] = "true"
                               
                                    print(paramDict)
                                    
                                    guard let url = URL(string: cameraAdd) else {return}
                                  
                                    
                                    
                                  Alamofire.request(url,method: .get,parameters: paramDict).responseJSON{ (response) in
                                
                                        switch response.result {
                                        case .success:
                                            print(response)
                                            let dictResponse = response.result.value as! NSDictionary
                                            
                                            let register_url =  string(dictResponse, "Url")
                                            if (register_url == ""){
                                               
                                                let alert = UIAlertController(title: "Ошибка", message: "Ошибка регистрации камеры! Повторите попытку или обратитесь в службу поддержки", preferredStyle: .alert)
                                                alert.view.tintColor = UIColor.black
                                                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(void) in
                                                              return
                                                }))
                                                      
                                                self.present(alert, animated: true, completion: nil)
                                            }
                                            else{
                                                
                                                var replaceData =  [String:Any]()
                                                replaceData["Url"] =  string(dictResponse, "Url")
                                                replaceData["ProviderCameraUid"] =  string(dictResponse, "ProviderCameraUid")
                                                replaceData["Id"] =  string(dict, "Id")
                                                replaceData["userId"] =  string(dict, "userId")
                                                replaceData["utsOffset"] =  string(dict, "utsOffset")
                                                self.arrlist.replaceObject(at: self.movieIndex, with: replaceData)
                                                
                                               let alert = UIAlertController(title: "Спасибо", message: "Камера успешно зарегистрирована!", preferredStyle: .alert)
                                                            alert.view.tintColor = UIColor.black
                                                          alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(void) in
                                                              return
                                                          }))
                                                      
                                                          self.present(alert, animated: true, completion: nil)
                                                                                    
                                            }
                                            
                                            break
                                        case .failure(let error):
                                            alertWindow(kCouldnotconnect)
                                            print(error)
                                        }
                                        
                                    }
                }
                
                 
                 
                 
             } else {
                 alertWindow(kInternetNotAvailable)
             }
         }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func mediaPlayerStateChanged(_ aNotification: Notification!) {
            if vlcPlayer.state == .playing {
            
                print("stream is playing")
            }
            if vlcPlayer.state == .stopped {
            
                print("Player has stopped")
                if(self.play_imgView.isHidden){
                    if(self.optionDropdown.selectedIndex == 0) {
                        let media = VLCMedia(url: vlcPlayer.media.url)
                        media.addOptions(["network-caching": 300])

                        vlcPlayer.media = media
                        vlcPlayer.play()
                    }
                    else{
//                        self.datePicker_timeStamp = self.datePicker_timeStamp + length
//                        if(self.datePicker_timeStamp > Int(Date().timeIntervalSince1970)){
//                            let alert = UIAlertController(title: "Warning", message: "Playback time has been expired current time", preferredStyle: .alert)
//                                       alert.view.tintColor = UIColor.black
//                                     alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(void) in
//                                         return
//                                     }))
//
//                                     self.present(alert, animated: true, completion: nil)
//                                    return
//                        }
//                        else{
//                            playVideo()
//                        }
                    }
                
                }
                
                
            }
            if vlcPlayer.state == .opening {
           
                print("Stream is opening")
            }
            if vlcPlayer.state == .buffering {
               
                print("Stream is buffering")
            }
            if vlcPlayer.state == .ended {
           
                print("Stream has ended")
            }
            if vlcPlayer.state == .error {
                    
                print("Player has generated an error")
            }
            if vlcPlayer.state == .paused {
                 
                print("Stream is paused")
            }
           
            if vlcPlayer.state == .esAdded {
                 
                print("Elementary Stream added")
                self.loadingIndicator.isHidden = true
                self.loadingIndicator.stopAnimating()
                
        }
      
              // Handle other states...
          }
}
extension UIView {

var heightConstaint: NSLayoutConstraint? {
    get {
        return constraints.first(where: {
            $0.firstAttribute == .height && $0.relation == .equal
        })
    }
    set { setNeedsLayout() }
}

var widthConstaint: NSLayoutConstraint? {
    get {
        return constraints.first(where: {
            $0.firstAttribute == .width && $0.relation == .equal
        })
    }
    set { setNeedsLayout() }
}

}
