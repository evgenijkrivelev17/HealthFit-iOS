//
//  FullCameraViewController.swift
//  VLCPlayer
//
//  Created by rabbit_mac on 2/18/20.
//  Copyright © 2020 rabbit_mac. All rights reserved.
//

import UIKit

class FullCameraViewController: UIViewController , VLCMediaPlayerDelegate  {
    var vlcPlayer: VLCMediaPlayer = VLCMediaPlayer()
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var movieView: UIView!
    var url : URL!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        vlcPlayer.delegate = self
        vlcPlayer.drawable = self.movieView
        let media = VLCMedia(url: url!)

        media.addOptions(["network-caching": 300])
        vlcPlayer.media = media
        vlcPlayer.play()
        self.loadingIndicator.isHidden = false
        self.loadingIndicator.startAnimating()
        self.title = "Full Video View"
    }
    
    func mediaPlayerStateChanged(_ aNotification: Notification!) {
               if vlcPlayer.state == .playing {
               
                   print("stream is playing")
               }
               if vlcPlayer.state == .stopped {
               
                   print("Player has stopped")
           
                       let media = VLCMedia(url: url)
                       media.addOptions(["network-caching": 300])

                       vlcPlayer.media = media
                       vlcPlayer.play()
                   
                   
                   
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
                   self.loadingIndicator.stopAnimating()            }
         
                 // Handle other states...
             }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
