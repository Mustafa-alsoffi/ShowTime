//
//  helpers.swift
//  ShowTime
//
//  Created by Mustafa Alsoffi on 13/04/2019.
//  Copyright © 2019 Mustafa Alsoffi. All rights reserved.
//

import UIKit
import Foundation

extension UINavigationController {
    
    // this function sets the main navigation items in
    func setNavigationitems() {
        
        let search = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchButtonTapped)) //
        let button: UIButton = UIButton(type: UIButton.ButtonType.custom)
        button.setImage(UIImage(named: "sittings"), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(sortButtonTapped), for: UIControl.Event.touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 44, height: 31)
        let editBarButton = UIBarButtonItem(customView: button)
        navigationItem.rightBarButtonItems  = [search, editBarButton]
        navigationItem.rightBarButtonItem?.tintColor = .white
    }
    
    
    @objc func searchButtonTapped () {
        
    }
    
    @objc func sortButtonTapped () {
        
    }
    
    
}

