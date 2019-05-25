//
//  SelectedItemTableViewController.swift
//  ShowTime
//
//  Created by Mustafa Alsoffi on 17/04/2019.
//  Copyright © 2019 Mustafa Alsoffi. All rights reserved.
//

import UIKit
import AVFoundation

class SelectedItemTableVC: UITableViewController {
    
    var player : AVPlayer? = nil
    var secondsText : String?
    var minutesText : String?
    var currentSecondsText : String?
    var currentMinText : String?
    var isPlaying = false
    var isTapped = false
    var timeObserver: Any?
    override func viewDidLoad() {
        super.viewDidLoad()
        print("View did load")
        
        tableView.register(VidTableVCell.self, forCellReuseIdentifier: "VideoCell")
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // pausing the video otherwise it'll be playing in the background
        player?.pause()
    }

    // MARK:- Table View Data Source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.row == 0 {
            
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath) as! VidTableVCell
            
            // Adding targets
            handlePause(cell.pausePlayButton)
            handleSliderChange(cell.videoSlider)
            cell.pausePlayButton.addTarget(self, action: #selector(handlePause), for: .touchUpInside)
            cell.videoSlider.addTarget(self, action: #selector(handleSliderChange), for: .valueChanged)
            
            // Setting player views
            setupPlayerView(cell: cell)
            player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
            setupGradientLayer(cell: cell)
            
            return cell
        } else if indexPath.row == 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "DiscriptionCell", for: indexPath) as! DetailsTableVCell

            
            return cell
        }
        
        
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            
            let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! VidTableVCell
            
            if cell.controlsContainerView.alpha == 1.0{
                
                cell.controlsContainerView.alpha = 0.0
                
            } else if cell.controlsContainerView.alpha == 0.0 {
                
                cell.controlsContainerView.alpha = 1.0
                hideViewsWithAnimation(view: cell.controlsContainerView)
                cell.controlsContainerView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
                
                
            }
        } else if indexPath.row == 1 {
            expendTextView ()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 1 {
            if isTapped == false {
                
                return 100
            } else {
                
                let cell = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! DetailsTableVCell
                
                return cell.descriptionTextView.frame.height + 50
            }
            
        } else if indexPath.row == 0 {
            return view.frame.width * 9 / 16
        }
        return CGFloat()
    }
    
    
    
    
    // MARK:- Video Player Set-Up
    
    func setupPlayerView(cell : VidTableVCell) {
        let urlString = "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"
        //        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! VidTableVCell
        if let url = URL(string: urlString) {
            
            let asset = AVAsset(url: url)
            let playerItem = AVPlayerItem(asset: asset)
            
            player = AVPlayer(playerItem: playerItem)
            
            let playerLayer = AVPlayerLayer(player: player)
            let height = cell.frame.width * 9 / 16
            let width = view.frame.width
            playerLayer.frame.size.height = height
            playerLayer.frame.size.width = width
            
            playerLayer.videoGravity = .resizeAspectFill
            playerLayer.backgroundColor = UIColor.black.cgColor
            
            
            cell.contentView.layer.addSublayer(playerLayer)
            player?.pause()
            
           
            trackSlider(cell: cell)
            
        }
        
    }
    
    func trackSlider(cell: VidTableVCell) {
        //    track player progress and move it automatically
        
        let interval = CMTime(value: 1, timescale: 2)
       self.timeObserver = player?.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { (progressTime) in

            let seconds = CMTimeGetSeconds(progressTime)
            let secondsString = String(format: "%02d", seconds.truncatingRemainder(dividingBy: 60))
            let minutesString = String(format: "%02d", seconds.truncatingRemainder(dividingBy: 60))

            cell.currentTimeLabel.text = "\(minutesString):\(secondsString)"

            //let's move the slider thumb and determine the current time label
            if let duration = self.player?.currentItem?.duration {
                let durationSeconds = CMTimeGetSeconds(duration)
                
                cell.videoSlider.value = Float(seconds / durationSeconds)
                let sliderValue = cell.videoSlider.value
                let value = Float64(sliderValue) * durationSeconds
                self.currentSecondsText = String(format: "%02d", Int(value) % 60)
                self.currentMinText = String(format: "%02d", Int(value) / 60)
                cell.currentTimeLabel.text = "\(self.currentMinText!):\(self.currentSecondsText!)"

            }
          
        })
            
        

    }

    
    
    func setupGradientLayer(cell : VidTableVCell) {

        let gradientLayer = CAGradientLayer()
        let height = cell.contentView.frame.width * 9 / 16
        
        gradientLayer.frame.size.width = view.frame.width
        gradientLayer.frame.size.height = height
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.7, 1.2]
        cell.contentView.layer.addSublayer(gradientLayer)
        
    }
    
    @objc func handlePause(_ pausePlayButton : UIButton) {
        isPlaying = !isPlaying
        if isPlaying {
            player?.pause()
            pausePlayButton.setImage(UIImage(named: "play"), for: .normal)
            
        } else if player?.currentItem?.duration == player?.currentItem?.currentTime() {
            player?.seek(to: CMTime.zero)
            player?.play()
         pausePlayButton.setImage(UIImage(named: "pause"), for: .normal)
        } else {
            let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! VidTableVCell
            player?.play()
            pausePlayButton.setImage(UIImage(named: "pause"), for: .normal)
            hideViewsWithAnimation(view: cell.controlsContainerView)
        }
        
    }
    
    
    @objc func handleSliderChange(_ slider : UISlider) {
        
     
        if let duration = player?.currentItem?.duration {
            let totalSeconds = CMTimeGetSeconds(duration)
            
            let value = Float64(slider.value) * totalSeconds
            
            let seekTime = CMTime(value: Int64(value), timescale: 1)
            if self.isPlaying {
                print("Yes, to works!?")
                self.player?.seek(to: seekTime)

            } else {
                
                
                self.player?.pause()
                player?.seek(to: seekTime, completionHandler: { (completedSeek) in
                    //perhaps do something later here
                    if completedSeek {
                        self.player?.play()
                    }
                    
                    
                })

            }
        }
        
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! VidTableVCell
        
        //this is when the player is ready and rendering frames
        print("Rendering frames...")
        if keyPath == "currentItem.loadedTimeRanges" {
            cell.activityIndicatorView.stopAnimating()
            
            
            cell.pausePlayButton.isHidden = false
            
            
            
            // let's determine the video length label
            if let duration = player?.currentItem?.duration {
                
                let seconds = CMTimeGetSeconds(duration)
                self.secondsText = String(format: "%02d", Int(seconds) % 60)
                self.minutesText = String(format: "%02d", Int(seconds) / 60)
                
                cell.videoLengthLabel.text = "\(minutesText!):\(secondsText!)"
            }
            
        }
        
        playbackAndShowControls(using: cell.pausePlayButton)
        
//        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: self.player?.currentItem, queue: .main) { [weak self] _ in
//            self?.player?.seek(to: CMTime.zero)
//            self?.player?.play()
//        }
        
    }
    
    func playbackAndShowControls (using button : UIButton) {
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: self.player?.currentItem, queue: .main) { _ in
            
               button.setImage(#imageLiteral(resourceName: "playback"), for: .normal)
                }
    }
    
    func hideViewsWithAnimation(view : UIView) {
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { (timer) in
            UIView.animate(withDuration: 0.30, animations: {
                view.alpha = 0.0
                
            })
        }
        
        
        
    }
    
    
     // MARK:- Details Label Set-Up
    
    func expendTextView () {
        let cell = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! DetailsTableVCell
        isTapped = !isTapped
        if isTapped {
            
            cell.descriptionTextView.sizeToFit()
        }
        
        
        tableView.beginUpdates()
        
        tableView.endUpdates()
        tableView.deselectRow(at: IndexPath(row: 1, section: 0), animated: false)
        
        
        
    }
    
}
