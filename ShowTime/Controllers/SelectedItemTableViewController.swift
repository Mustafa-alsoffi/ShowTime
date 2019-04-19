//
//  SelectedItemTableViewController.swift
//  ShowTime
//
//  Created by Mustafa Alsoffi on 17/04/2019.
//  Copyright © 2019 Mustafa Alsoffi. All rights reserved.
//

import UIKit
import AVFoundation

class SelectedItemTableViewController: UITableViewController {
    
    var player : AVPlayer? = nil
    var secondsText : Int?
    var minutesText : String?
    var isPlaying = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Hello again")

        tableView.register(VidTableVCell.self, forCellReuseIdentifier: "VideoCell")
        

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupPlayerView()
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath) as! VidTableVCell
        
        // Configure the cell...
        handlePause(cell.pausePlayButton)
    
        cell.pausePlayButton.addTarget(self, action: #selector(handlePause), for: .touchUpInside)
        

        
    
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let controlsContainer = tableView.frame.width * 9 / 16
        if indexPath.row == 0 {
            
            return controlsContainer
        }
        return CGFloat()
    }
    
    
   func setupPlayerView() {

        let urlString = "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"
        if let url = URL(string: urlString) {
             let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! VidTableVCell
            let asset = AVAsset(url: url)
            let playerItem = AVPlayerItem(asset: asset)
            
            player = AVPlayer(playerItem: playerItem)
            
            let playerLayer = AVPlayerLayer(player: player)
//            playerLayer.videoGravity = .resizeAspectFill
            
            playerLayer.frame = cell.controlsContainerView.bounds
            
           cell.contentView.layer.addSublayer(playerLayer)
           
                        player?.play()
            
            
            player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
            
        }
    }
    
    @objc func handlePause(_ pausePlayButton : UIButton) {
        if isPlaying {
            player?.pause()
            pausePlayButton.setImage(UIImage(named: "play"), for: .normal)
            
        } else {
            player?.play()
            pausePlayButton.setImage(UIImage(named: "pause"), for: .normal)
            
        }
        
        isPlaying = !isPlaying
    }

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        //this is when the player is ready and rendering frames
        print("Hello world ")
        if keyPath == "currentItem.loadedTimeRanges" {
            let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! VidTableVCell
            cell.activityIndicatorView.stopAnimating()
            cell.controlsContainerView.backgroundColor = .clear
            cell.pausePlayButton.isHidden = false
            isPlaying = true
            
            if let duration = player?.currentItem?.duration {
                let seconds = CMTimeGetSeconds(duration)
                
                 self.secondsText = Int(seconds) % 60
                self.minutesText = String(format: "%02d", Int(seconds) / 60)
               cell.videoLengthLabel.text = "\(minutesText!):\(secondsText!)"
            }
          
        }
    }
  
    
}
