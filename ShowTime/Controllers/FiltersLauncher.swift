//
//  SettingsLauncher.swift
//  ShowTime
//
//  Created by Mustafa Alsoffi on 31/05/2019.
//  Copyright © 2019 Mustafa Alsoffi. All rights reserved.
//

import UIKit

class FiltersLauncher: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    
    let blackView = UIView()
    let cellId = "cellId"
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.darkGray
        return cv
    }()
    
    let filter: [Filter] = {
        return [Filter(name: "Settings", imageName: "settings"), Filter(name: "Terms & privacy policy", imageName: "privacy"), Filter(name: "Send Feedback", imageName: "feedback"), Filter(name: "Help", imageName: "help"), Filter(name: "Switch Account", imageName: "switch_account"), Filter(name: "Cancel", imageName: "cancel")]
    }()
    
    
    func showFilters() {
        //show menu
        
        if let window = UIApplication.shared.keyWindow {
            
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            window.addSubview(blackView)
            
            window.addSubview(collectionView)
            
            let height: CGFloat = 200
            let y = window.frame.height - height
            let frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            collectionView.frame = frame
            
            blackView.frame = window.frame
            blackView.alpha = 0
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.blackView.alpha = 1
                let frame2 = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
                self.collectionView.frame = frame2
                
            }, completion: nil)
        }
    }
    
    @objc func handleDismiss() {
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 0
            
            if let window = UIApplication.shared.keyWindow {
                let frame3 = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
                self.collectionView.frame = frame3
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FiltersCell
        
        return item
    }
    
    
    override init() {
        super.init()
        //start doing something here maybe....
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(FiltersCell.self, forCellWithReuseIdentifier: cellId)
    }

}
