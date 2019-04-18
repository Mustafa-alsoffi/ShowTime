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
    
    let playerViewCell = VidTableVCell ()
    let player : AVPlayer? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        tableView.separatorStyle = .none
        print("Hello again")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath) as! VidTableVCell
        
        
        // Configure the cell...
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let controlsContrainer = tableView.frame.width * 9 / 16
        if indexPath.row == 0 {
            
            return controlsContrainer
        }
        return CGFloat()
    }
    
    
    
    @IBAction func handleSlider(_ sender: Any) {
        if let videoSlider = playerViewCell.videoSlider {
            if let duration = player?.currentItem?.duration {
                let totalSeconds = CMTimeGetSeconds(duration)
                
                let value = Float64(videoSlider.value) * totalSeconds
                
                let seekTime = CMTime(value: Int64(value), timescale: 1)
                
                player?.seek(to: seekTime, completionHandler: { (completedSeek) in
                    //perhaps do something later here
                })
            }
        }
        
    }
    
}
