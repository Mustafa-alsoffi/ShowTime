//
//  vidTableViewCell.swift
//  ShowTime
//
//  Created by Mustafa Alsoffi on 18/04/2019.
//  Copyright © 2019 Mustafa Alsoffi. All rights reserved.
//

import UIKit
import AVFoundation

class VidTableVCell: UITableViewCell {
    
 

    let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .whiteLarge)
        aiv.translatesAutoresizingMaskIntoConstraints = false
        aiv.startAnimating()
        return aiv
    }()
    
    lazy var pausePlayButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "pause")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.isHidden = true
        
//        button.addTarget(self, action: #selector(handlePause), for: .touchUpInside)
        
        return button
    }()
    
    let currentTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "00:00"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 13)
        return label
    }()
    
    let videoLengthLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "00:00"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .right
        return label
    }()
    
    lazy var videoSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumTrackTintColor = .yellow
        slider.maximumTrackTintColor = .white
        slider.setThumbImage(UIImage(named: "thumb"), for: .normal)
        
//        slider.addTarget(self, action: #selector(handleSliderChange), for: .valueChanged)
        
        return slider
    }()
//
//    @objc func handleSliderChange() {
//        print(videoSlider.value)
//
//        if let duration = player?.currentItem?.duration {
//            let totalSeconds = CMTimeGetSeconds(duration)
//
//            let value = Float64(videoSlider.value) * totalSeconds
//
//            let seekTime = CMTime(value: Int64(value), timescale: 1)
//
//            player?.seek(to: seekTime, completionHandler: { (completedSeek) in
//                //perhaps do something later here
//            })
//        }
//
//
//    }
    
//    var isPlaying = false
//
//    @objc func handlePause() {
//        if isPlaying {
//            player?.pause()
//            pausePlayButton.setImage(UIImage(named: "play"), for: .normal)
//        } else {
//            player?.play()
//            pausePlayButton.setImage(UIImage(named: "pause"), for: .normal)
//        }
//
//        isPlaying = !isPlaying
//    }
    
    let controlsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        

        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    
        addSubview(controlsContainerView)
        
        controlsContainerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        controlsContainerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
    //    let height = frame.width * 9 / 16
       // controlsContainerView.heightAnchor.constraint(equalToConstant:height).isActive = true
        controlsContainerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true

        controlsContainerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        

        controlsContainerView.addSubview(activityIndicatorView)
        activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        
        controlsContainerView.addSubview(pausePlayButton)
        pausePlayButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        pausePlayButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        pausePlayButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        pausePlayButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        controlsContainerView.addSubview(videoLengthLabel)
        videoLengthLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        videoLengthLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        videoLengthLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        videoLengthLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        controlsContainerView.addSubview(currentTimeLabel)
        currentTimeLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        currentTimeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2).isActive = true
        currentTimeLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        currentTimeLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        controlsContainerView.addSubview(videoSlider)
        videoSlider.rightAnchor.constraint(equalTo: videoLengthLabel.leftAnchor).isActive = true
        videoSlider.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        videoSlider.leftAnchor.constraint(equalTo: currentTimeLabel.rightAnchor).isActive = true
        videoSlider.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
    }
    
    
//    private func setupPlayerView() {
//        //warning: use your own video url here, the bandwidth for google firebase storage will run out as more and more people use this file
//        let urlString = "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"
//        if let url = URL(string: urlString) {
//            let asset = AVAsset(url: url)
//            let playerItem = AVPlayerItem(asset: asset)
//
//            player = AVPlayer(playerItem: playerItem)
//
//            let playerLayer = AVPlayerLayer(player: player)
//            playerLayer.videoGravity = .resizeAspectFill
//            playerLayer.masksToBounds = true
//
//            playerLayer.frame = controlsContainerView.bounds
//
//            controlsContainerView.layer.addSublayer(playerLayer)
//
//
//
//
////            player?.play()
//
//            player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
//
//            //track player progress
//
//            let interval = CMTime(value: 1, timescale: 2)
//            player?.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { (progressTime) in
//
//                let seconds = CMTimeGetSeconds(progressTime)
//                let secondsString = String(format: "%02d", seconds.truncatingRemainder(dividingBy: 60))
//                let minutesString = String(format: "%02d", seconds.truncatingRemainder(dividingBy: 60))
//
//                self.currentTimeLabel.text = "\(minutesString):\(secondsString)"
//
//                //lets move the slider thumb
//                if let duration = self.player?.currentItem?.duration {
//                    let durationSeconds = CMTimeGetSeconds(duration)
//
//                    self.videoSlider.value = Float(seconds / durationSeconds)
//
//                }
//
//            })
//        }
//    }
    
//    private func setupGradientLayer() {
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.frame = bounds
//        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
//        gradientLayer.locations = [0.0, 1.0]
//        controlsContainerView.layer.addSublayer(gradientLayer)
//    }
    
//    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
//        //this is when the player is ready and rendering frames
//        if keyPath == "currentItem.loadedTimeRanges" {
//            activityIndicatorView.stopAnimating()
//            controlsContainerView.backgroundColor = .clear
//            pausePlayButton.isHidden = false
//            isPlaying = true
//
//            if let duration = player?.currentItem?.duration {
//                let seconds = CMTimeGetSeconds(duration)
//
//                let secondsText = Int(seconds) % 60
//                let minutesText = String(format: "%02d", Int(seconds) / 60)
//                videoLengthLabel.text = "\(minutesText):\(secondsText)"
//            }
//        }
//    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
